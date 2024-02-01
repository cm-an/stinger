//
//  BaseNavigationController.swift
//  stinger
//
//  Created by 안춘모 on 2/1/24.
//

import UIKit

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate, ControllerLifeCycleProtocol, ControllerLifeCycleDelegate {
    
    enum NavigationBarStyle {
        case opaqueWhite, opaqueBlue, transparentBlack
        
        var navigationBarAppearance: UINavigationBarAppearance {
            switch self {
            default:
                return .opaqueWhiteBackground()
            }
        }
        
    }
    
    enum NavigationBarHeight {
        case zero, sixty, ninety

        var navigationControllerAddionalSafeAreaInsets: UIEdgeInsets {
            switch self {
            case .zero:
                return .zero
            case .sixty:
                return UIEdgeInsets(top: 13.0, left: 0.0, bottom: 0.0, right: 0.0)
            case .ninety:
                return UIEdgeInsets(top: 30.0, left: 0.0, bottom: 0.0, right: 0.0)
            }
        }
        
        var viewControllerAddionalSafeAreaInsets: UIEdgeInsets {
            switch self {
            case .zero:
                return .zero
            case .sixty:
                return UIEdgeInsets(top: 13.0, left: 0.0, bottom: 0.0, right: 0.0)
            case .ninety:
                return UIEdgeInsets(top: 16.0, left: 0.0, bottom: 0.0, right: 0.0)
            }
        }
    }
    
    private(set) var navigationBarStyle: NavigationBarStyle = .opaqueWhite
    
    weak var controllerLifeCycleDelegate: ControllerLifeCycleDelegate?
    var isLocked: Bool = false
    private(set) var isViewAppeared: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.set(navigationBarStyle: self.navigationBarStyle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isViewAppeared = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.isViewAppeared = false
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return self.topViewController?.prefersStatusBarHidden ?? super.prefersStatusBarHidden
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return self.topViewController?.preferredStatusBarStyle ?? super.preferredStatusBarStyle
        }
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        get {
            return self.topViewController?.preferredStatusBarUpdateAnimation ?? super.preferredStatusBarUpdateAnimation
        }
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        guard self.isViewAppeared else { return }
        
        if self.isBeingPresented {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        } else {
            UIView.animate(
                withDuration: 0.25,
                delay: 0.0,
                options: .curveEaseInOut) {
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func set(navigationBarStyle: NavigationBarStyle) {
        self.navigationBarStyle = navigationBarStyle
        let navigationBarAppearance = navigationBarStyle.navigationBarAppearance
        self.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationBar.compactAppearance = navigationBarAppearance
        self.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        if let viewController = self.topViewController as? BaseViewController {
            viewController.topSpacerView.backgroundColor = navigationBarAppearance.backgroundColor
        }
    }
}
