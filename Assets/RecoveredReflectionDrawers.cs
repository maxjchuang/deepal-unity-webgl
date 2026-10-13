using System;
using UnityEngine;

// Original serialized layer-0 mesh drawers, separate from the visible car meshes.
public sealed class RecoveredReflectionDrawers : MonoBehaviour
{
    [Serializable] public class Binding {public Transform source,target;public Renderer renderer;}
    public Binding[] bindings;
    public RecoveredSpecialScenes specialScenes;
    void LateUpdate()
    {
        foreach(var binding in bindings)
        {
            if(binding.source==null||binding.target==null||binding.renderer==null)continue;
            binding.renderer.enabled=!specialScenes.IsSpecial;
            binding.target.SetPositionAndRotation(binding.source.position,binding.source.rotation);
            binding.target.localScale=binding.source.lossyScale;
        }
    }
}
