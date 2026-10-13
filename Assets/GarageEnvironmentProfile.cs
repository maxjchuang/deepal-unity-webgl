using System;
using UnityEngine;
using UnityEngine.Scripting;
[Preserve]
public sealed class GarageEnvironmentProfile : ScriptableObject
{
    [Serializable] public class Reflection {public string key;public Texture2D texture;}
    public string nameSource;public Vector4 sh0,sh1,sh2;
    public Reflection[] reflections;
    public Texture2D Find(string key){foreach(var entry in reflections)if(entry.key==key)return entry.texture;return null;}
}
