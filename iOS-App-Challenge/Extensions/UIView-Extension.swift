//
//  UIView-Extension.swift
//  iOS-App-Challenge
//
//  Created by Gustavo Travassos on 17/10/20.
//

import UIKit

/// Uma  extensão que permite que eu coloque cornerRadius em UIView pelo Storyboard
@IBDesignable
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
