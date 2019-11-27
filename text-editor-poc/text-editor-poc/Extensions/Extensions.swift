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

    func `default`() -> UIFont {
        return UIFont(name: "Helvetica", size: 14)!
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
