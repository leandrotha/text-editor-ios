//
//  CustomKeyboard.swift
//  text-editor-poc
//
//  Created by Bartsch Tha, Leandro on 26/11/19.
//  Copyright © 2019 Bartsch Tha, Leandro. All rights reserved.
//

import UIKit

protocol KeyboardDelegate {
    func bold(_ selected: Bool)
    func italic(_ selected: Bool)
    func underline(_ selected: Bool)
    func strikethrough(_ selected: Bool)
    
    func lineListing(_ selected: Bool)
    func bulletListing(_ selected: Bool)
    func numbersListing(_ selected: Bool)
    
    func indentingForward(_ selected: Bool)
    func indentingBackward(_ selected: Bool)
}

typealias AttributesDictionary = [NSAttributedString.Key: Any]

class CustomKeyboard: UIView {
    
    //MARK: - Properties
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var btnBold: UIButton! {
        didSet {
            btnBold.setTitleColor(.white, for: .selected)
            btnBold.roundedLeftBorders()
        }
    }
    @IBOutlet weak var btnItalic: UIButton! {
        didSet {
            btnItalic.setTitleColor(.white, for: .selected)
        }
    }
    @IBOutlet weak var btnUnderline: UIButton! {
        didSet {
            btnUnderline.setTitleColor(.white, for: .selected)
        }
    }
    @IBOutlet weak var btnStrikethrough: UIButton! {
        didSet {
            btnStrikethrough.setTitleColor(.white, for: .selected)
            btnStrikethrough.roundedRightBorders()
        }
    }
    @IBOutlet weak var btnLineListing: UIButton! {
        didSet {
            btnLineListing.setTitleColor(.white, for: .selected)
            btnLineListing.roundedLeftBorders()
        }
    }
    @IBOutlet weak var btnNumbersListing: UIButton! {
        didSet {
            btnNumbersListing.setTitleColor(.white, for: .selected)
        }
    }
    @IBOutlet weak var btnBulletsListing: UIButton! {
        didSet {
            btnBulletsListing.setTitleColor(.white, for: .selected)
            btnBulletsListing.roundedRightBorders()
        }
    }
    @IBOutlet weak var btnIndentBackward: UIButton! {
        didSet {
            btnIndentBackward.setTitleColor(.white, for: .selected)
            btnIndentBackward.roundedLeftBorders()
        }
    }
    @IBOutlet weak var btnIndentForward: UIButton! {
        didSet {
            btnIndentForward.setTitleColor(.white, for: .selected)
            btnIndentForward.roundedRightBorders()
        }
    }
    
    private(set) var isBold: Bool = false
    private(set) var isUnderline: Bool = false
    private(set) var isItalic: Bool = false
    private(set) var isStrikethrough: Bool = false
    
    var delegate: KeyboardDelegate?
    var attributesDictionary: AttributesDictionary = [:]
    
    //MARK: - Initializers
    
    convenience init() {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 300.0
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        
        self.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("CustomKeyboard", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    //MARK: - Actions
    
    @IBAction func onTapWordModifiers(_ sender: UIButton) {
        sender.updateStatusForTextEditor()
        
        if sender == btnBold {
            isBold = sender.isSelected
            delegate?.bold(sender.isSelected)
        } else if sender == btnItalic {
            isItalic = sender.isSelected
            delegate?.italic(sender.isSelected)
        } else if sender == btnUnderline {
            isUnderline = sender.isSelected
            delegate?.underline(sender.isSelected)
        } else if sender == btnStrikethrough {
            isStrikethrough = sender.isSelected
            delegate?.strikethrough(sender.isSelected)
        }
    }
    
    @IBAction func onTapListingOptions(_ sender: UIButton) {
        sender.updateStatusForTextEditor()
        
        if sender == btnLineListing {
            delegate?.lineListing(sender.isSelected)
        } else if sender == btnNumbersListing {
            delegate?.numbersListing(sender.isSelected)
        } else if sender == btnBulletsListing {
            delegate?.bulletListing(sender.isSelected)
        }
    }
    
    @IBAction func onTapIndentingOptions(_ sender: UIButton) {
        sender.updateStatusForTextEditor()
        
        if sender == btnIndentForward {
            delegate?.indentingForward(sender.isSelected)
        } else if sender == btnIndentBackward {
            delegate?.indentingBackward(sender.isSelected)
        }
    }
}

fileprivate extension UIButton {
    func updateStatusForTextEditor() {
        isSelected.toggle()
        backgroundColor = isSelected ? #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1) : #colorLiteral(red: 0.6979769468, green: 0.6980791688, blue: 0.6979545951, alpha: 1)
    }
}
