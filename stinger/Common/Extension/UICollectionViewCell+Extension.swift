//
//  UICollectionViewCell+Extension.swift
//  stinger
//
//  Created by 안춘모 on 2/21/24.
//

import UIKit

public extension UICollectionReusableView {
    static func reuseIdentifier() -> String {
        return NSStringFromClass(self)
    }
}
