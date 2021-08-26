//
//  UIColor-Extension.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import UIKit

extension UIColor {

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }

    static let navBarColor = rgb(red: 39, green: 49, blue: 69)

    static let chatRoomBackColor = rgb(red: 118, green: 140, blue: 180)
}
