//
//  CountScrollCell.swift
//  stinger
//
//  Created by 안춘모 on 2/21/24.
//

import UIKit

class CountScrollCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var countLabel: CountScrollLabel!
    @IBOutlet private(set) weak var startButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
        
        self.containerView.backgroundColor = .white
        self.startButton.setTitle("시작", for: .normal)
        self.countLabel.config(num: "7194736", duration: 1.3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchUpInsideStartButton(_ sender: Any) {
        self.countLabel.clear()
        self.countLabel.config(num: "5194736", duration: 1.3)
//        self.countLabel.animate(ascending: false)
    }
}
