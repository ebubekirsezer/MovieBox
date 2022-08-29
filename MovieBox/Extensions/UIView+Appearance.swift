//
//  UIView+Appearance.swift
//  MovieBox
//
//  Created by EbubekirSezer on 28.08.2022.
//

import Foundation
import UIKit

extension UIView {
 
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat {
        get {
            return CGFloat(self.layer.shadowOpacity)
        }
        set {
            self.layer.shadowOpacity = Float(newValue)
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.gray.cgColor)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return CGFloat(self.layer.shadowRadius)
        }
        set {
            self.layer.shadowOffset = .zero
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
}
