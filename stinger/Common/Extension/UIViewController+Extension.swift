//
//  UIViewController+Extension.swift
//  stinger
//
//  Created by 안춘모 on 2/1/24.
//

import UIKit

extension UIViewController {
    func topVisibleRootController() -> UIViewController {
        guard var topController = UIApplication.shared.sceneDelegate?.window?.rootViewController else { return self}
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
    
    func topVisibleController() -> UIViewController {
        var topVisibleController = self.topVisibleRootController()
        while (topVisibleController as? BaseViewController) == nil {
            if let navigationController = topVisibleController as? UINavigationController {
                topVisibleController = navigationController.visibleViewController!
            }
        }
        return topVisibleController
    }
    
    var baseNavigationController: BaseNavigationController? {
        get {
            return self.navigationController as? BaseNavigationController
        }
    }
}
