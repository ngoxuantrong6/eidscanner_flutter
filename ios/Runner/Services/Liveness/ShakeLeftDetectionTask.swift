import MLKitFaceDetection

class ShakeLeftDetectionTask: ShakeDetectionTask {
    override func process(face: Face) -> Bool {
        var yaw = face.headEulerAngleY
        if yaw > SHAKE_THRESHOLD && !hasShakeToLeft {
            hasShakeToLeft = true
        }
        return hasShakeToLeft
    }
}
