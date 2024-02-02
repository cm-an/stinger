//
//  UITableViewCell+Extension.swift
//  stinger
//
//  Created by 안춘모 on 2/2/24.
//

import UIKit

public extension UITableViewCell {
    static func reuseIdentifier() -> String {
        return NSStringFromClass(self)
    }
}
