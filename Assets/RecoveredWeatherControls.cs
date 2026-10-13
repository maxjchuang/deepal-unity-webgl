using System;
using UnityEngine;
using UnityEngine.Scripting;

// Original shader and captured native endpoints. Weather transitions are pending.
public sealed class RecoveredWeatherControls : MonoBehaviour
{
    [Serializable] public class State : RecoveredTimeControls.State
    {
        public string timeName, appearance, weather, skyFile;
        public Vector4 skyColor, cloudParams, cloudTiling, cloudAnimation, cloudLighting, sh0, sh1, sh2;
        public Texture2D sky;
    }
    [Serializable] public class Catalog { public State[] states; }
    public State[] states;
    public Renderer cloud;
    public RecoveredTimeControls timeControls;
    public RecoveredSpecialScenes specialScenes;
    public string selected = "clear";

    [Preserve] public void SetWeather(string name)
    {
        if (name != "clear" && name != "cloudy" && name != "overcast") return;
        selected = name;
        timeControls.SetTime(timeControls.selectedName);
    }

    public void Refresh()
    {
        cloud.enabled = false;
        if (specialScenes.IsSpecial) return;
        var appearance = specialScenes.IsDark ? "dark" : "bright";
        foreach (var state in states)
        {
            if (state.timeName != timeControls.selectedName || state.appearance != appearance || state.weather != selected) continue;
            timeControls.Apply(state);
            var scene = timeControls.scene;
            scene.sky = state.sky;
            scene.skyColor = state.skyColor;
            var light = timeControls.lighting;
            light.sh0 = state.sh0; light.sh1 = state.sh1; light.sh2 = state.sh2;
            cloud.sharedMaterial.SetVector("_FlatCloudsParams", state.cloudParams);
            cloud.sharedMaterial.SetVector("_FlatCloudsTiling", state.cloudTiling);
            cloud.sharedMaterial.SetVector("_FlatCloudsAnimation", state.cloudAnimation);
            cloud.sharedMaterial.SetVector("_FlatCloudsLightingParams", state.cloudLighting);
            cloud.enabled = selected == "cloudy";
            return;
        }
    }

    void LateUpdate()
    {
        if (specialScenes.IsSpecial) cloud.enabled=false;
        Shader.SetGlobalFloat("densitySkySystem", 1);
        Shader.SetGlobalFloat("_GlobalTime", Time.time);
    }
}
