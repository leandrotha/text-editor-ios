//
//  CustomTextView.swift
//  text-editor-poc
//
//  Created by Bartsch Tha, Leandro on 27/11/19.
//  Copyright © 2019 Bartsch Tha, Leandro. All rights reserved.
//

import Foundation
import UIKit

class CustomTextView: UITextView {
    
    //MARK: - Properties
    
    var kb: CustomKeyboard = CustomKeyboard()
    var dict: [NSAttributedString.Key: Any] = [:]
    var isBold: Bool {
        get { return kb.isBold }
    }
    var isUnderline: Bool {
        get { return kb.isUnderline }
    }
    var isItalic: Bool {
        get { return kb.isItalic }
    }
    var isStrikethrough: Bool {
        get { return kb.isStrikethrough }
    }
    override var canBecomeFirstResponder: Bool {
        get { return true }
    }
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        kb.delegate = self
        addOptions()
    }
    
    //MARK: - Methods
    
    func addOptions(){
        let optionsToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        optionsToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Options", style: .done, target: self, action: #selector(toggleOptions))

        let items = [flexSpace, done]
        optionsToolbar.items = items
        optionsToolbar.sizeToFit()

        inputAccessoryView = optionsToolbar
    }
    
    @objc func toggleOptions() {
        resignFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else {return}
            self.inputView = self.inputView as? CustomKeyboard == nil ? self.kb : nil
            self.becomeFirstResponder()
        }
    }
}

//MARK: - Keyboard Delegate

extension CustomTextView: KeyboardDelegate {
    func updateFont() {
        if isBold && isItalic {
            font = font?.boldItalics()
        } else if !isBold && isItalic {
            font = font?.italics()
        } else if !isBold && !isItalic {
            font = font?.default()
        } else {
            font = font?.bold()
        }
    }
    
    func bold(_ selected: Bool) {
        updateFont()
    }
    
    func italic(_ selected: Bool) {
        updateFont()
    }
    
    func underline(_ selected: Bool) {
        if !selected {
            dict.removeValue(forKey: .underlineStyle)
        } else {
            dict[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        let attrs = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: text.count)
        attrs.addAttributes(dict, range: range)
        self.attributedText = attrs
        
        updateFont()
    }
    
    func strikethrough(_ selected: Bool) {
        if !selected {
            dict.removeValue(forKey: .strikethroughStyle)
        } else {
            dict[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
        }
        
        let attrs = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: text.count)
        attrs.addAttributes(dict, range: range)
        self.attributedText = attrs
        
        updateFont()
    }

}
