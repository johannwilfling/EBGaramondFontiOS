//
//  EBGaramondFontiOS.swift
//  Pods
//
//  Created by Johann Wilfling (wj) on 06/10/16.
//
//

public extension UIFont {
    
    public class func ebGaramond08RegularFontWithSize(_ fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: EBGaramondFonts.EBGaramond08Regular.rawValue, size: fontSize)!
    }

    public class func ebGaramond08ItalicFontWithSize(_ fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: EBGaramondFonts.EBGaramond08Italic.rawValue, size: fontSize)!
    }
    
    public class func ebGaramond12RegularFontWithSize(_ fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: EBGaramondFonts.EBGaramond12Regular.rawValue, size: fontSize)!
    }

    public class func ebGaramond12ItalicFontWithSize(_ fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: EBGaramondFonts.EBGaramond12Italic.rawValue, size: fontSize)!
    }

    // small caps
    public class func ebGaramond12AllSCFontWithSize(_ fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: EBGaramondFonts.EBGaramond12AllSC.rawValue, size: fontSize)!
    }

    public class func ebGaramondSC08RegularFontWithSize(_ fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: EBGaramondFonts.EBGaramondSC08Regular.rawValue, size: fontSize)!
    }

    public class func ebGaramondSC12RegularFontWithSize(_ fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: EBGaramondFonts.EBGaramondSC12Regular.rawValue, size: fontSize)!
    }

}

private enum EBGaramondFonts: String {
    
    case FontFamilyName = "EB Garamond"
    
    case EBGaramond08Regular = "EBGaramond08-Regular"
    case EBGaramond12Regular = "EBGaramond12-Regular"
    case EBGaramond08Italic = "EBGaramond08-Italic"
    case EBGaramond12Italic = "EBGaramond12-Italic"
    
    // small caps
    case EBGaramond12AllSC = "EBGaramond12-AllSC"
    case EBGaramondSC08Regular = "EBGaramondSC08-Regular"
    case EBGaramondSC12Regular = "EBGaramondSC12-Regular"
    
    
    static let allValues = [
        EBGaramond08Regular, EBGaramond12Regular, EBGaramond08Italic, EBGaramond12Italic,
        EBGaramond12AllSC, EBGaramondSC08Regular, EBGaramondSC12Regular
    ]
}


private class FontLoader {
    
    static func loadFontIfNeeded() {
        if (UIFont.fontNames(forFamilyName: EBGaramondFonts.FontFamilyName.rawValue).count == 0) {
            let bundle = Bundle(for: FontLoader.self)
            var fontURL: URL!
            let identifier = bundle.bundleIdentifier
            
            for ebGaramondFont in EBGaramondFonts.allValues {
                if identifier?.hasPrefix("org.cocoapods") == true {
                    fontURL = bundle.url(forResource: ebGaramondFont.rawValue, withExtension: "otf", subdirectory: "EBGaramondFontiOS.bundle")
                } else {
                    fontURL = bundle.url(forResource: ebGaramondFont.rawValue, withExtension: "otf")
                }
                let data = try! Data(contentsOf: fontURL as URL)
                let provider = CGDataProvider(data: data as CFData)
                let font = CGFont(provider!)
                
                var error: Unmanaged<CFError>?
                if !CTFontManagerRegisterGraphicsFont(font, &error) {
                    
                    let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
                    let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
                    NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
                }
            }
        }
    }
    
}
