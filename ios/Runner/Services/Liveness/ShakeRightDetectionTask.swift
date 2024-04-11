import MLKitFaceDetection

class ShakeRightDetectionTask: ShakeDetectionTask {
    override func process(face: Face) -> Bool {
        var yaw = face.headEulerAngleY
        if yaw < -SHAKE_THRESHOLD && !hasShakeToRight {
            hasShakeToRight = true
        }
        return hasShakeToRight
    }
}
