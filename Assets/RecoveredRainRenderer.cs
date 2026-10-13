using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

public sealed class RecoveredRainRenderer : MonoBehaviour
{
    public RecoveredSnowSimulation drops;
    public RecoveredCollisionSurface collision;
    public Material ringUpdate,ringDraw;
    public Mesh drawQuad,computeQuad;
    public Camera cameraSource;
    public RecoveredSpecialScenes specialScenes;
    readonly RenderTexture[,] rings=new RenderTexture[2,2];
    public bool Requested {get;private set;}
    public float density=.6f;
    public float Density=>Requested?density:0;
    int index;float started,stopAt=-1;CommandBuffer command;
    void Start(){command=new CommandBuffer{name="Recovered original rain"};cameraSource.AddCommandBuffer(CameraEvent.BeforeImageEffects,command);}
    [Preserve] public void SetRain(string value)
    {
        Requested=value=="1";
        if(value=="1"){if(!drops.IsPlaying){Allocate();drops.emissionRate=Mathf.RoundToInt(850*density);drops.Play(collision.Refresh());started=Time.time;}drops.emissionRate=Mathf.RoundToInt(850*density);stopAt=-1;}
        else if(drops.IsPlaying){drops.emissionRate=0;if(stopAt<0)stopAt=Time.time+6;}
    }
    [Preserve] public void SetRainImmediate(string value){if(value=="1")SetRain(value);else{Requested=false;drops.Stop();stopAt=-1;command?.Clear();}}
    void Allocate()
    {
        if(rings[0,0]!=null)return;
        for(int side=0;side<2;side++)for(int channel=0;channel<2;channel++)
        {
            var rt=new RenderTexture(64,32,0,channel==0?RenderTextureFormat.ARGBHalf:RenderTextureFormat.ARGB32,RenderTextureReadWrite.Linear){name="NativeRainRing_"+side+"_"+channel,filterMode=FilterMode.Point,wrapMode=TextureWrapMode.Clamp};
            rt.Create();rings[side,channel]=rt;var old=RenderTexture.active;RenderTexture.active=rt;GL.Clear(false,true,Color.clear);RenderTexture.active=old;
        }
    }
    void LateUpdate()
    {
        if(command==null)return;command.Clear();if(!drops.IsPlaying)return;
        if(stopAt>=0&&Time.time>stopAt){drops.Stop();stopAt=-1;return;}
        var surface=collision.Refresh();var age=Time.time-started;
        if(drops.Advance(age))UpdateRings(surface,age);
        if(specialScenes.IsSpecial)return;
        drops.BindDraw();
        ringDraw.SetInteger("wParticleRT",64);ringDraw.SetTexture("ParticleBufferRT0",rings[index,0]);ringDraw.SetTexture("ParticleBufferRT1",rings[index,1]);
        ringDraw.SetVector("timePeriod",new Vector4(Mathf.Repeat(age,1),Mathf.Repeat(age,6.283185482f),Mathf.Repeat(age,2),Mathf.Repeat(age,4096)));
        ringDraw.SetFloat("driving",drops.driving);
        command.DrawMeshInstancedProcedural(drawQuad,0,drops.programs.draw,0,4096);
        command.DrawMeshInstancedProcedural(drawQuad,0,ringDraw,0,2048);
    }
    void UpdateRings(Texture surface,float age)
    {
        ringUpdate.SetTexture("ParticleBufferRT0",rings[index,0]);ringUpdate.SetTexture("ParticleBufferRT1",rings[index,1]);
        ringUpdate.SetTexture("ParticleExBufferRT0",drops.Positions);ringUpdate.SetTexture("texCollision",surface);
        ringUpdate.SetInteger("numParticle",2048);ringUpdate.SetInteger("wParticleRT",64);ringUpdate.SetInteger("wParticleExRT",64);ringUpdate.SetInteger("indexFramePeriod",drops.FrameIndex%2);
        ringUpdate.SetFloat("deltaTime",drops.LastDelta);ringUpdate.SetFloat("driving",drops.driving);ringUpdate.SetVector("processRange",new Vector4(0,1,0,0));
        var old=RenderTexture.active;var culling=GL.invertCulling;var target=1-index;
        try{if(SystemInfo.graphicsUVStartsAtTop)GL.invertCulling=!culling;Graphics.SetRenderTarget(new[]{rings[target,0].colorBuffer,rings[target,1].colorBuffer},rings[target,0].depthBuffer);if(ringUpdate.SetPass(0)){Graphics.DrawMeshNow(computeQuad,Matrix4x4.identity);index=target;}}
        finally{GL.invertCulling=culling;RenderTexture.active=old;}
    }
    void OnDestroy(){if(command!=null){if(cameraSource!=null)cameraSource.RemoveCommandBuffer(CameraEvent.BeforeImageEffects,command);command.Release();}foreach(var rt in rings)if(rt!=null){rt.Release();Destroy(rt);}}
}
