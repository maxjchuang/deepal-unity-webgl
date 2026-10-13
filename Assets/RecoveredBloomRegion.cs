using System;using UnityEngine;
public sealed class RecoveredBloomRegion:MonoBehaviour {
 [Serializable]public class Proxy{public string nodeName,nodeId;public int mirror;public Vector3[] points;public Transform target;}
 [Serializable]public class Catalog{public Proxy[] proxies;}
 public Proxy[] proxies;
 public Vector4 Calculate(Camera camera){
  if(proxies==null||proxies.Length==0)return new Vector4(0,0,1,1);
  var vp=GL.GetGPUProjectionMatrix(camera.projectionMatrix,false)*camera.worldToCameraMatrix;
  float minX=float.MaxValue,minY=float.MaxValue,maxX=float.MinValue,maxY=float.MinValue;
  foreach(var proxy in proxies){if(proxy.target==null||!proxy.target.gameObject.activeInHierarchy)continue;var matrix=vp*proxy.target.localToWorldMatrix;
   foreach(var point in proxy.points){Include(matrix,point,ref minX,ref minY,ref maxX,ref maxY);if(proxy.mirror!=0){var mirror=point;mirror[proxy.mirror-1]=-mirror[proxy.mirror-1];Include(matrix,mirror,ref minX,ref minY,ref maxX,ref maxY);}}
  }
  if(minX==float.MaxValue)return new Vector4(0,0,1,1);
  return new Vector4(Mathf.Max(0,minX*.5f+.5f),Mathf.Max(0,minY*.5f+.5f),Mathf.Min(1,maxX*.5f+.5f),Mathf.Min(1,maxY*.5f+.5f));
 }
 static void Include(Matrix4x4 matrix,Vector3 point,ref float minX,ref float minY,ref float maxX,ref float maxY){var clip=matrix*new Vector4(point.x,point.y,point.z,1);float x=clip.x/clip.w,y=clip.y/clip.w;minX=Mathf.Min(minX,x);minY=Mathf.Min(minY,y);maxX=Mathf.Max(maxX,x);maxY=Mathf.Max(maxY,y);}
}
