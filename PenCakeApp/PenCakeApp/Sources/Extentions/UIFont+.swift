//
//  UIFont+.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/27.
//

import UIKit

extension UIFont {
    public enum NotoSerifType: String {
        case light = "Light"
        case semiBold = "SemiBold"
    }

    static func NotoSerif(_ type: NotoSerifType, size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSerifKR-\(type.rawValue)", size: size)!
    }
    
//    class func notoSansKRMediumFont (fontSize: CGFloat) -> UIFont {
//        return  UIFont(name: "NotoSansKR-SemiBold", size: fontSize)!
//    }
//    class func notoSansKRBlackFont (fontSize: CGFloat) -> UIFont {
//        return  UIFont(name: "NotoSansKR-Light", size: fontSize)!
//    }
}
