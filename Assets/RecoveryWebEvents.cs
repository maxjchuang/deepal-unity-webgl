using System.Runtime.InteropServices;
public static class RecoveryWebEvents
{
#if UNITY_WEBGL && !UNITY_EDITOR
    [DllImport("__Internal")] static extern void DeepalState(string name,string json);
#endif
    public static void Emit(string name,string json)
    {
#if UNITY_WEBGL && !UNITY_EDITOR
        DeepalState(name,json);
#endif
    }
}
