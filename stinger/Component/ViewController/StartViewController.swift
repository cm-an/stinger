//
//  StartViewController.swift
//  stinger
//
//  Created by 안춘모 on 2/1/24.
//

import UIKit

class StartViewController: BaseViewController {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.containerView.backgroundColor = .white
        
        self.nextButton.addTarget(self, action: #selector(self.touchUpInsideNextButton(_:)), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    @objc func touchUpInsideNextButton(_ sender: Any) {
        let secondViewController = SecondViewController()
        self.baseNavigationController?.pushViewController(secondViewController, animated: true)
    }
}
