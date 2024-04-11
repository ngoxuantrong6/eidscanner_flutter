import UIKit

let MODULESMANAGER = ModulesManager.shared

@objc protocol ModulesProtocol {
    @objc var tag: String { get }
    @objc var title: String { get }
    @objc var iconImageName: String { get }
}

class ScanModule: ModulesProtocol {
    var tag: String = "scan"
    var title: String = LOCALIZED("title_scan")
    var iconImageName: String =  "icon_scan"
    required init() {}
}

class EKycModule: ModulesProtocol {
    var tag: String = "scan"
    var title: String = LOCALIZED("title_ekyc")
    var iconImageName: String =  "icon_peoplescan"
    required init() {}
}

class ModulesManager: NSObject {
    
    private var _allModules: [ModulesProtocol];

    // --------------------------------------
    // MARK: Singleton
    // --------------------------------------
    
    class var shared: ModulesManager {
        struct Static {
            static let instance = ModulesManager()
        }
        return Static.instance
    }
    
    override init() {
        _allModules = [
            ScanModule.init(),
            EKycModule.init()
        ]
        super.init()
    }
    
    // --------------------------------------
    // MARK: Public
    // --------------------------------------
    
    func getAllModules() -> [ModulesProtocol] {
        return _allModules
    }
    
    func clear() {
        _allModules.removeAll()
    }
    
    func initController(_ tag: String) -> UIViewController {
        switch (tag) {
            case "scan": return INIT_CONTROLLER_XIB(ScanMainViewController.self)
            case "ekyc": return INIT_CONTROLLER_XIB(ScanMainViewController.self)
            default: return INIT_CONTROLLER_XIB(ScanMainViewController.self)
        }
    }

}
