using UnityEngine;

// Original GPU stages retained in the player for the particle controller recovery.
// No simulation is enabled until its buffer, emission and collision bindings are restored.
public sealed class RecoveredSnowPrograms : MonoBehaviour
{
    public Material emit, update, draw;
}
