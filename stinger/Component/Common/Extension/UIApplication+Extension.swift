//
//  UIApplication+Extension.swift
//  stinger
//
//  Created by 안춘모 on 2/1/24.
//

import UIKit

extension UIApplication {
    var sceneDelegate: SceneDelegate? {
        guard let windowScene = self.connectedScenes.first else { return nil }
        return windowScene.delegate as? SceneDelegate
    }
}
