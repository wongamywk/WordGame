//
//  UIImage+Extension.swift
//  WordGame
//
//  Created by Max Lampert on 12/22/15.
//  Copyright © 2015 Max Lampert. All rights reserved.
//

import Foundation
import Photos

extension UIImage {
    class func imageWithColor(color: UIColor, rect: CGRect? = nil) -> UIImage {
        var drawRect: CGRect
        if(rect == nil) {
            drawRect = CGRectMake(0,0,1,1)
        } else {
            drawRect = rect!
        }

        UIGraphicsBeginImageContext(drawRect.size)
        let context: CGContextRef = UIGraphicsGetCurrentContext()!

        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, drawRect)

        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}