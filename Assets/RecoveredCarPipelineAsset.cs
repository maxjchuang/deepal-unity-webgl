using UnityEngine;
using UnityEngine.Rendering;
// Explicit draw stages for comparison with the recovered XRP pipeline.
// Cache/overlay/reflection depth passes still require restoration.
public sealed class RecoveredCarPipelineAsset:RenderPipelineAsset {
 protected override RenderPipeline CreatePipeline(){return new RecoveredCarPipeline();}
}
public sealed class RecoveredCarPipeline:RenderPipeline {
 static readonly ShaderTagId forward=new ShaderTagId("ForwardBase");
 protected override void Render(ScriptableRenderContext context,Camera[] cameras){
  foreach(var camera in cameras){
   if(!camera.TryGetCullingParameters(out var parameters))continue;
   var culled=context.Cull(ref parameters);context.SetupCameraProperties(camera);
   var cmd=new CommandBuffer{name="Recovered Car draw stages"};
   var descriptor=new RenderTextureDescriptor(camera.pixelWidth,camera.pixelHeight,RenderTextureFormat.ARGBHalf,24){sRGB=false};
   int frame=Shader.PropertyToID("_RecoveredCarFrame");cmd.GetTemporaryRT(frame,descriptor,FilterMode.Bilinear);
   cmd.SetRenderTarget(frame);cmd.ClearRenderTarget(true,true,camera.backgroundColor);context.ExecuteCommandBuffer(cmd);cmd.Clear();
   var opaque=new DrawingSettings(forward,new SortingSettings(camera){criteria=SortingCriteria.CommonOpaque});
   var opaqueFilter=new FilteringSettings(RenderQueueRange.opaque,camera.cullingMask);
   context.DrawRenderers(culled,ref opaque,ref opaqueFilter);
   var transparent=new DrawingSettings(forward,new SortingSettings(camera){criteria=SortingCriteria.CommonTransparent});
   var transparentFilter=new FilteringSettings(RenderQueueRange.transparent,camera.cullingMask);
   context.DrawRenderers(culled,ref transparent,ref transparentFilter);
   var post=camera.GetComponent<RecoveredPostProcessing>();
   if(post!=null && post.composite!=null)cmd.Blit(frame,BuiltinRenderTextureType.CameraTarget,post.composite);
   else cmd.Blit(frame,BuiltinRenderTextureType.CameraTarget);
   cmd.ReleaseTemporaryRT(frame);context.ExecuteCommandBuffer(cmd);cmd.Release();context.Submit();
  }
 }
}
