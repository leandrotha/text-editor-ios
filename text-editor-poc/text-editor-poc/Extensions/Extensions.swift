//
//  Extensions.swift
//  text-editor-poc
//
//  Created by Bartsch Tha, Leandro on 27/11/19.
//  Copyright © 2019 Bartsch Tha, Leandro. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        if let fd = fontDescriptor.withSymbolicTraits(traits) {
            return UIFont(descriptor: fd, size: pointSize)
        }

        return self
    }

    static var `default`: UIFont {
        get { UIFont.systemFont(ofSize: 14) }
    }
    
    var italics: UIFont {
        return withTraits(.traitItalic)
    }

    var bold: UIFont {
        return withTraits(.traitBold)
    }

    var boldItalics: UIFont {
        return withTraits([.traitBold, .traitItalic])
    }
    
    var regular: UIFont {
        if !fontDescriptor.symbolicTraits.contains(.traitBold) && !fontDescriptor.symbolicTraits.contains(.traitItalic){
            return self
        } else {
            var traits = fontDescriptor.symbolicTraits
            traits.remove(.traitBold)
            traits.remove(.traitItalic)
            return UIFont(descriptor: fontDescriptor.withSymbolicTraits(traits)!, size: self.pointSize)
        }
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}

extension NSMutableAttributedString {
    static func + (left: NSMutableAttributedString, right: NSMutableAttributedString) -> NSMutableAttributedString {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }
}

extension Optional where Wrapped == String {
    var length: Int {
        get { return (self ?? "").count }
    }
}

extension UIButton {
    func roundedLeftBorders() {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners:[.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: 8, height:  8))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
    
    func roundedRightBorders() {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners:[.topRight, .bottomRight],
                                cornerRadii: CGSize(width: 8, height:  8))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
