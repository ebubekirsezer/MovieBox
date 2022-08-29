//
//  UIView+RoundedCorners.swift
//  MovieBox
//
//  Created by EbubekirSezer on 28.08.2022.
//

import UIKit

enum Corners {
    case top
    case bottom
    case all
}

extension UIView {
    @IBInspectable var topCorners: Bool {
        get {
            return self.topCorners
        }
        set {
            round(corner: .top)
        }
    }
    
    @IBInspectable var bottomCorners: Bool {
        get {
            return self.bottomCorners
        }
        set {
            round(corner: .bottom)
        }
    }
    
    @IBInspectable var allCorners: Bool {
        get {
            return self.allCorners
        }
        set {
            round(corner: .all)
        }
    }
    
    private func round(corner: Corners){
        var corners: CACornerMask
        var radius: CGFloat = 15
        switch corner {
        case .top:
            radius = 20
            corners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .bottom:
            radius = 20
            corners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .all:
            radius = 15
            corners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        }
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = corners
        } else {
            // Fallback on earlier versions
        }
    }
}
