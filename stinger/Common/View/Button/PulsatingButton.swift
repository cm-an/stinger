//
//  PulsatingButton.swift
//  stinger
//
//  Created by 안춘모 on 2/27/24.
//

import UIKit

class PulsatingButton: UIButton {
    let pulseLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.strokeColor = UIColor.clear.cgColor
        shape.lineWidth = 10
        shape.fillColor = UIColor(red: 0.047, green: 0.349, blue: 0.949, alpha: 0.1).cgColor
        shape.lineCap = .round
        return shape
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupShapes()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupShapes()
    }
    
    private func setupShapes() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        let backgroundLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: self.center, radius: bounds.size.height / 2, startAngle: 0.0, endAngle: 2 * .pi, clockwise: true)
        
        self.pulseLayer.frame = bounds
//        self.pulseLayer.frame.size = CGSize(width: 180.0, height: 180.0)
        self.pulseLayer.path = circularPath.cgPath
        self.pulseLayer.position = self.center
        self.layer.addSublayer(self.pulseLayer)
        
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.lineWidth = 10
        backgroundLayer.fillColor = UIColor(red: 0.047, green: 0.349, blue: 0.949, alpha: 1).cgColor
        backgroundLayer.lineCap = .round
//        self.layer.addSublayer(backgroundLayer)
    }
    
    func pulse() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.2
        animation.toValue = 1.4
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name:.easeOut)
        animation.autoreverses = true
        animation.repeatCount = .infinity
//        self.layer.add(animation, forKey: nil)
        self.pulseLayer.add(animation, forKey: "pulsing")
    }
}
