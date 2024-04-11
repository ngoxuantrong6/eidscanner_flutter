import QKMRZScanner
import eidsdk

let ONBOARDDATAMANAGER = OnboardDataManager.shared

class OnboardDataManager: NSObject {

    var mrzKey: String = ""
    var mrz: QKMRZScanResult?
    var eid: NfcEidModel?
    
    // --------------------------------------
    // MARK: Singleton
    // --------------------------------------
    
    class var shared: OnboardDataManager {
        struct Static {
            static let instance = OnboardDataManager()
        }
        return Static.instance
    }
    
    override init() {
    }
}
