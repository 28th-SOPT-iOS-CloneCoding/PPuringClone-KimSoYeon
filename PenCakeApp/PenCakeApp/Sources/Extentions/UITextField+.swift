//
//  UITextField+.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/06/01.
//

import UIKit

extension UITextField {
    func removeAuto() {
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.spellCheckingType = .no
        self.textContentType = .none
    }
}
