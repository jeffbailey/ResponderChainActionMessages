//
//  UIButton+AppExtension.swift
//  SendActionDemo
//
//  Created by Jeff Bailey on 9/9/18.
//  Copyright © 2018 Jeff Bailey. All rights reserved.
//

import UIKit

extension UIButton {
    
    func app_setBackgroundColor(color: UIColor?, forState state: UIControl.State) {
        if let color = color {
            let backgroundImage = UIImage.app_imageColored(color: color)
            setBackgroundImage(backgroundImage, for: state)
        }
    }
    
    func app_styleRoundedButton(withTitle title: String, titleColor: UIColor, backgroundColor: UIColor, font: UIFont = UIFont.systemFont(ofSize: 16.0, weight: .medium)) {
        self.titleLabel?.font = font
        self.contentEdgeInsets = UIEdgeInsets(top: 12.0, left: 8.0, bottom: 12.0, right: 8.0)
        self.app_setBackgroundColor(color: backgroundColor, forState: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
        self.setTitle(title, for: .normal)
    }
    
    func app_styleRoundedPrimaryButton(withTitle title: String) {
        self.app_styleRoundedButton(withTitle: title, titleColor: .white, backgroundColor: UIColor.App.azure)
        self.setTitleColor(UIColor.App.blueSteel, for: .disabled)
    }
}
