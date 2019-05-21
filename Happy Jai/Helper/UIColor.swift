//
//  UIColor.swift
//  Happy Jai
//
//  Created by Ken Ho on 26/1/2019.
//  Copyright © 2019 Happy Jai. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }

    static var primaryColor: UIColor {
        return UIColor(r: 250, g: 250, b: 250)
    }

    static var secondaryColor: UIColor {
        return UIColor(r: 255, g: 179, b: 0)
    }
    
    static var whatsappGray: UIColor {
        return UIColor(r: 236, g: 231, b: 222)
    }
    
}
