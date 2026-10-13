using UnityEngine;
public sealed class RecoveryStatus : MonoBehaviour
{
    public int missingShaders;
    void OnGUI() {
        GUI.Box(new Rect(12,12,550,85),"S07 resource recovery preview\nOriginal coordinate system / complete exported hierarchy\nFallback material assignments: "+missingShaders+"; animation and scene logic pending.");
    }
}
