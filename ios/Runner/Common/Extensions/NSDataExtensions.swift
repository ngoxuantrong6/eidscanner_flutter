import Foundation

extension NSData {
	func castToCPointer<T>() -> T {
		let mem = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T.Type>.size)
		getBytes(mem, length: MemoryLayout<T.Type>.size)
		return mem.move()
	}
}

extension Date {
	var millisecondsSince1970:Int64 {
		return Int64((timeIntervalSince1970 * 1000.0).rounded())
	}

	init(milliseconds:Int64) {
		self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
	}
}
