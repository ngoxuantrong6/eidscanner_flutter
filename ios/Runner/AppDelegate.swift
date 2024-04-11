import UIKit
import Flutter
import eidsdk

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let CHANNEL = "read_mrz"
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(withRegistry: self)
    let rootViewController : FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: rootViewController as! FlutterBinaryMessenger)
    methodChannel.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
        if (call.method == "mrz") {
            print("vào setMethodCallHandler")
            
            Thread.sleep(forTimeInterval: 2.0)
            
            print("\n/////////////////////////////////////////////////////////////////////////////////////")
            print("* \(APP.debugInfo)")
            print("* Home directory: \(APP.baseUrl.path)")
            print("\n/////////////////////////////////////////////////////////////////////////////////////")
            
            // Initializations
            BrandManager.setDefaultTheme()
            
            let apiKey = Bundle.main.infoDictionary?["API_KEY"] as! String
            let baseUrl = Bundle.main.infoDictionary?["API_BASE_URL"] as! String
            EIDSERVICE.initialize(apiKey: apiKey, apiBaseUrl: baseUrl)
            
            // Fix header padding
            if #available(iOS 15.0, *) {
                UITableView.appearance().sectionHeaderTopPadding = 0.0
            }
            
            APP.window = UIWindow(frame: UIScreen.main.bounds)
            self.setupRootController(INIT_CONTROLLER_XIB(ScanMainViewController.self), false)
        }
    }
              
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func setupRootController(_ controller: UIViewController, _ isHiddenNavigationBar: Bool = false) {
        let navController = NavigationController(rootViewController: controller)
        navController.setNavigationBarHidden(isHiddenNavigationBar, animated: false)
        let window = UIWindow(frame: UIScreen.main.bounds)
        APP.window = window
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        window.backgroundColor = ColorBrand.gtelBrandBackground
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}

