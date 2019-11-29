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
    
    private var editorKeyboard: CustomKeyboard = CustomKeyboard()
    
    var isBold: Bool {
        get { return editorKeyboard.isBold }
    }
    var isUnderline: Bool {
        get { return editorKeyboard.isUnderline }
    }
    var isItalic: Bool {
        get { return editorKeyboard.isItalic }
    }
    var isStrikethrough: Bool {
        get { return editorKeyboard.isStrikethrough }
    }
    override var canBecomeFirstResponder: Bool {
        get { return true }
    }
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        editorKeyboard.delegate = self
       // delegate = self
        addOptions()
    }
    
    //MARK: - Methods
    
    func addOptions(){
        let optionsToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        optionsToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let options: UIBarButtonItem = UIBarButtonItem(title: "Options", style: .done, target: self, action: #selector(toggleOptions))

        let items = [flexSpace, options]
        optionsToolbar.items = items
        optionsToolbar.sizeToFit()

        inputAccessoryView = optionsToolbar
    }
    
    @objc func toggleOptions() {
        resignFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else {return}
            self.inputView = self.inputView as? CustomKeyboard == nil ? self.editorKeyboard : nil
            self.becomeFirstResponder()
        }
    }
}

//MARK: - Keyboard Delegate

extension CustomTextView: KeyboardDelegate {
    func chooseFont() -> UIFont {
        guard let font = font else {return UIFont.systemFont(ofSize: 14)}
        
        if isBold && isItalic {
            return font.boldItalics()
        } else if !isBold && isItalic {
            return font.italics()
        } else if isBold && !isItalic {
            return font.bold()
        } else {
            return font.default
        }
    }
    
    func updateAttributes(selected: Bool, attribute: [NSAttributedString.Key: Any]) {
        let cachedRange = selectedRange
        let attributedString = NSMutableAttributedString(attributedString: attributedText.attributedSubstring(from: selectedRange))
        
        if !selected && attribute.keys.first! != .font {
            editorKeyboard.attributesDictionary.removeValue(forKey: attribute.keys.first!)
            attributedString.removeAttribute(attribute.keys.first!, range: NSRange(location: 0, length: attributedString.string.count))
        } else {
            editorKeyboard.attributesDictionary[attribute.keys.first!] = attribute.values.first!
        }
        
        attributedString.addAttributes(editorKeyboard.attributesDictionary, range: NSRange(location: 0, length: attributedString.string.count))
        
        let lowerBound = NSRange(location: 0, length: selectedRange.lowerBound)
        let upperBound = NSRange(location: selectedRange.upperBound, length: text.count - selectedRange.upperBound)
        let prefixString = NSMutableAttributedString(attributedString: attributedText.attributedSubstring(from: lowerBound))
        let sufixString = NSMutableAttributedString(attributedString: attributedText.attributedSubstring(from: upperBound))
        
        let finalText = prefixString + attributedString + sufixString
        
        attributedText = finalText
        selectedRange = cachedRange
    }
    
    func bold(_ selected: Bool) {
        updateAttributes(selected: selected, attribute: [.font: chooseFont()])
    }
    
    func italic(_ selected: Bool) {
        updateAttributes(selected: selected, attribute: [.font: chooseFont()])
    }
    
    func underline(_ selected: Bool) {
        updateAttributes(selected: selected, attribute: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    func strikethrough(_ selected: Bool) {
        updateAttributes(selected: selected, attribute: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
    }
}
