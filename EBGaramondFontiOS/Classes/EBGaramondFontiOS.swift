//
//  EBGaramondFontiOS.swift
//  Pods
//
//  Created by Johann Wilfling (wj) on 06/10/16.
//
//

public extension UIFont {
    
    public class func ebGaramond08RegularFontWithSize(fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: EBGaramondFonts.EBGaramond08Regular.rawValue, size: fontSize)!
    }

    public class func ebGaramond08ItalicFontWithSize(fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: EBGaramondFonts.EBGaramond08Italic.rawValue, size: fontSize)!
    }
    
    public class func ebGaramond12RegularFontWithSize(fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: EBGaramondFonts.EBGaramond12Regular.rawValue, size: fontSize)!
    }

    public class func ebGaramond12ItalicFontWithSize(fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: EBGaramondFonts.EBGaramond12Italic.rawValue, size: fontSize)!
    }
    
}

private enum EBGaramondFonts: String {
    
    case FontFamilyName = "EB Garamond"
    
    case EBGaramond08Regular = "EBGaramond08-Regular"
    case EBGaramond12Regular = "EBGaramond12-Regular"
    case EBGaramond08Italic = "EBGaramond08-Italic"
    case EBGaramond12Italic = "EBGaramond12-Italic"
    
    static let allValues = [
        EBGaramond08Regular, EBGaramond12Regular, EBGaramond08Italic, EBGaramond12Italic
    ]
}

private class FontLoader {
    
    struct Static {
        static var onceToken : dispatch_once_t = 0
    }
    
    static func loadFontIfNeeded() {
        if (UIFont.fontNamesForFamilyName(EBGaramondFonts.FontFamilyName.rawValue).count == 0) {
            
            dispatch_once(&Static.onceToken) {
                let bundle = NSBundle(forClass: FontLoader.self)
                var fontURL = NSURL()
                let identifier = bundle.bundleIdentifier
                
                for vegurFont in EBGaramondFonts.allValues {
                    if identifier?.hasPrefix("org.cocoapods") == true {
                        fontURL = bundle.URLForResource(vegurFont.rawValue, withExtension: "otf", subdirectory: "EBGaramondFontiOS.bundle")!
                    } else {
                        fontURL = bundle.URLForResource(vegurFont.rawValue, withExtension: "otf")!
                    }
                    let data = NSData(contentsOfURL: fontURL)!
                    
                    let provider = CGDataProviderCreateWithCFData(data)
                    let font = CGFontCreateWithDataProvider(provider)!
                    
                    var error: Unmanaged<CFError>?
                    if !CTFontManagerRegisterGraphicsFont(font, &error) {
                        
                        let errorDescription: CFStringRef = CFErrorCopyDescription(error!.takeUnretainedValue())
                        let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
                        NSException(name: NSInternalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
                    }
                    
                }
            }
        }
    }
}
