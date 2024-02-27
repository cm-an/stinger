//
//  CountScrollLabel.swift
//  stinger
//
//  Created by 안춘모 on 2/21/24.
//

import UIKit

class CountScrollLabel: UILabel {
    private var scrollLayers: [CAScrollLayer] = []
    private var labels: [UILabel] = []
    private var duration: TimeInterval = 0
    private var originText: String = ""
    
    
    func config(num: String, duration: TimeInterval) {
        self.originText = num
        self.duration = duration
        self.setupLabel(numString: num)
    }
    
    private func setupLabel(numString: String) {
        let numArr = numString.map { String($0) }
        var x: CGFloat = 0.0
        let y: CGFloat = -10.0
        var isLastIndex: Bool = false
        var isMarkedComma: Bool = false

        numArr.enumerated().forEach {
            let label = UILabel()
            label.frame.origin = CGPoint(x: x, y: y)
            if $0.offset == numArr.count - 1 {
                isLastIndex = true
                isMarkedComma = false
                label.text = "0원"
            } else if ($0.offset + 1 - numArr.count) % 3 == 0 {
                isLastIndex = false
                isMarkedComma = true
                label.text = "0,"
            } else {
                isLastIndex = false
                isMarkedComma = false
                label.text = "0"
            }
            label.font = .boldSystemFont(ofSize: 20)
            label.textAlignment = .center
            label.textColor = .black
            label.sizeToFit()
            self.createScrollLayer(label: label, num: Int($0.element)!, isLastIndex: isLastIndex, isMarkedComma: isMarkedComma)
            x += label.bounds.width
        }
    }
    
    private func createScrollLayer(label: UILabel, num: Int, isLastIndex: Bool, isMarkedComma: Bool) {
        let scrollLayer = CAScrollLayer()
        scrollLayer.frame = label.frame
        self.scrollLayers.append(scrollLayer)
        self.layer.addSublayer(scrollLayer)
        
        self.makeScrollContent(num: num, scrollLayer: scrollLayer, isLastIndex: isLastIndex, isMarkedComma: isMarkedComma)
    }
    
    private func makeScrollContent(num: Int, scrollLayer: CAScrollLayer, isLastIndex: Bool, isMarkedComma: Bool) {
        var numSet: [Int] = [0]
        for i in num...num + 10 {
            let contentNum = i > 9 ? i % 10 : i
            numSet.append(contentNum)
        }
        var height: CGFloat = 0
        for i in numSet {
            let label = UILabel()
            if isLastIndex {
                label.text = "\(i)원"
            } else if isMarkedComma {
                label.text = "\(i),"
            } else {
                label.text = "\(i)"
            }
            label.font = .boldSystemFont(ofSize: 20)
            label.frame = .init(x: 0 , y: height, width: scrollLayer.frame.width + 0.5, height: scrollLayer.frame.height)
            label.textAlignment = .center
            label.textColor = .black
            scrollLayer.addSublayer(label.layer)
            self.labels.append(label)
            height = label.frame.maxY
        }
        
        self.animate(ascending: false)
    }
    
    func animate(ascending: Bool) {
        var offset: TimeInterval = 0.0
        for scrollLayer in self.scrollLayers {
            let maxY = scrollLayer.sublayers?.last?.frame.origin.y ?? 0
            let animation = CABasicAnimation(keyPath: "sublayerTransform.translation.y")
            animation.duration = self.duration + offset
            animation.timingFunction = .init(name: .easeOut)
            
            if ascending {
                animation.toValue = 0
                animation.fromValue = maxY
            } else {
                animation.toValue = maxY
                animation.fromValue = 0
            }
            
            scrollLayer.scrollMode = .vertically
            scrollLayer.add(animation, forKey: nil)
            scrollLayer.scroll(to: CGPoint(x: 0.0, y: maxY))
            
            offset -= 0.1
        }
    }
    
    func clear() {
        self.labels = []
        self.scrollLayers = []
        self.duration = 0.0
        self.originText = ""
        self.layer.removeAllAnimations()    
        self.layer.sublayers?.removeAll()
        self.config(num: self.originText, duration: self.duration)
    }
}
