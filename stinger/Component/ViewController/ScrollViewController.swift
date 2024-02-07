//
//  ScrollViewController.swift
//  stinger
//
//  Created by 안춘모 on 2/5/24.
//

import UIKit

class ScrollViewController: BaseViewController, UIScrollViewDelegate {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var containerView: UIView!
    
    @IBOutlet private weak var topContainer: UIView!
    @IBOutlet private weak var velocityLabel: UILabel!
    @IBOutlet private weak var translationLabel: UILabel!
    @IBOutlet private weak var directionLabel: UILabel!
    @IBOutlet private weak var etcLabel: UILabel!
    
    var dot: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "scroll"
        self.scrollView.delegate = self
        
//        self.containerView.frame = CGRect(x: 0.0, y: 0.0, width: self.scrollView.bounds.size.width, height: 1500.0)
        self.velocityLabel.text = "속도(velocity)\nx: \(0.0)\ny: \(0.0)"
        self.translationLabel.text = "이동거리(translation)\nx: \(0.0)\ny: \(0.0)"
        self.directionLabel.text = "방향(direction)\nx: -, y: -"
        self.directionLabel.textAlignment = .left
        self.etcLabel.text = ""
        
        self.dot.backgroundColor = .red
        self.dot.isUserInteractionEnabled = true
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggingView(_:)))
        self.dot.addGestureRecognizer(gesture)
        self.containerView.addSubview(self.dot)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView)
//        let tranlation = scrollView.panGestureRecognizer.translation(in: scrollView)
        
//        self.velocityLabel.text = "속도(velocity)\nx: \(velocity.x)\ny: \(velocity.y)"
//        self.translationLabel.text = "이동거리(translation)\nx: \(tranlation.x)\ny: \(tranlation.y)"
    }
    
    @objc func draggingView(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: self.containerView)
        let draggedView = sender.view!
        draggedView.center = point
        
        let number: Int = -5
        let convertWithAbs = abs(number)
        let convertWithMagnitude = number.magnitude
        
        
        
        let velocity = sender.velocity(in: self.containerView)
        let translation = sender.translation(in: self.containerView)
        let directionX = velocity.x < 0 ? "왼쪽" : "오른쪽"
        let directionY = velocity.y < 0 ? "위" : "아래"
        self.velocityLabel.text = "속도(velocity)\nx: \(velocity.x)\ny: \(velocity.y)"
        self.translationLabel.text = "이동거리(translation)\nx: \(translation.x)\ny: \(translation.y)"
        self.directionLabel.text = "방향(direction)\nx:\(directionX), y: \(directionY)"
    }
}
