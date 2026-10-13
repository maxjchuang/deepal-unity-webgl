using UnityEngine;
using UnityEngine.Scripting;

// Original XInput.CamController math, fed by Unity's own WebGL legacy input normalization.
public sealed class RecoveryOrbit : MonoBehaviour
{
    public Vector3 target;public bool navigationEnabled=true;
    public float speedRot=150,speedDolly=.05f,speedDampRot=5,speedDampDolly=5;
    RecoveredViewControls.Preset home,pose;
    float targetYaw,targetPitch,targetFov,targetPosZ;
    Vector2 startPoint,startAngles;float startDistance,startFov,startPosZ;
    int fingers;bool mouseRotating,mousePanning;Camera cameraSource;Vector2 panStart;Vector3 panOrigin,targetOrigin;Bounds panBounds;
    void Start(){cameraSource=GetComponent<Camera>();var views=GetComponent<RecoveredViewControls>();foreach(var state in views.states)if(state.name=="default"){SetNativePreset(state.preset);break;}Application.targetFrameRate=30;
#if UNITY_WEBGL && !UNITY_EDITOR
        WebGLInput.captureAllKeyboardInput=false;
#endif
    }
    public void SetNativePreset(RecoveredViewControls.Preset value){cameraSource=GetComponent<Camera>();home=Clone(value);pose=Clone(value);targetYaw=pose.yaw;targetPitch=pose.pitch;targetFov=pose.fov;targetPosZ=pose.posZ;fingers=0;mouseRotating=false;mousePanning=false;targetOrigin=pose.origin;panBounds=value.isLimitRange?new Bounds(value.origin+new Vector3((value.extentRangeX.x+value.extentRangeX.y)*.5f,(value.extentRangeY.x+value.extentRangeY.y)*.5f,(value.extentRangeZ.x+value.extentRangeZ.y)*.5f),new Vector3(value.extentRangeX.y-value.extentRangeX.x,value.extentRangeY.y-value.extentRangeY.x,value.extentRangeZ.y-value.extentRangeZ.x)):new Bounds(Vector3.zero,Vector3.one*10000);Apply();}
    static RecoveredViewControls.Preset Clone(RecoveredViewControls.Preset value){return JsonUtility.FromJson<RecoveredViewControls.Preset>(JsonUtility.ToJson(value));}
    public RecoveredViewControls.Preset GetNativePreset(){return Clone(pose??home);}
    void BeginRotation(Vector2 point){startPoint=point;startAngles=new Vector2(pose.yaw,pose.pitch);}
    void Rotate(Vector2 point){var angles=RecoveredCameraMath.RotationTarget(startAngles,startPoint,point,speedRot,pose.isPitchReverse,pose.yawRange,pose.pitchRange);targetYaw=angles.x;targetPitch=angles.y;}
    void BeginDolly(float distance){startDistance=distance;startFov=pose.fov;startPosZ=pose.posZ;}
    void Dolly(float distance){float offset=RecoveredCameraMath.DollyOffset(startDistance,distance,pose.zoomMode==1?startFov:startPosZ,speedDolly,0,1);if(pose.zoomMode==1)targetFov=RecoveredCameraMath.FovTarget(startFov,offset,pose.fovRange);else targetPosZ=RecoveredCameraMath.PosZTarget(startPosZ,offset,pose.posZRange);}
    void BeginPan(Vector2 point){panStart=point;panOrigin=pose.origin;}
    void Pan(Vector2 point){var delta=-(point-panStart)/Screen.width*200*(pose.zoomMode==1?pose.fov:Mathf.Abs(pose.posZ));targetOrigin=panBounds.ClosestPoint(panOrigin+transform.right*delta.x+transform.up*delta.y);}
    void Update()
    {
        if(!navigationEnabled||pose==null)return;
        int count=Input.touchCount;
        if(count>0){
            if(count!=fingers){fingers=count;if(count==1)BeginRotation(RecoveredCameraMath.TouchRotationPoint(Input.GetTouch(0).position,Screen.height));else if(count==2){BeginDolly(Vector2.Distance(Input.GetTouch(0).position,Input.GetTouch(1).position));BeginPan((Input.GetTouch(0).position+Input.GetTouch(1).position)*.5f/Screen.height);}}
            if(count==1)Rotate(RecoveredCameraMath.TouchRotationPoint(Input.GetTouch(0).position,Screen.height));else if(count==2){Dolly(Vector2.Distance(Input.GetTouch(0).position,Input.GetTouch(1).position));Pan((Input.GetTouch(0).position+Input.GetTouch(1).position)*.5f/Screen.height);}
        }else{
            fingers=0;var point=new Vector2(Input.mousePosition.x,Input.mousePosition.y);
            if(Input.GetMouseButtonDown(0)&&point.x>=0&&point.x<=Screen.width&&point.y>=0&&point.y<=Screen.height){mouseRotating=true;BeginRotation(RecoveredCameraMath.MouseRotationPoint(point,Screen.height));}
            if(mouseRotating&&Input.GetMouseButton(0))Rotate(RecoveredCameraMath.MouseRotationPoint(point,Screen.height));
            if(Input.GetMouseButtonUp(0))mouseRotating=false;
            if(Input.GetMouseButtonDown(2)){mousePanning=true;BeginPan(point/Screen.height);}
            if(mousePanning&&Input.GetMouseButton(2))Pan(point/Screen.height);
            if(Input.GetMouseButtonUp(2))mousePanning=false;
            if(Input.mouseScrollDelta.y!=0){BeginDolly(0);Dolly(RecoveredCameraMath.WheelDistance(Input.mouseScrollDelta.y));}
        }
        if(Mathf.Abs(Mathf.DeltaAngle(pose.yaw,targetYaw))>.1f||Mathf.Abs(Mathf.DeltaAngle(pose.pitch,targetPitch))>.1f){pose.yaw=RecoveredCameraMath.DampAngle(pose.yaw,targetYaw,Time.deltaTime,speedDampRot);pose.pitch=RecoveredCameraMath.DampAngle(pose.pitch,targetPitch,Time.deltaTime,speedDampRot);}
        if(Mathf.Abs(pose.fov-targetFov)>.1f)pose.fov=RecoveredCameraMath.DampScalar(pose.fov,targetFov,Time.deltaTime,speedDampDolly);
        if(Mathf.Abs(pose.posZ-targetPosZ)>.001f)pose.posZ=RecoveredCameraMath.DampScalar(pose.posZ,targetPosZ,Time.deltaTime,speedDampDolly);
        if((pose.origin-targetOrigin).sqrMagnitude>.001f)pose.origin=Vector3.Lerp(pose.origin,targetOrigin,Mathf.Clamp01(Time.deltaTime*5));
        Apply();
    }
    void Apply(){transform.SetPositionAndRotation(RecoveredCameraMath.Position(pose.origin,pose.yaw,pose.pitch,pose.roll,pose.posZ,pose.yawOffsetFix),Quaternion.Euler(pose.pitch,pose.yaw,pose.roll));cameraSource.fieldOfView=pose.fov;}
    [Preserve]public void ResetView(string ignored){if(navigationEnabled&&home!=null)SetNativePreset(home);}
}
