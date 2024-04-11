import MLKitFaceDetection
import MLKitVision
import UIKit

class DetectionUtils {
    
    class private func _lengthSquare(a: VisionPoint, b: VisionPoint) -> CGFloat {
        var x = a.x - b.x
        var y = a.y - b.y
        return x * x + y * y
    }
    
    class func isFacing(face: Face) -> Bool {
        return face.headEulerAngleZ < 7.78 && face.headEulerAngleZ > -7.78
        && face.headEulerAngleY < 11.8 && face.headEulerAngleY > -11.8
        && face.headEulerAngleX < 19.8 && face.headEulerAngleX > -19.8
    }
    
    class func isMouthOpen(face: Face) -> Bool {
        guard let left = face.landmark(ofType: .mouthLeft)?.position else { return false }
        guard let right = face.landmark(ofType: .mouthRight)?.position else { return false }
        guard let bottom = face.landmark(ofType: .mouthBottom)?.position else { return false }
        
        // Square of lengths be a2, b2, c2
        var a2 = _lengthSquare(a: right, b: bottom)
        var b2 = _lengthSquare(a: left, b: bottom)
        var c2 = _lengthSquare(a: left, b: right)
        
        // Length of sides be a, b, c
        var a = sqrt(a2)
        var b = sqrt(b2)
        
        // From Cosine law
        var gamma = acos((a2 + b2 - c2) / (2 * a * b))
        
        // Converting to degrees
        var gammaDeg = gamma * 180 / CGFloat.pi
        return gammaDeg < 115.0
    }
    
    class func isFaceInDetectionRect(face: Face, detectionSize: Int) -> Bool {
        var frame = face.frame
        var fx = frame.midX
        var fy = frame.midY
        var gridSize = CGFloat(detectionSize / 8)
        if fx < gridSize * 2 || fx > gridSize * 6 || fy < gridSize * 2 || fy > gridSize * 6 {
            print("face center point is out of rect: (\(fx), \(fy))")
            return false
        }
        var fw = frame.width
        var fh = frame.height
        if fw < gridSize * 3 || fw > gridSize * 6 || fh < gridSize * 3 || fh > gridSize * 6 {
            print("unexpected face size: (\(fx), \(fy)")
            return false
        }
        return true
     }
    
    
}


