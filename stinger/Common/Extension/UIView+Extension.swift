//
//  UIView+Extension.swift
//  stinger
//
//  Created by 안춘모 on 2/2/24.
//

import UIKit
import MBProgressHUD

private var alreadySwizzled = false

private var kTopBorder = "TopBorder"
private var kTopBorderLeftMargin = "TopBorderLeftMargin"
private var kTopBorderRightMargin = "TopBorderLeftMargin"
private var kTopBorderTopMargin = "TopBorderTopMargin"

private var kBottomBorder = "BottomBorder"
private var kBottomBorderLeftMargin = "BottomBorderLeftMargin"
private var kBottomBorderRightMargin = "BottomBorderLeftMargin"
private var kBottomBorderBottomMargin = "BottomBorderBottomMargin"

private var kShapeBackground = "ShapeBackground"
private var kShapeBackgroundRoundingCorners = "ShapeBackgroundRoundingCorners"
private var kShapeBackgroundCornerRadii = "ShapeBackgroundCornerRadii"
private var kShapeBackgroundLeftMargin = "ShapeBackgroundLeftMargin"
private var kShapeBackgroundRightMargin = "ShapeBackgroundRightMargin"
private var kShapeBackgroundTopMargin = "ShapeBackgroundTopMargin"
private var kShapeBackgroundBottomMargin = "ShapeBackgroundBottomMargin"
private var kShapeBackgroundBorderWidth = "ShapeBackgroundBorderWidth"

private var kShapeBackgroundShadowColor = "ShapeBackgroundShadowColor"
private var kShapeBackgroundShadowOpacity = "ShapeBackgroundShadowOpacity"
private var kShapeBackgroundShadowOffset = "ShapeBackgroundShadowOffset"
private var kShapeBackgroundShadowBlur = "ShapeBackgroundShadowBlur"
private var kShapeBackgroundShadowSpread = "ShapeBackgroundShadowSpread"
private var shapeBackgroundShadowAdjustY = 7.0

extension UIView {
    
    // MARK: - method swizzling
    func swizzle(selector originalSelector: Selector, with swizzledSelector: Selector, inClass: AnyClass, usingClass: AnyClass) {
        guard let originalMethod = class_getInstanceMethod(inClass, originalSelector),
            let swizzledMethod = class_getInstanceMethod(usingClass, swizzledSelector)
            else { return }

        if class_addMethod(inClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod)) {
            class_replaceMethod(inClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    func installMethodSwizzling() {
        guard !alreadySwizzled else { return }
        
        alreadySwizzled = true
        self.swizzle(
            selector: #selector(layoutSubviews),
            with: #selector(__layoutSubviews),
            inClass: UIView.self,
            usingClass: UIView.self)
    }
    
    @objc func __layoutSubviews() {
        self.__layoutSubviews()
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        if let topBorder = objc_getAssociatedObject(self, &kTopBorder) as? CALayer {
            let leftMargin = objc_getAssociatedObject(self, &kTopBorderLeftMargin) as! CGFloat
            let rightMargin = objc_getAssociatedObject(self, &kTopBorderRightMargin) as! CGFloat
            let topMargin = objc_getAssociatedObject(self, &kTopBorderTopMargin) as! CGFloat
            topBorder.frame = CGRect(x: leftMargin,
                                     y: topMargin,
                                     width: self.bounds.size.width - leftMargin - rightMargin,
                                     height: topBorder.frame.size.height)
        }
        
        if let bottomBorder = objc_getAssociatedObject(self, &kBottomBorder) as? CALayer {
            let leftMargin = objc_getAssociatedObject(self, &kBottomBorderLeftMargin) as! CGFloat
            let rightMargin = objc_getAssociatedObject(self, &kBottomBorderRightMargin) as! CGFloat
            let bottomMargin = objc_getAssociatedObject(self, &kBottomBorderBottomMargin) as! CGFloat
            bottomBorder.frame = CGRect(x: leftMargin,
                                        y: self.bounds.size.height - bottomBorder.frame.size.height - bottomMargin,
                                        width: self.bounds.size.width - leftMargin - rightMargin,
                                        height: bottomBorder.frame.size.height)
        }
        
        if let shapeBackground = objc_getAssociatedObject(self, &kShapeBackground) as? CAShapeLayer {
            let corners = objc_getAssociatedObject(self, &kShapeBackgroundRoundingCorners) as! UIRectCorner
            let cornerRadii = objc_getAssociatedObject(self, &kShapeBackgroundCornerRadii) as! CGSize
            let leftMargin = objc_getAssociatedObject(self, &kShapeBackgroundLeftMargin) as! CGFloat
            let rightMargin = objc_getAssociatedObject(self, &kShapeBackgroundRightMargin) as! CGFloat
            let topMargin = objc_getAssociatedObject(self, &kShapeBackgroundTopMargin) as! CGFloat
            let bottomMargin = objc_getAssociatedObject(self, &kShapeBackgroundBottomMargin) as! CGFloat
            let borderWidth = objc_getAssociatedObject(self, &kShapeBackgroundBorderWidth) as! CGFloat
            var roundedRect = CGRect(x: borderWidth + leftMargin,
                                     y: borderWidth + topMargin,
                                     width: self.bounds.size.width - leftMargin - rightMargin - borderWidth * 2.0,
                                     height: self.bounds.size.height - topMargin - bottomMargin - borderWidth * 2.0)
            shapeBackground.path = UIBezierPath(roundedRect: roundedRect, byRoundingCorners: corners, cornerRadii: cornerRadii).cgPath
            shapeBackground.zPosition = 0
            
            if let _ = objc_getAssociatedObject(self, &kShapeBackgroundShadowColor) as? UIColor {
                let shadowSpread = objc_getAssociatedObject(self, &kShapeBackgroundShadowSpread) as! CGFloat
                if shadowSpread != 0 {
                    roundedRect = roundedRect.insetBy(dx: -shadowSpread, dy: -shadowSpread)
                }
                
                var shadowPath = shapeBackground.path!
                if !corners.contains(.bottomLeft), !corners.contains(.bottomRight) {
                    roundedRect.size.height += shapeBackgroundShadowAdjustY
                    shadowPath = UIBezierPath(roundedRect: roundedRect, byRoundingCorners: corners, cornerRadii: cornerRadii).cgPath
                } else if !corners.contains(.topLeft) && !corners.contains(.topRight) {
                    roundedRect.origin.y -= shapeBackgroundShadowAdjustY
                    roundedRect.size.height += shapeBackgroundShadowAdjustY
                    shadowPath = UIBezierPath(roundedRect: roundedRect, byRoundingCorners: corners, cornerRadii: cornerRadii).cgPath
                }
                shapeBackground.path = shadowPath
            }
        }
        CATransaction.commit()
    }
    
    // MARK: - border
    func setTopBorder(with color: UIColor,
                      height: CGFloat,
                      leftMargin: CGFloat,
                      rightMargin: CGFloat,
                      topMargin: CGFloat) {
        objc_setAssociatedObject(self, &kTopBorderLeftMargin, leftMargin, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kTopBorderRightMargin, rightMargin, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kTopBorderTopMargin, topMargin, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        let topBorder = objc_getAssociatedObject(self, &kTopBorder) as? CALayer ?? CALayer()
        if topBorder.superlayer == nil {
            self.installMethodSwizzling()
            self.layer.insertSublayer(topBorder, at: 0)
            objc_setAssociatedObject(self, &kTopBorder, topBorder, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        topBorder.backgroundColor = color.cgColor
        topBorder.frame = CGRect(x: leftMargin,
                                 y: topMargin,
                                 width: self.bounds.size.width - leftMargin - rightMargin,
                                 height: height)
        CATransaction.commit()
    }
    
    func removeTopBorder() {
        objc_setAssociatedObject(self, &kTopBorderLeftMargin, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kTopBorderRightMargin, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kTopBorderTopMargin, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        if let topBorder = objc_getAssociatedObject(self, &kTopBorder) as? CALayer {
            topBorder.removeFromSuperlayer()
            objc_setAssociatedObject(self, &kTopBorder, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setBottomBorder(with color: UIColor,
                         height: CGFloat,
                         leftMargin: CGFloat,
                         rightMargin: CGFloat,
                         bottomMargin: CGFloat) {
        objc_setAssociatedObject(self, &kBottomBorderLeftMargin, leftMargin, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kBottomBorderRightMargin, rightMargin, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kBottomBorderBottomMargin, bottomMargin, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        let bottomBorder = objc_getAssociatedObject(self, &kBottomBorder) as? CALayer ?? CALayer()
        if bottomBorder.superlayer == nil {
            self.installMethodSwizzling()
            self.layer.insertSublayer(bottomBorder, at: 0)
            objc_setAssociatedObject(self, &kBottomBorder, bottomBorder, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        bottomBorder.backgroundColor = color.cgColor
        bottomBorder.frame = CGRect(x: leftMargin,
                                    y: self.bounds.size.height - height - bottomMargin,
                                    width: self.bounds.size.width - leftMargin - rightMargin,
                                    height: height)
        CATransaction.commit()
    }
    
    func removeBottomBorder() {
        objc_setAssociatedObject(self, &kBottomBorderLeftMargin, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kBottomBorderRightMargin, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kBottomBorderBottomMargin, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        if let bottomBorder = objc_getAssociatedObject(self, &kBottomBorder) as? CALayer {
            bottomBorder.removeFromSuperlayer()
            objc_setAssociatedObject(self, &kBottomBorder, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - shape background
    func setShapeBackground(with color: UIColor,
                            corners: UIRectCorner,
                            cornerRadii: CGSize,
                            leftMargin: CGFloat,
                            rightMargin: CGFloat,
                            topMargin: CGFloat,
                            bottomMargin: CGFloat,
                            borderColor: UIColor,
                            borderWidth: CGFloat,
                            lineDashPattern: [NSNumber]? = nil) {
        objc_setAssociatedObject(self, &kShapeBackgroundRoundingCorners, corners, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundCornerRadii, cornerRadii, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundLeftMargin, leftMargin, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundRightMargin, rightMargin, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundTopMargin, topMargin, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundBottomMargin, bottomMargin, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundBorderWidth, borderWidth, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        let shapeBackground = objc_getAssociatedObject(self, &kShapeBackground) as? CAShapeLayer ?? CAShapeLayer()
        if shapeBackground.superlayer == nil {
            self.installMethodSwizzling()
            self.layer.insertSublayer(shapeBackground, at: 0)
            objc_setAssociatedObject(self, &kShapeBackground, shapeBackground, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        } else {
            shapeBackground.zPosition = -999
        }
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        shapeBackground.fillColor = color.cgColor
        shapeBackground.strokeColor = borderColor.cgColor
        shapeBackground.lineWidth = borderWidth
        shapeBackground.lineDashPattern = lineDashPattern
        var roundedRect = CGRect(x: borderWidth + leftMargin,
                                 y: borderWidth + topMargin,
                                 width: self.bounds.size.width - leftMargin - rightMargin - borderWidth * 2.0,
                                 height: self.bounds.size.height - topMargin - bottomMargin - borderWidth * 2.0)
        shapeBackground.path = UIBezierPath(roundedRect: roundedRect, byRoundingCorners: corners, cornerRadii: cornerRadii).cgPath
        
        guard let shadowColor = objc_getAssociatedObject(self, &kShapeBackgroundShadowColor) as? UIColor else {
            CATransaction.commit()
            return
        }
        let shadowOpacity = objc_getAssociatedObject(self, &kShapeBackgroundShadowOpacity) as! Float
        let shadowOffset = objc_getAssociatedObject(self, &kShapeBackgroundShadowOffset) as! CGSize
        let shadowBlur = objc_getAssociatedObject(self, &kShapeBackgroundShadowBlur) as! CGFloat
        let shadowSpread = objc_getAssociatedObject(self, &kShapeBackgroundShadowSpread) as! CGFloat
        if shadowSpread != 0 {
            roundedRect = roundedRect.insetBy(dx: -shadowSpread, dy: -shadowSpread)
        }
        
        var shadowPath = shapeBackground.path!
        if !corners.contains(.bottomLeft), !corners.contains(.bottomRight) {
            roundedRect.size.height += shapeBackgroundShadowAdjustY
            shadowPath = UIBezierPath(roundedRect: roundedRect, byRoundingCorners: corners, cornerRadii: cornerRadii).cgPath
        } else if !corners.contains(.topLeft) && !corners.contains(.topRight) {
            roundedRect.origin.y -= shapeBackgroundShadowAdjustY
            roundedRect.size.height += shapeBackgroundShadowAdjustY
            shadowPath = UIBezierPath(roundedRect: roundedRect, byRoundingCorners: corners, cornerRadii: cornerRadii).cgPath
        }
        shapeBackground.shadowColor = shadowColor.cgColor
        shapeBackground.shadowOpacity = shadowOpacity
        shapeBackground.shadowOffset = shadowOffset
        if shadowBlur > 0.0 {
            shapeBackground.shadowRadius = shadowBlur / 2.0
        }
        shapeBackground.path = shadowPath
        CATransaction.commit()
    }
    
    func setShapeBackgroundShadow(with color: UIColor,
                                  opacity: Float,
                                  offset: CGSize,
                                  blur: CGFloat,
                                  spread: CGFloat) {
        objc_setAssociatedObject(self, &kShapeBackgroundShadowColor, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundShadowOpacity, opacity, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundShadowOffset, offset, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundShadowBlur, blur, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundShadowSpread, spread, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        guard let shapeBackground = objc_getAssociatedObject(self, &kShapeBackground) as? CAShapeLayer else {
            return
        }
        shapeBackground.shadowColor = color.cgColor
        shapeBackground.shadowOpacity = opacity
        shapeBackground.shadowOffset = offset
        if blur > 0.0 {
            shapeBackground.shadowRadius = blur / 2.0
        }
    }
    
    func removeShapeBackground() {
        objc_setAssociatedObject(self, &kShapeBackgroundRoundingCorners, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundCornerRadii, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundLeftMargin, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundRightMargin, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundTopMargin, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundBottomMargin, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        objc_setAssociatedObject(self, &kShapeBackgroundShadowColor, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundShadowOpacity, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundShadowOffset, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundShadowBlur, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &kShapeBackgroundShadowSpread, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        guard let shapeBackground = objc_getAssociatedObject(self, &kShapeBackground) as? CAShapeLayer else {
            return
        }
        shapeBackground.removeFromSuperlayer()
        objc_setAssociatedObject(self, &kShapeBackground, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

private let ToastViewTag: Int = 500001
extension UIView {
    func showToastOnTop(message: String) {
        let showHUDBlock = {
            let hud = MBProgressHUD(view: self)
            hud.tag = ToastViewTag
            hud.removeFromSuperViewOnHide = true
            self.addSubview(hud)
            hud.isUserInteractionEnabled = false
            hud.bezelView.layer.cornerRadius = 30.0
            hud.mode = .text
            hud.label.font = .boldSystemFont(ofSize: 15.0)
            hud.label.text = message
            hud.animationType = .zoom
            hud.offset = CGPoint(x: 0.0, y: -(self.bounds.size.height * 0.5 - self.safeAreaInsets.top - hud.margin))
            hud.show(animated: true)
            hud.hide(animated: true, afterDelay: 3.0)
        }
        
        if let hud = self.viewWithTag(ToastViewTag) as? MBProgressHUD {
            hud.hide(animated: true)
            hud.completionBlock = {
                showHUDBlock()
            }
            return
        }
        showHUDBlock()
    }
    
    func showToastOnBottom(message: String) {
        let showHUDBlock = {
            let hud = MBProgressHUD(view: self)
            hud.tag = ToastViewTag
            hud.removeFromSuperViewOnHide = true
            self.addSubview(hud)
            hud.isUserInteractionEnabled = false
            hud.bezelView.layer.cornerRadius = 30.0
            hud.mode = .text
            hud.label.font = .boldSystemFont(ofSize: 15.0)
            hud.label.text = message
            hud.animationType = .zoom
            hud.offset = CGPoint(x: 0.0, y: self.bounds.size.height * 0.5 - self.safeAreaInsets.bottom - hud.margin)
            hud.show(animated: true)
            hud.hide(animated: true, afterDelay: 3.0)
        }
        
        if let hud = self.viewWithTag(ToastViewTag) as? MBProgressHUD {
            hud.hide(animated: true)
            hud.completionBlock = {
                showHUDBlock()
            }
            return
        }
        showHUDBlock()
    }
}

private let ProgressHUDTag: Int = ToastViewTag + 1
extension UIView {
//    func showProgressHUD(mode: MBProgressHUDMode = .annularDeterminate) -> MBProgressHUD {
//        let hud = MBProgressHUD(view: self)
//        hud.mode = mode
//        hud.backgroundColor = .black.withAlphaComponent(0.2)
//        hud.progress = 0.0
//        self.addSubview(hud)
//        let showHUDBlock = {
//            hud.show(animated: true)
//        }
//
//        if let hud = self.viewWithTag(ProgressHUDTag) as? MBProgressHUD {
//            hud.hide(animated: true)
//            hud.completionBlock = {
//                showHUDBlock()
//            }
//            return hud
//        }
//        showHUDBlock()
//        return hud
//    }
    
    func showProgressHUD(mode: MBProgressHUDMode = .annularDeterminate, isUserInteractionEnabled: Bool = true) -> MBProgressHUD {
        let hud = MBProgressHUD(view: self)
        hud.tag = ProgressHUDTag
        hud.removeFromSuperViewOnHide = true
        hud.mode = mode
        if mode == .customView {
            let activityIndicatorView = UIActivityIndicatorView(style: .medium)
            activityIndicatorView.color = .black
            activityIndicatorView.startAnimating()
            hud.customView = activityIndicatorView
            hud.margin = 10.0
        }
        hud.isUserInteractionEnabled = isUserInteractionEnabled
        if isUserInteractionEnabled {
            hud.backgroundColor = .black.withAlphaComponent(0.2)
        }
        hud.progress = 0.0
        let showHUDBlock = { [weak self] in
            self?.addSubview(hud)
            hud.show(animated: true)
        }
        
        if let shownHUD = self.viewWithTag(ProgressHUDTag) as? MBProgressHUD {
            shownHUD.hide(animated: true)
            shownHUD.completionBlock = {
                showHUDBlock()
            }
            return hud
        }
        showHUDBlock()
        return hud
    }
    
    func hideProgressHUD() {
        let hud = self.viewWithTag(ProgressHUDTag) as? MBProgressHUD
        hud?.hide(animated: true)
    }
    
    func adjustCenterOfProgressHUD(screenCenter: CGPoint) {
        let hud = self.viewWithTag(ProgressHUDTag) as? MBProgressHUD
        hud?.offset = CGPoint(
            x: 0.0,
            y: screenCenter.y - self.bounds.size.height * 0.5)
    }
}

extension UIView {
    func findSuperview<T>(of type: T.Type) -> T? {
        var superview = self.superview
        while superview != nil, !(superview is T) {
            superview = superview?.superview
        }
        return superview as? T
    }
    
    func removeAllConstraints() {
        var _superview = self.superview
        while let superview = _superview {
            for constraint in superview.constraints {
                if let first = constraint.firstItem as? UIView, first === self {
                    superview.removeConstraint(constraint)
                }
                
                if let second = constraint.secondItem as? UIView, second === self {
                    superview.removeConstraint(constraint)
                }
            }
            _superview = superview.superview
        }
        self.removeConstraints(self.constraints)
    }
}
