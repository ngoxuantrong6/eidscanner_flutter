import UIKit

class ColorBrand {
    
    // --------------------------------------
    // MARK: Common
    // --------------------------------------
    
    class func RGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    
    class func RGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    class func HEX(_ hex: String) -> UIColor? {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }
        if ((cString.count) != 6) { return nil }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // --------------------------------------
    // MARK: Brand Color
    // --------------------------------------
        
    class var gtelBrandBackground: UIColor {
        UIColor(named: "gtelBrandBackground") ?? RGB(red: 250, green: 250, blue: 250)
    }
    
    class var gtelBrandBlack: UIColor {
        UIColor(named: "gtelBrandBlack") ?? RGB(red: 27, green: 27, blue: 27)
    }
    

    class var gtelBrandBlue: UIColor {
        UIColor(named: "gtelBrandBlue") ?? RGB(red: 22, green: 127, blue: 252)
    }
    
    class var gtelBrandDarkGray: UIColor {
        UIColor(named: "gtelBrandDarkGray") ?? RGB(red: 48, green: 48, blue: 54)
    }
    
    class var gtelBrandDarkWhite: UIColor {
        UIColor(named: "gtelBrandDarkWhite") ?? RGB(red: 203, green: 207, blue: 221)
    }
    
    class var gtelBrandGreen: UIColor {
        UIColor(named: "gtelBrandGreen") ?? RGB(red: 0, green: 168, blue: 89)
    }
    
    class var gtelBrandLightNavy: UIColor {
        UIColor(named: "gtelBrandLightNavy") ?? RGB(red: 70, green: 109, blue: 148)
    }
    
    class var gtelBrandNavy: UIColor {
        UIColor(named: "gtelBrandNavy") ?? RGB(red: 41, green: 50, blue: 65)
    }
    
    class var gtelBrandOrange: UIColor {
        UIColor(named: "gtelBrandOrange") ?? RGB(red: 252, green: 81, blue: 48)
    }
    
    class var gtelBrandPurple: UIColor {
        UIColor(named: "gtelBrandPurple") ?? RGB(red: 89, green: 91, blue: 212)
    }
    
    class var gtelBrandRed: UIColor {
        UIColor(named: "gtelBrandRed") ?? RGB(red: 244, green: 66, blue: 54)
    }
    
    class var gtelBrandSilver: UIColor {
        UIColor(named: "gtelBrandSilver") ?? RGB(red: 167, green: 168, blue: 171)
    }
    
    class var gtelBrandSilverBackground: UIColor {
        UIColor(named: "gtelBrandSilverBackground") ?? RGB(red: 231, green: 232, blue: 235)
    }
    
    class var gtelBrandSmokeWhite: UIColor {
        UIColor(named: "gtelBrandSmokeWhite") ?? RGB(red: 239, green: 240, blue: 245)
    }
    
    class var gtelBrandWhite: UIColor {
        UIColor(named: "gtelBrandWhite") ?? RGB(red: 255, green: 255, blue: 255)
    }
    
    class var gtelBrandYellow: UIColor {
        UIColor(named: "gtelBrandYellow") ?? RGB(red: 255, green: 183, blue: 0)
    }
    
    // --------------------------------------
    // MARK: UINavigationBar
    // --------------------------------------

    class var navBarBackgroundColor: UIColor {
        return gtelBrandDarkGray
    }

    class var navBarTintColor: UIColor {
        return gtelBrandWhite
    }

    class var navBarTextColor: UIColor {
        return gtelBrandWhite
    }

    class var navBarDisabledColor: UIColor {
        return gtelBrandWhite
    }

    class var navBarPageIndicatorColor: UIColor {
        return gtelBrandWhite
    }

    class var navBarPageHairLineColor: UIColor {
        return gtelBrandRed
    }

    class var navBarSelectedMenuItemLabelColor: UIColor {
        return gtelBrandWhite
    }

    class var navBarUnselectedMenuItemLabelColor: UIColor {
        return gtelBrandWhite
    }

    // --------------------------------------
    // MARK: UISearchBar
    // --------------------------------------

    class var searchBarBackgroundColor: UIColor {
        return gtelBrandWhite
    }

    class var searchBarBarTintColor: UIColor {
        return gtelBrandWhite
    }

    class var searchBarTintColor: UIColor {
        return gtelBrandLightNavy
    }

    class var searchBarTextColor: UIColor {
        return gtelBrandDarkGray
    }

    // --------------------------------------
    // MARK: UIToolbar
    // --------------------------------------

    class var toolbarBackgroundColor: UIColor {
        return gtelBrandWhite
    }

    class var toolbarBarTintColor: UIColor {
        return gtelBrandWhite
    }

    class var toolbarTintColor: UIColor {
        return gtelBrandLightNavy
    }

    class var toolbarTextColor: UIColor {
        return gtelBrandDarkGray
    }

    // --------------------------------------
    // MARK: UITabBar
    // --------------------------------------

    class var tabBarBackgroundColor: UIColor {
        return gtelBrandSilverBackground
    }

    class var tabBarTintColor: UIColor {
        return gtelBrandOrange
    }

    class var tabBarUnselectedColor: UIColor {
        return gtelBrandSilver
    }

    class var tabBarSeltectedColor: UIColor {
        return gtelBrandOrange
    }

    // --------------------------------------
    // MARK: UIBarButtonItem
    // --------------------------------------

    class var barButtonItemColor: UIColor {
        return gtelBrandNavy
    }

    // --------------------------------------
    // MARK: UITableView
    // --------------------------------------

    class var tableViewBackgroundColor: UIColor {
        return gtelBrandWhite
    }

    class var tableViewHeaderBackgroundColor: UIColor {
        return gtelBrandDarkGray
    }

    class var tableViewHeaderTextColor: UIColor {
        return gtelBrandWhite
    }

    class var tableViewHeaderSelectedBackgroundColor: UIColor {
        return gtelBrandRed
    }

    class var tableViewHeaderForegroundColor: UIColor {
        return gtelBrandWhite
    }

    class var tableViewTintColor: UIColor {
        return gtelBrandLightNavy
    }

    class var tableViewGroupedSectionForegroundColor: UIColor {
        return gtelBrandWhite
    }

    class var tableViewGroupedSectionBackgroundColor: UIColor {
        return gtelBrandSilver
    }

    class var tableViewCellBackgroundColor: UIColor {
        return gtelBrandWhite
    }

    class var tableViewCellDetailsColor: UIColor {
        return gtelBrandWhite
    }

    class var tableViewPrimaryColumnBackgroundColor: UIColor {
        return gtelBrandSilver
    }

    class var tableViewSelectedCellBackgroundColor: UIColor {
        return gtelBrandNavy
    }

    class var tableViewSeparatorColor: UIColor {
        return gtelBrandWhite
    }

    class var tableViewEmptyCellBackgroundColor: UIColor {
        return UIColor.clear
    }

    class var tableViewSectionIndexColor: UIColor {
        return gtelBrandDarkGray
    }

    class var tableViewSectionIndexBackgroundColor: UIColor {
        return UIColor.clear
    }

    class var tableViewSectionTextColor: UIColor {
        return gtelBrandSilver
    }

    // --------------------------------------
    // MARK: UILabel & UITextField
    // --------------------------------------

    class var textStyleTitleColor: UIColor {
        return gtelBrandSilver
    }

    class var textStyleTitleShadowColor: UIColor {
        return gtelBrandWhite
    }

    class var textStyleBodyColor: UIColor {
        return gtelBrandDarkGray
    }

    class var textStyleDescriptionColor: UIColor {
        return gtelBrandWhite
    }

    class var textStyleDisabledBodyColor: UIColor {
        return gtelBrandWhite
    }

    class var textStylePlaceholderColor: UIColor {
        return gtelBrandWhite
    }

    class var textStyleErrorColor: UIColor {
        return gtelBrandRed
    }

    class var textStyleSuccessColor: UIColor {
        return gtelBrandGreen
    }

    class var textStyleLinkColor: UIColor {
        return gtelBrandLightNavy
    }

    class var textViewLinkColor: UIColor {
        return gtelBrandLightNavy
    }

    // --------------------------------------
    // MARK: UISwitch
    // --------------------------------------

    class var switchOnTintColor: UIColor {
        return gtelBrandRed
    }

    class var tintColor: UIColor {
        return gtelBrandDarkGray
    }

    class var switchThumbTintColor: UIColor {
        return gtelBrandSilver
    }

    // --------------------------------------
    // MARK: UITextView
    // --------------------------------------

    class var calendarBackgroundColor: UIColor {
        return gtelBrandOrange
    }

    class var calendarTitleColor: UIColor {
        return gtelBrandWhite
    }

    class var calendarHeaderTitleColor: UIColor {
        return gtelBrandWhite
    }

    class var calendarWeekdayTextColor: UIColor {
        return gtelBrandWhite
    }

    class var calendarTodayColor: UIColor {
        return gtelBrandWhite
    }

    class var calendarSelectionColor: UIColor {
        return gtelBrandNavy
    }

    class var calendarTodaySelectionColor: UIColor {
        return gtelBrandLightNavy
    }
    
    // --------------------------------------
    // MARK: Form
    // --------------------------------------

    class var formStyleTitleColor: UIColor {
        return gtelBrandNavy
    }

    class var formStyleRequiredTitleColor: UIColor {
        return gtelBrandOrange
    }

    class var formStyleTitleDetailColor: UIColor {
        return gtelBrandBlue
    }

    class var formStyleLinkColor: UIColor {
        return gtelBrandBlue
    }

    class var formStyleTitleDisabledColor: UIColor {
        return gtelBrandSilver
    }

    class var formStyleTitleDetailDisabledColor: UIColor {
        return gtelBrandDarkWhite
    }

    class var formStyleLinkDisabledColor: UIColor {
        return gtelBrandDarkWhite
    }
}
