//
//  UIView+.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/06/01.
//

import UIKit

extension UIView {
    @discardableResult
    func addSubviews<T: UIView>(_ subviews: [T], then closure: (([T]) -> Void)? = nil) -> [T] {
        subviews.forEach { addSubview($0) }
        closure?(subviews)
        return subviews
    }
}
