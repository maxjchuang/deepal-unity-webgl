using UnityEngine;
// Layer 8 is an adapter for native queue 4000..5000, rendered after the main camera's FX.
[RequireComponent(typeof(Camera))]public sealed class RecoveredOverlayRenderer:MonoBehaviour {
 public Renderer[] overlays;Camera source,overlay;
 void Start(){source=GetComponent<Camera>();var go=new GameObject("NativeOverlayCamera");overlay=go.AddComponent<Camera>();Sync();}
 void LateUpdate(){if(overlay!=null)Sync();}
 void Sync(){overlay.CopyFrom(source);overlay.transform.SetPositionAndRotation(source.transform.position,source.transform.rotation);overlay.cullingMask=1<<8;overlay.clearFlags=CameraClearFlags.Depth;overlay.depth=source.depth+1;overlay.allowHDR=false;overlay.allowMSAA=source.allowMSAA;overlay.enabled=true;}
 void OnDestroy(){if(overlay!=null)Destroy(overlay.gameObject);}
}
