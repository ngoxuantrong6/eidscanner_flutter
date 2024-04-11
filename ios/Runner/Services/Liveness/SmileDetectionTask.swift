import MLKitFaceDetection

class SmileDetectionTask : DetectionTask {
    func process(face: Face) -> Bool {
        var isSmile = (face.hasSmilingProbability ? face.smilingProbability : 0) > 0.67
        return isSmile && DetectionUtils.isFacing(face: face)
    }
}
