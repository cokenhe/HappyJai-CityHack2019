//
//  String.swift
//  Happy Jai
//
//  Created by Ken Ho on 27/1/2019.
//  Copyright © 2019 Happy Jai. All rights reserved.
//

import Foundation

extension String {

    static func randomEmoji() -> String{
        let emojiStart = 0x1F601
        let ascii = emojiStart + Int(arc4random_uniform(UInt32(35)))
        let emoji = UnicodeScalar(ascii)?.description
        return emoji ?? "x"
    }
}
