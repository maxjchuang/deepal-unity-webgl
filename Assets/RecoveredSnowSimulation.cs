using System;
using UnityEngine;

// Native GPU stages and buffer lifecycle. The caller must provide the recovered
// collision surface; this class never substitutes a ground plane for the car.
public sealed class RecoveredSnowSimulation : MonoBehaviour
{
    public RecoveredSnowPrograms programs;
    public Mesh quad;
    public const int Width=128, Height=64, Slots=8192;
    public const float Step=1f/60f, StartDelay=.01f;
    public int bufferWidth=Width,bufferHeight=Height,slotCount=Slots,initialRate=850;
    public int FrameIndex {get;private set;}
    public float LastDelta {get;private set;}
    public float emissionRate=850, driving;
    public bool IsPlaying { get; private set; }
    public RenderTexture Positions => buffers[index,0];
    public RenderTexture Velocities => buffers[index,1];
    readonly RenderTexture[,] buffers=new RenderTexture[2,2];
    Texture collision;
    int index;
    float lastAge, cursor;

    public void Play(Texture collisionSurface)
    {
        if(collisionSurface==null)throw new ArgumentNullException(nameof(collisionSurface));
        collision=collisionSurface;
        Allocate();lastAge=0;cursor=0;FrameIndex=0;LastDelta=0;
        Bind(programs.emit);
        programs.emit.SetInteger("numParticle",slotCount);
        programs.emit.SetInteger("rateNum",initialRate);
        Execute(programs.emit);IsPlaying=true;
    }

    public void Stop() { IsPlaying=false; }

    // AParticle.processCmd uses elapsed time and a strict minimum-step gate,
    // then processes the whole elapsed delta once, without fixed substeps.
    public bool Advance(float age)
    {
        if(!IsPlaying)return false;
        var delta=age-lastAge;
        if(delta<=Step)return false;
        var amount=Mathf.Min(age/StartDelay,1)*emissionRate*delta;
        var end=cursor+amount;
        if(end>slotCount){cursor=0;end=amount;}
        var startID=amount>0?Mathf.FloorToInt(cursor):slotCount;
        var endID=amount>0?Mathf.FloorToInt(end):slotCount;
        cursor=end;lastAge=age;LastDelta=delta;FrameIndex++;
        var material=programs.update;Bind(material);
        material.SetTexture("texCollision",collision);
        material.SetFloat("deltaTime",delta);
        material.SetFloat("driving",driving);
        material.SetInteger("startID",startID);material.SetInteger("endID",endID);
        material.SetVector("timePeriod",new Vector4(Mathf.Repeat(age,1),Mathf.Repeat(age,6.283185482f),Mathf.Repeat(age,2),Mathf.Repeat(age,4096)));
        Execute(material);return true;
    }

    void Allocate()
    {
        if(buffers[0,0]!=null)return;
        for(int side=0;side<2;side++)for(int channel=0;channel<2;channel++)
        {
            var rt=new RenderTexture(bufferWidth,bufferHeight,0,RenderTextureFormat.ARGBHalf,RenderTextureReadWrite.Linear){name="NativeSnow_"+side+"_"+channel,filterMode=FilterMode.Point,wrapMode=TextureWrapMode.Clamp};
            rt.Create();buffers[side,channel]=rt;
            var previous=RenderTexture.active;RenderTexture.active=rt;GL.Clear(false,true,Color.clear);RenderTexture.active=previous;
        }
    }
    void Bind(Material material)
    {
        material.SetInteger("wParticleRT",bufferWidth);
        material.SetTexture("ParticleBufferRT0",Positions);material.SetTexture("ParticleBufferRT1",Velocities);
        material.SetVector("processRange",new Vector4(0,1,0,0));
    }
    void Execute(Material material)
    {
        var previous=RenderTexture.active;var target=1-index;var culling=GL.invertCulling;
        try
        {
            // Preserve the original clip-space quad orientation on top-origin backends.
            if(SystemInfo.graphicsUVStartsAtTop)GL.invertCulling=!culling;
            Graphics.SetRenderTarget(new[]{buffers[target,0].colorBuffer,buffers[target,1].colorBuffer},buffers[target,0].depthBuffer);
            if(!material.SetPass(0))throw new InvalidOperationException("Snow GPU pass unavailable: "+material.name);
            Graphics.DrawMeshNow(quad,Matrix4x4.identity);index=target;
        }
        finally { GL.invertCulling=culling;RenderTexture.active=previous; }
    }
    public void BindDraw()
    {
        Bind(programs.draw);
    }
    void OnDestroy()
    {
        foreach(var rt in buffers)if(rt!=null){rt.Release();if(Application.isPlaying)Destroy(rt);else DestroyImmediate(rt);}
    }
}
