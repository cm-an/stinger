//
//  StartViewController.swift
//  stinger
//
//  Created by 안춘모 on 2/1/24.
//

import UIKit

class StartViewController: BaseViewController {
    override var navigationBarHeight: BaseNavigationController.NavigationBarHeight {
        get {
            return .sixty
        }
    }
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var nextnextButton: UIButton!
    @IBOutlet private weak var nextnextnextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.containerView.backgroundColor = .white
        
        self.nextButton.addTarget(self, action: #selector(self.touchUpInsideNextButton(_:)), for: .touchUpInside)
        self.nextnextButton.addTarget(self, action: #selector(self.touchUpInsideNextNextButton(_:)), for: .touchUpInside)
        self.nextnextnextButton.addTarget(self, action: #selector(self.touchUpInsideNextNextNextButton(_:)), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    @objc func touchUpInsideNextButton(_ sender: Any) {
        let secondViewController = SecondViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc func touchUpInsideNextNextButton(_ sender: Any) {
        let tableViewController = TableViewController()
        self.navigationController?.pushViewController(tableViewController, animated: true)
    }
    
    @objc func touchUpInsideNextNextNextButton(_ sender: Any) {
        let scrollViewController = ScrollViewController()
        self.navigationController?.pushViewController(scrollViewController, animated: true)
    }
}
