import MLKitFaceDetection
import SwiftCollections

@objc protocol Listener {
    @objc optional func onTaskStarted(task: DetectionTask)
    @objc optional func onTaskCompletd(task: DetectionTask, isLastTask: Bool)
    @objc optional func onTaskFailed(task: DetectionTask, code: Int)
}

class LivenessDetector {
    
    private static var FACE_CACHE_SIZE = 5
    private static var NO_ERROR = -1
    static var ERROR_NO_FACE = 0
    static var ERROR_MULTI_FACES = 1
    static var ERROR_OUT_DETECTION_RECT = 2
    
    private var tasks: [DetectionTask] = []
    private var taskIndex = 0
    private var lastTaskIndex = -1
    private var currentErrorState = NO_ERROR
    private var lastFaces: Deque<Face> = []
    private var listener: Listener?
    
    init(tasks: DetectionTask...) {
        self.tasks = tasks
    }
    
}
