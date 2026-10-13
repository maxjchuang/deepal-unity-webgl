using UnityEngine;

// Math recovered from original XInput.CamController and InputMgr ARM64 code.
// Active preset ranges and pose must be supplied by the caller for each view/model.
public static class RecoveredCameraMath
{
    public static Vector2 MouseRotationPoint(Vector2 pixels, float screenHeight) { return pixels / screenHeight; }
    public static Vector2 TouchRotationPoint(Vector2 pixels, float screenHeight) { return pixels * (2f / screenHeight); }
    public static float WheelDistance(float scrollY) { return scrollY * 32f; }
    public static float Wrap(float value, float min, float max)
    {
        while (value >= max) value -= 360;
        while (value < min) value += 360;
        return value;
    }
    public static float ClampAngle(float value, Vector2 range)
    {
        if (range.x <= range.y) return Mathf.Clamp(value, range.x, range.y);
        if (value >= range.x || value <= range.y) return value;
        return Mathf.Abs(value-range.y) <= Mathf.Abs(value-range.x) ? range.y : range.x;
    }
    public static Vector2 RotationTarget(Vector2 startAngles, Vector2 startPoint, Vector2 point, float speed, bool reverse, Vector2 yawRange, Vector2 pitchRange)
    {
        float signedSpeed = reverse ? -speed : speed;
        Vector2 delta = (point-startPoint)*signedSpeed;
        return new Vector2(ClampAngle(Wrap(startAngles.x+delta.x,0,360),yawRange),
            ClampAngle(Wrap(startAngles.y-delta.y,-180,180),pitchRange));
    }
    public static float DollyOffset(float startDistance, float distance, float dollyStart, float speed, float speedBase, float speedRatio)
    {
        float result = (distance-startDistance)*speed;
        if (speedBase > 0) result *= 1+(Mathf.Abs(dollyStart/speedBase)-1)*Mathf.Clamp01(speedRatio);
        return result;
    }
    public static float FovTarget(float startFov, float offset, Vector2 range) { return Mathf.Clamp(startFov-offset,range.x,range.y); }
    public static float PosZTarget(float startPosZ, float offset, Vector2 range) { return Mathf.Clamp(startPosZ+offset,range.x,range.y); }
    public static float DampAngle(float current, float target, float deltaTime, float speed)
    {
        if (current > target) { while (current-target>180) current-=360; }
        else { while (target-current>180) target-=360; }
        return current+(target-current)*Mathf.Clamp01(deltaTime*speed);
    }
    public static float DampScalar(float current, float target, float deltaTime, float speed)
    { return current+(target-current)*Mathf.Clamp01(deltaTime*speed); }
    public static Vector3 Position(Vector3 origin, float yaw, float pitch, float roll, float posZ, float yawOffsetFix)
    { return origin+Quaternion.Euler(pitch,yaw,roll)*new Vector3(0,0,posZ)+new Vector3(0,0,Mathf.Cos(yaw*Mathf.Deg2Rad)*yawOffsetFix); }
}
