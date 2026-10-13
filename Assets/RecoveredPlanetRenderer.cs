using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

public sealed class RecoveredPlanetRenderer : MonoBehaviour
{
    public Renderer sun;
    public Material stars,shootingStar;
    public Mesh quad;
    public Camera cameraSource;
    public RecoveredTimeControls timeControls;
    public RecoveredSpecialScenes specialScenes;
    public RecoveredWeatherControls weather;public RecoveredRainRenderer rain;public RecoveredSnowRenderer snow;
    CommandBuffer command;
    bool sunRequested;
    float starsStarted;bool starsActive;float shootingProgress,shootingWait;int shootingCount=3;readonly float[] shootingAngles=new float[3];
    void Start(){command=new CommandBuffer{name="Recovered original stars"};cameraSource.AddCommandBuffer(CameraEvent.BeforeImageEffects,command);}
    [Preserve] public void SetSun(string value){sunRequested=value=="1";}
    void LateUpdate()
    {
        if(command==null)return;command.Clear();
        var visible=!specialScenes.IsSpecial;
        var planetVisibility=Mathf.Pow((visible?1:0)*(weather.selected=="overcast"?0:1)*(1-rain.Density)*(snow.Requested?0:1),4);
        var clear=planetVisibility>=1;
        var name=timeControls.selectedName;
        var sunRatio=name=="night"?.005076142f:name=="evening"?.249358147f:.98939091f;
        sun.sharedMaterial.SetFloat("ratio",sunRequested&&weather.selected!="cloudy"?sunRatio*planetVisibility:0);sun.enabled=sunRequested&&visible&&weather.selected!="cloudy";
        var active=name=="night"&&clear;
        if(active&&!starsActive)starsStarted=Time.time;
        starsActive=active;if(!active)return;
        stars.SetFloat("ratio",1);stars.SetFloat("time",Time.time-starsStarted);
        command.DrawMeshInstancedProcedural(quad,0,stars,0,1024);
        shootingStar.SetFloat("ratio",1);
        if(shootingWait>0)shootingWait-=Time.deltaTime;
        else{
            shootingProgress=Mathf.Min(1,shootingProgress+Time.deltaTime*.75f);
            if(shootingProgress<1)shootingStar.SetFloat("timeShootingStar",shootingProgress);
            else{
                shootingProgress=0;shootingWait=Random.Range(4,7);
                for(int i=0;i<3;i++)shootingAngles[i]=(Random.Range(20,70)-cameraSource.transform.eulerAngles.y)*Mathf.Deg2Rad;
                shootingStar.SetFloatArray("angleShootingStars",shootingAngles);shootingCount=Random.Range(1,4);
            }
        }
        command.DrawMeshInstancedProcedural(quad,0,shootingStar,0,shootingCount);
    }
    void OnDestroy(){if(command==null)return;if(cameraSource!=null)cameraSource.RemoveCommandBuffer(CameraEvent.BeforeImageEffects,command);command.Release();}
}
