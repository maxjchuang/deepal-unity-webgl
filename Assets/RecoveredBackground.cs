using UnityEngine;
public sealed class RecoveredBackground:MonoBehaviour
{
 public Camera cameraSource;
 void Awake(){GetComponent<MeshRenderer>().enabled=false;}
 [UnityEngine.Scripting.Preserve] public void SetMode(string mode){bool festival=mode=="festival";GetComponent<MeshRenderer>().enabled=festival;foreach(var name in new[]{"NativeSky","NativeFloor"}){var go=GameObject.Find(name);if(go!=null)go.GetComponent<MeshRenderer>().enabled=!festival;}}
 void LateUpdate(){float distance=100;float height=2*distance*Mathf.Tan(cameraSource.fieldOfView*Mathf.Deg2Rad*.5f);transform.localPosition=new Vector3(0,0,distance);transform.localRotation=Quaternion.identity;transform.localScale=new Vector3(height*cameraSource.aspect,height,1);}
}
