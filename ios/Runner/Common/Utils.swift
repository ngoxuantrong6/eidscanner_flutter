import Foundation

class Utils: NSObject {
    
    // --------------------------------------
    // MARK: Strings
    // --------------------------------------
    
    class func stringIsNullOrEmpty(_ string: String?) -> Bool {
        return (string == nil || string == "" || string == "NULL" || string == "null")
    }    
}
