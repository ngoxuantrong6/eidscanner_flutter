import UIKit
import SwiftMessages
import FCAlertView

class Graphics: NSObject {
    
    // --------------------------------------
    // MARK: Views
    // --------------------------------------
    
    class func dropShadow(_ view: UIView, opacity: CGFloat, radius: CGFloat, offset: CGSize) {
        dropShadow(view, color: ColorBrand.gtelBrandDarkGray, opacity: opacity, radius: radius, offset: offset)
    }
    
    class func dropShadow(_ view: UIView, color: UIColor?, opacity: CGFloat, radius: CGFloat, offset: CGSize) {
        view.layer.masksToBounds = false
        view.layer.rasterizationScale = UIScreen.main.scale
        view.layer.shouldRasterize = true
        view.layer.shadowColor = color?.cgColor
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = radius
        view.layer.shadowOpacity = Float(opacity)
    }
    
    class func showMessage(_ theme: Theme, body: String) {
        var config = SwiftMessages.Config()
        config.duration = .seconds(seconds: 5)
        config.presentationStyle = .top
        SwiftMessages.show(config: config) {
            let view = MessageView.viewFromNib(layout: .cardView)
            var backgroundColor: UIColor = ColorBrand.gtelBrandGreen
            let foregroundColor: UIColor = ColorBrand.gtelBrandWhite
            var title = ""
            switch theme {
                case .info:
                    backgroundColor = ColorBrand.gtelBrandBlue
                    title = LOCALIZED("message_info")
                case .success:
                    backgroundColor = ColorBrand.gtelBrandGreen
                    title = LOCALIZED("message_success")
                case .warning:
                    backgroundColor = ColorBrand.gtelBrandYellow
                    title = LOCALIZED("message_warning")
                case .error:
                    backgroundColor = ColorBrand.gtelBrandOrange
                    title = LOCALIZED("message_error")
            }
            let iconImage = IconStyle.default.image(theme: theme)
            view.configureTheme(backgroundColor: backgroundColor, foregroundColor: foregroundColor, iconImage: iconImage)
            view.configureContent(title: title, body: body)
            view.button?.setTitle(LOCALIZED("dismiss"), for: .normal)
            view.buttonTapHandler = { _ in SwiftMessages.hide() }
            view.titleLabel?.font = FontBrand.alertTitleFont
            view.bodyLabel?.font = FontBrand.alertMessageFont
            view.button?.titleLabel?.font = FontBrand.buttonTitleFont
            return view
        }
    }
    
    class func showMessage(_ theme: Theme, title: String, body: String) {
        var config = SwiftMessages.Config()
        config.duration = .seconds(seconds: 5)
        config.presentationStyle = .top
        SwiftMessages.show(config: config) {
            let view = MessageView.viewFromNib(layout: .cardView)
            var backgroundColor: UIColor = ColorBrand.gtelBrandGreen
            let foregroundColor: UIColor = ColorBrand.gtelBrandWhite
            switch theme {
                case .info:
                    backgroundColor = ColorBrand.gtelBrandBlue
                case .success:
                    backgroundColor = ColorBrand.gtelBrandGreen
                case .warning:
                    backgroundColor = ColorBrand.gtelBrandYellow
                case .error:
                    backgroundColor = ColorBrand.gtelBrandOrange
            }
            let iconImage = IconStyle.default.image(theme: theme)
            view.configureTheme(backgroundColor: backgroundColor, foregroundColor: foregroundColor, iconImage: iconImage)
            view.configureContent(title: title, body: body)
            view.button?.setTitle(LOCALIZED("dismiss"), for: .normal)
            view.buttonTapHandler = { _ in SwiftMessages.hide() }
            view.titleLabel?.font = FontBrand.alertTitleFont
            view.bodyLabel?.font = FontBrand.alertMessageFont
            view.button?.titleLabel?.font = FontBrand.buttonTitleFont
            return view
        }
    }
    
    class func showAlert(
        title: String = "",
        message: String = "",
        image: UIImage? = nil,
        cancelTitle: String = LOCALIZED("cancel"),
        otherTitle: String, handler: @escaping() -> Void) {
        
        let alert = FCAlertView()
        alert.cornerRadius = kCornerRadius
        alert.bounceAnimations = false
        alert.hideDoneButton = true
        alert.detachButtons = false
        alert.tintColor = ColorBrand.gtelBrandNavy
        alert.hideSeparatorLineView = true
        alert.alertBackgroundColor = ColorBrand.gtelBrandBackground
        alert.titleFont = FontBrand.alertTitleFont
        alert.subtitleFont = FontBrand.alertMessageFont
        alert.firstButtonCustomFont = FontBrand.buttonTitleFont
        alert.secondButtonCustomFont = FontBrand.buttonTitleFont
        alert.titleColor = ColorBrand.gtelBrandOrange
        alert.subTitleColor = ColorBrand.gtelBrandDarkGray
        alert.firstButtonTitleColor = ColorBrand.gtelBrandNavy
        alert.firstButtonBackgroundColor = ColorBrand.gtelBrandSilverBackground
        alert.secondButtonTitleColor = ColorBrand.gtelBrandBackground
        alert.secondButtonBackgroundColor = ColorBrand.gtelBrandOrange
        alert.addButton(cancelTitle) { }
        alert.addButton(otherTitle) { handler() }
        alert.showAlert(withTitle: title, withSubtitle: message, withCustomImage: image, withDoneButtonTitle: nil, andButtons: nil)
    }
    
    class func hideAllMessages() {
        SwiftMessages.hideAll()
    }
    
    class func imageOrientation(fromDevicePosition devicePosition: AVCaptureDevice.Position = .back) -> UIImage.Orientation {
      var deviceOrientation = UIDevice.current.orientation
      if deviceOrientation == .faceDown || deviceOrientation == .faceUp || deviceOrientation == .unknown 		{
        deviceOrientation = currentUIOrientation()
      }
      switch deviceOrientation {
      case .portrait:
        return devicePosition == .front ? .leftMirrored : .right
      case .landscapeLeft:
        return devicePosition == .front ? .downMirrored : .up
      case .portraitUpsideDown:
        return devicePosition == .front ? .rightMirrored : .left
      case .landscapeRight:
        return devicePosition == .front ? .upMirrored : .down
      case .faceDown, .faceUp, .unknown:
        return .up
      @unknown default:
        fatalError()
      }
    }
    
    class func currentUIOrientation() -> UIDeviceOrientation {
      let deviceOrientation = { () -> UIDeviceOrientation in
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft:
          return .landscapeRight
        case .landscapeRight:
          return .landscapeLeft
        case .portraitUpsideDown:
          return .portraitUpsideDown
        case .portrait, .unknown:
          return .portrait
        @unknown default:
          fatalError()
        }
      }
      guard Thread.isMainThread else {
        var currentOrientation: UIDeviceOrientation = .portrait
        DispatchQueue.main.sync {
          currentOrientation = deviceOrientation()
        }
        return currentOrientation
      }
      return deviceOrientation()
    }
    
    class func screenSize() -> CGRect {
        return UIScreen.main.bounds
    }

}
