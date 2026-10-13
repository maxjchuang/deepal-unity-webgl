using UnityEngine;using UnityEngine.Experimental.Rendering;
[RequireComponent(typeof(Camera))] public sealed class RecoveredPostProcessing:MonoBehaviour {
 public Material sharpen,copy;public bool sharpenEnabled=true;public float sharpness=.14f;
 public Material fxaa;public bool fxaaEnabled=true;public Material composite;public Material[] bloomPasses;public float bloomRadius=2.39f,bloomIntensity=.2f;public bool bloomEnabled=true;
 RenderTexture Allocate(int width,int height){var d=new RenderTextureDescriptor(Mathf.Max(1,width),Mathf.Max(1,height)){graphicsFormat=GraphicsFormat.R8G8B8A8_SRGB,depthBufferBits=0,msaaSamples=1};var rt=RenderTexture.GetTemporary(d);rt.filterMode=FilterMode.Bilinear;rt.wrapMode=TextureWrapMode.Clamp;return rt;}
 void ClipBlit(RenderTexture source,RenderTexture destination,Material material,Vector4 rect){var previous=RenderTexture.active;RenderTexture.active=destination;GL.Clear(false,true,Color.clear);RenderTexture.active=previous;material.SetVector("_ClipRect",rect);Graphics.Blit(source,destination,material,0);}
 void Finish(RenderTexture source,RenderTexture destination){
  var frame=Allocate(source.width,source.height);RenderTexture sharpened=null;
  try{
   Graphics.Blit(source,frame,composite,0);
   var region=GetComponent<RecoveredBloomRegion>();var rect=region!=null?region.Calculate(GetComponent<Camera>()):new Vector4(0,0,1,1);
   RenderTexture current=frame;
   if(sharpenEnabled&&sharpen!=null){
    sharpened=Allocate(frame.width,frame.height);Graphics.Blit(frame,sharpened);
    sharpen.SetFloat("sharpness",sharpness);sharpen.SetVector("_rcpFrame",new Vector4(1f/frame.width,1f/frame.height,0,0));sharpen.SetVector("_ClipRect",rect);
    Graphics.Blit(frame,sharpened,sharpen,0);current=sharpened;
   }
   if(copy!=null){copy.SetVector("_ClipRect",new Vector4(0,0,1,1));Graphics.Blit(current,destination,copy,0);}else Graphics.Blit(current,destination);
   if(fxaaEnabled&&fxaa!=null){fxaa.SetVector("_rcpFrame",new Vector4(1f/frame.width,1f/frame.height,0,0));fxaa.SetVector("_rcpFrameOpt",new Vector4(2f/frame.width,2f/frame.height,.5f/frame.width,.5f/frame.height));fxaa.SetVector("_ClipRect",rect);Graphics.Blit(current,destination,fxaa,0);}
  }finally{if(sharpened!=null)RenderTexture.ReleaseTemporary(sharpened);RenderTexture.ReleaseTemporary(frame);}
 }
 void OnRenderImage(RenderTexture source,RenderTexture destination){
  if(composite==null){Graphics.Blit(source,destination);return;}
  if(!bloomEnabled||bloomPasses==null||bloomPasses.Length!=4){composite.SetFloat("_BloomIntensity",0);Finish(source,destination);return;}
  float logh=Mathf.Log(Mathf.Min(source.width,source.height),2)+bloomRadius-8;int raw=(int)logh;int levels=bloomRadius==0?0:Mathf.Clamp(raw,2,8);float scale=.5f+logh-raw;
  foreach(var pass in bloomPasses)pass.SetFloat("_SampleScale",scale);
  var region=GetComponent<RecoveredBloomRegion>();var rect=region!=null?region.Calculate(GetComponent<Camera>()):new Vector4(0,0,1,1);
  var down=new RenderTexture[levels+1];var up=new RenderTexture[levels];
  try{
   down[0]=Allocate(source.width,source.height);ClipBlit(source,down[0],bloomPasses[0],rect);
   for(int i=1;i<=levels;i++){down[i]=Allocate(source.width>>i,source.height>>i);ClipBlit(down[i-1],down[i],bloomPasses[i==1?1:2],rect);}
   RenderTexture current=down[levels];for(int i=levels-1;i>=1;i--){up[i]=Allocate(down[i].width,down[i].height);bloomPasses[3].SetTexture("_BaseTex",down[i]);ClipBlit(current,up[i],bloomPasses[3],rect);current=up[i];}
   composite.SetTexture("_BloomTex",current);composite.SetFloat("_BloomIntensity",bloomIntensity);
   composite.SetVector("rectRenderClipBloom",new Vector4((rect.x+rect.z)*.5f,(rect.y+rect.w)*.5f,2000/Mathf.Max(.000001f,rect.z-rect.x),2000/Mathf.Max(.000001f,rect.w-rect.y)));Finish(source,destination);
  }finally{composite.SetTexture("_BloomTex",Texture2D.blackTexture);foreach(var rt in down)if(rt!=null)RenderTexture.ReleaseTemporary(rt);foreach(var rt in up)if(rt!=null)RenderTexture.ReleaseTemporary(rt);}
 }
}
