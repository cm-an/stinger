//
//  UINavigationBarAppearance+Extension.swift
//  stinger
//
//  Created by 안춘모 on 2/1/24.
//

import UIKit


extension UINavigationBarAppearance {
    static func opaqueWhiteBackground() -> UINavigationBarAppearance {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .white
        navigationBarAppearance.shadowColor = nil
        navigationBarAppearance.titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 18.0),
            .foregroundColor: UIColor.black
        ]
        return navigationBarAppearance
    }
    
    static func opaqueBlueBackground() -> UINavigationBarAppearance {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .blue
        navigationBarAppearance.shadowColor = nil
        navigationBarAppearance.titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 18.0),
            .foregroundColor: UIColor.white
        ]
        return navigationBarAppearance
    }
    
    static func transparentBlackBackground() -> UINavigationBarAppearance {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.backgroundColor = .black.withAlphaComponent(0.2)
        navigationBarAppearance.shadowColor = nil
        navigationBarAppearance.titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 18.0),
            .foregroundColor: UIColor.white
        ]
        return navigationBarAppearance
    }
}
