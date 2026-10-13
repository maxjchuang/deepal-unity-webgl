using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

public sealed class RecoveredSnowRenderer : MonoBehaviour
{
    public RecoveredSnowSimulation simulation;
    public Camera cameraSource;
    public Mesh drawQuad;
    public Texture2D collisionSurface;public RecoveredCollisionSurface dynamicCollision;
    public RecoveredSpecialScenes specialScenes;
    public bool Requested {get;private set;}
    CommandBuffer command;
    float started,stopAt=-1;
    void Start()
    {
        cameraSource.cullingMask&=~(1<<31);
        command=new CommandBuffer{name="Recovered original S07 snow"};
        cameraSource.AddCommandBuffer(CameraEvent.BeforeImageEffects,command);
    }
    [Preserve] public void SetSnow(string value)
    {
        Requested=value=="1";
        if(value=="1"){if(!simulation.IsPlaying){simulation.emissionRate=850;simulation.Play(dynamicCollision.Refresh());started=Time.time;}simulation.emissionRate=850;stopAt=-1;}
        else if(simulation.IsPlaying){simulation.emissionRate=0;if(stopAt<0)stopAt=Time.time+10;}
    }
    [Preserve] public void SetSnowImmediate(string value){if(value=="1")SetSnow(value);else{Requested=false;simulation.Stop();stopAt=-1;command?.Clear();}}
    void LateUpdate()
    {
        if(command==null)return;
        command.Clear();
        if(!simulation.IsPlaying)return;
        if(stopAt>=0&&Time.time>stopAt){simulation.Stop();stopAt=-1;return;}
        dynamicCollision.Refresh();
        simulation.Advance(Time.time-started);
        if(specialScenes.IsSpecial)return;
        simulation.BindDraw();
        command.DrawMeshInstancedProcedural(drawQuad,0,simulation.programs.draw,0,RecoveredSnowSimulation.Slots);
    }
    void OnDestroy()
    {
        if(command==null)return;
        if(cameraSource!=null)cameraSource.RemoveCommandBuffer(CameraEvent.BeforeImageEffects,command);
        command.Release();
    }
}
