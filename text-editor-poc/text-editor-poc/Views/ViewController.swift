//
//  ViewController.swift
//  text-editor-poc
//
//  Created by Bartsch Tha, Leandro on 26/11/19.
//  Copyright © 2019 Bartsch Tha, Leandro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tvTest: CustomTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvTest.delegate = self
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        if let range = textView.selectedTextRange {
            print(textView.text(in: range))
        }
    }
}
