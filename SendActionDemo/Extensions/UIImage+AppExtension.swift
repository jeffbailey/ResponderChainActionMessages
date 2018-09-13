//
//  UIImage+AppExtension.swift
//  SendActionDemo
//
//  Created by Jeff Bailey on 9/9/18.
//  Copyright © 2018 Jeff Bailey. All rights reserved.
//

import UIKit

extension UIImage {    
    class func app_imageColored(color: UIColor, width: CGFloat = 1.0, height: CGFloat = 1.0) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(rect.size, color.cgColor.alpha == 1, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
