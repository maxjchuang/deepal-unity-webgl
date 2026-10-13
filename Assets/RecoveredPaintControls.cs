using UnityEngine;
using UnityEngine.Scripting;

// Material-copy endpoints captured from the native S07 API, including orange trim.
public class RecoveredPaintControls : MonoBehaviour
{
    public Material[] palette;
    public Material body, change, change1, change2, change3, blackTrim, silverTrim;
    public int selected;

    void Start() { SetPaint("0"); }

    [Preserve]
    public void SetPaint(string value)
    {
        if (!int.TryParse(value, out var index) || palette == null ||
            index < 0 || index >= palette.Length || palette[index] == null) return;
        var paint = palette[index];
        Copy(body, paint);
        Copy(change, index == 5 ? blackTrim : paint);
        Copy(change1, palette[5]);
        Copy(change2, index == 5 ? blackTrim : silverTrim);
        Copy(change3, index == 5 ? paint : blackTrim);
        selected = index;
        Debug.Log("Recovered S07 paint " + index + ": " + paint.name);
    }

    static void Copy(Material target, Material source)
    {
        if (target != null && source != null) target.CopyPropertiesFromMaterial(source);
    }
}
