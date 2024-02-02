//
//  BaseViewController.swift
//  stinger
//
//  Created by 안춘모 on 2/1/24.
//

import UIKit
import Combine

class BaseViewController: UIViewController, ControllerLifeCycleProtocol, ControllerLifeCycleDelegate {
    weak var controllerLifeCycleDelegate: ControllerLifeCycleDelegate?
    var isLocked: Bool = false
    private(set) var isViewAppeared: Bool = false
    
    var subscribers: Set<AnyCancellable> = Set<AnyCancellable>()
    var notificationObservers: Set<NSObject> = Set<NSObject>()
    
    let topSpacerView: UIView = UIView(frame: .zero)
    private(set) var navigationBarHeight: BaseNavigationController.NavigationBarHeight = .zero
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setSubscribers()
    }
    
    override init(nibName nibNameOrNil: String?,bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.setSubscribers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.subscribers.forEach({ $0.cancel() })
        self.notificationObservers.forEach({ NotificationCenter.default.removeObserver($0) })
        NotificationCenter.default.removeObserver(self)
    }
    
//    override var hidesBottomBarWhenPushed: Bool {
//        get {
//            return true
//        }
//        set {
//            super.hidesBottomBarWhenPushed = newValue
//        }
//    }
    
    override var additionalSafeAreaInsets: UIEdgeInsets {
        didSet {
            self.topSpacerView.frame = CGRect(
                x: 0.0,
                y: 0.0,
                width: UIApplication.shared.sceneDelegate!.window!.bounds.size.width,
                height: self.additionalSafeAreaInsets.top)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        self.view.insertSubview(self.topSpacerView, at: 0)
        self.additionalSafeAreaInsets = self.navigationBarHeight.viewControllerAddionalSafeAreaInsets
        if !(self.baseNavigationController?.isViewAppeared ?? false) {
            self.baseNavigationController?.additionalSafeAreaInsets = self.navigationBarHeight.navigationControllerAddionalSafeAreaInsets
        }
        if let navigationController = self.navigationController {
            self.navigationItem.setHidesBackButton(true, animated: false)
            self.updateNavigationBarButtons()
            
            if let presentedView = navigationController.presentationController?.presentedView, presentedView.isKind(of: NSClassFromString("UIDropShadowView")!), let interactivePopGestureRecognizer = navigationController.interactivePopGestureRecognizer {
                presentedView.gestureRecognizers?.forEach({ gestureRecognizer in
                    if gestureRecognizer.name == "_UISheetInteractionBackgroundDismissRecognizer" {
                        gestureRecognizer.require(toFail: interactivePopGestureRecognizer)
                    }
                })
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.isBeingPresented {
            self.controllerLifeCycleDelegate?.viewWillAppear(animated)
        }
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.isBeingPresented {
            self.controllerLifeCycleDelegate?.viewDidAppear(animated)
        }
        super.viewDidAppear(animated)
        self.isViewAppeared = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isBeingDismissed {
            self.controllerLifeCycleDelegate?.viewWillDisappear(animated)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.isViewAppeared = false
        
        if self.isBeingDismissed {
            self.controllerLifeCycleDelegate?.viewDidDisappear(animated)
        }
    }
    
    func screenCenter(from ancestorController: UIViewController) -> CGPoint {
        guard let parentController = ancestorController.parent else {
            return ancestorController.view.center
        }
        
        var screenCenter = self.screenCenter(from: parentController)
        screenCenter = ancestorController.view.convert(screenCenter, from: parentController.view)
        
        return screenCenter
    }
    
    func setSubscribers() { }
    
    func updateNavigationBarButtons() {
        guard let navigationController = self.navigationController else { return }
        if let firstViewController = navigationController.viewControllers.first, 
            firstViewController != self
        {
            self.navigationItem.leftBarButtonItem = self.backBarButton()
        } else if self.presentingViewController != nil {
            self.navigationItem.leftBarButtonItem = self.closeBarButton()
        }
    }
    
    func backBarButton() -> UIBarButtonItem {
        var image: UIImage
        image = UIImage(named: "backBlack24")!
        let barButton = UIBarButtonItem(
            image: image.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(self.touchUpInsideBackBarButton(_:)))
        
        return barButton
    }
    
    func closeBarButton() -> UIBarButtonItem {
        var image: UIImage
        image = UIImage(named: "closeBlack24")!
        let barButton = UIBarButtonItem(
            image: image.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(self.touchUpInsideCloseBarButton(_:)))
        
        return barButton
    }
    
    @objc func touchUpInsideBackBarButton(_ sender: Any) {
        if !self.isLocked {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func touchUpInsideCloseBarButton(_ sender: Any) {
        if !self.isLocked {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
