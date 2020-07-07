//
//  CardView.swift
//  Saida Carpet
//
//  Created by Vikas Gupta on 01/07/20.
//  Copyright © 2020 Amit Verma. All rights reserved.
//

import UIKit

@IBDesignable

class CardView: UIView {
   
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 1
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.clear
    @IBInspectable var shadowOpacity: Float = 1

    override func layoutSubviews() {
        
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        
    }
   
}
