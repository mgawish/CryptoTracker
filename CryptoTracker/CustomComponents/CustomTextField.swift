//
//  CustomTextFiedl.swift
//  CryptoTracker
//
//  Created by Gawish on 18/05/2021.
//

import UIKit

class CustomTextField: UITextField {
    let edgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: edgeInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: edgeInsets)
    }
}
