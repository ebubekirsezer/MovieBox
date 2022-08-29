//
//  ColorExtensions.swift
//  MovieBox
//
//  Created by EbubekirSezer on 28.08.2022.
//

import Foundation
import UIKit

public func RGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
    return RGBa(red, green, blue, 1)
}

public func RGBa(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha:alpha)
}
