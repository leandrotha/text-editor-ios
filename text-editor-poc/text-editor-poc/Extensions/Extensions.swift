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

    var `default`: UIFont {
        get { UIFont(name: "Helvetica", size: 14)! }
    }
    
    func italics() -> UIFont {
        return withTraits(.traitItalic)
    }

    func bold() -> UIFont {
        return withTraits(.traitBold)
    }

    func boldItalics() -> UIFont {
        return withTraits([.traitBold, .traitItalic])
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
