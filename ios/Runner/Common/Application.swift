import UIKit

let APP = Application.shared

class Application: NSObject {
    
    var window: UIWindow?

    // --------------------------------------
    // MARK: Singleton
    // --------------------------------------

    class var shared: Application {
        struct Static {
            static let instance = Application()
        }
        return Static.instance
    }

    override init() {
        super.init()
    }
        
    // --------------------------------------
    // MARK: Public
    // --------------------------------------

    var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    var bundleId: String {
        Bundle.main.bundleIdentifier ?? ""
    }
    
    var displayName: String {
        Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }

    var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    var buildVersion: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }

    var buildMode: String {
        #if DEBUG
            return "DEBUG"
        #else
            return "RELEASE"
        #endif
    }

    var versionText: String {
        let version = "Version \(self.version)"
        let buildVersion = "Build \(self.buildVersion)"
        if buildMode != "RELEASE" {
            return String(format: "%@ #%@ - 07/30/2021 - %@", version, buildVersion, buildMode.uppercased())
        } else {
            return String(format: "%@ #%@ - %@", version, buildVersion, buildMode.uppercased())
        }
    }

    var isAppStoreEnvironment: Bool {
        #if TARGET_OS_IPHONE && !TARGET_IPHONE_SIMULATOR
            return Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") == nil
        #else
            return false
        #endif
    }

    var systemApplication: UIApplication {
        return UIApplication.shared
    }

    var iconBadgeNumber: Int {
        return systemApplication.applicationIconBadgeNumber
    }

    var debugInfo: String {
        return "Application: <BundleId: \(bundleId),  Version: \(version),  Build Mode: \(buildMode.uppercased())," +
            "  AppStoreEnv: \(isAppStoreEnvironment),  Badges: \(iconBadgeNumber)>"
    }
    
    var baseUrl: URL {
        let url = URL(fileURLWithPath: NSHomeDirectory(), isDirectory: true)
        return url
    }
        
    var appState: UIApplication.State {
        return systemApplication.applicationState
    }

    func setIconBadgeNumber(_ iconBadgeNumber: Int) {
        systemApplication.applicationIconBadgeNumber = iconBadgeNumber
    }
}
