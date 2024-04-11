import UIKit

let kGoldenRatio: CGFloat = 0.618033988749895
let kBarButtonDefaultWidth: CGFloat = 24.0
let kBarButtonDefaultHeight: CGFloat = 24.0
let kNavigationBarDefaultHeight: CGFloat = 64.0
let kEmtpyJsonString: String = "{}"
let kMaxDifferenceData: Int = 200
let kCornerRadius: CGFloat = 8.0
let kBorderWidth: CGFloat = 2.0
let kShadowOpacity: CGFloat = 0.5
let kShadowRadius: CGFloat = 1.0
let kShadowOffset: CGSize = CGSize(width: 0.0, height: 1.0)
let kAvatarDefaultUrl: String = "https://i.imgur.com/2lpqyqY.png"

// --------------------------------------
// MARK: UITableView
// --------------------------------------

let kCellTitleKey: String = "celltitle"
let kCellInformationKey: String = "cellinformation"
let kCellKeyboardType: String = "cellkeyboardtype"
let kCellPlaceholderKey: String = "cellplaceholder"
let kCellShowDisclosureIndicatorKey: String = "cellshowdisclosureindicator"
let kCellStatusKey: String = "cellstatus"
let kCellColorCodeKey: String = "cellstatuscolorcode"
let kCellIconImageKey: String = "celliconimage"
let kCellImageUrlKey: String = "cellimageurlkey"
let kCellImageKey: String = "cellimagekey"
let kCellIdentifierKey: String = "cellidentifier"
let kCellIsSelectedKey: String = "cellisselected"
let kCellNibNameKey: String = "cellnibname"
let kCellClassKey: String = "cellclass"
let kCellErrorMessageKey: String = "cellerrormessage"
let kCellFontKey: String = "cellfont"
let kCellHeightKey: String = "cellheight"
let kCellDifferenceIdentifierKey: String = "celldifferenceidentifier"
let kCellDifferenceContentKey: String = "celldifferencecontent"
let kCellObjectDataKey: String = "cellobjectdata"
let kCellTagKey: String = "celltag"
let kCellItemsKey: String = "items"
let kCellLabelsKey: String = "labels"
let kCellValuesKey: String = "values"
let kCellVideoUrlKey: String = "videourlkey"
let kCellVideoDateKey: String = "videoassetkey"
let kCellButtonTitleKey: String = "cellbuttontitlekey"
let kCellButtonBgColorKey: String = "cellbuttonbgcolorkey"
let kCellEnabledKey: String = "cellenabledkey"
let kSectionTitleKey: String = "sectiontitle"
let kSectionIconImageKey: String = "sectioniconimage"
let kSectionSearchInputKey: String = "sectionsearchinput"
let kSectionSearchInputPlaceholderKey: String = "sectionsearchinputplaceholder"
let kSectionSearchInputButtonLblKey: String = "sectionsearchinputbtnlbl"
let kSectionDataKey: String = "sectionvalue"
let kSectionCollapsedKey: String = "collapsed"
let kSectionTextAlignmentKey: String = "textalignment"
let kSectionbarViewKey: String = "barview"
let kHeaderFooterPadding: CGFloat = 16.0
let kHeaderFooterHeight: CGFloat = 36.0
let kHeaderSearchInnputLayoutHeight: CGFloat = 78.0

// --------------------------------------
// MARK: Common Macros
// --------------------------------------

var HOMEDIRECTORY: String {
    return ProcessInfo.processInfo.environment["HOME"] ?? ""
}

func LOCALIZED(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

func INIT_CONTROLLER_XIB<T: UIViewController>(_ clazz: T.Type) -> T {
    print(clazz)
    return T(nibName: String(describing: clazz), bundle: nil)
}

func DISPATCH_ASYNC_MAIN_AFTER(_ delay: Double, closure: @escaping () -> Void) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

func DISPATCH_ASYNC_MAIN(_ closure: @escaping () -> Void) {
    DispatchQueue.main.async(execute: closure)
}

func DISPATCH_ASYNC_BG(_ closure: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).async(execute: closure)
}

func DISPATCH_ASYNC_BG_AFTER(_ delay: Double, _ closure: @escaping () -> Void) {
    let when = DispatchTime.now() + delay
    DispatchQueue.global(qos: .background).asyncAfter(deadline: when, execute: closure)
}
