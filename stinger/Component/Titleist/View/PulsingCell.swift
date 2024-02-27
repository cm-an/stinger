//
//  PulsingCell.swift
//  stinger
//
//  Created by 안춘모 on 2/27/24.
//

import UIKit

class PulsingCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    
    let pulsingButton = PulsatingButton(frame: CGRect(x: 0.0, y: 0.0, width: 120.0, height: 120.0))
    let innerCircleView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 120.0, height: 120.0))

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.pulsingButton.center = self.containerView.center
        self.containerView.addSubview(self.pulsingButton)
        self.innerCircleView.backgroundColor = UIColor(red: 0.047, green: 0.349, blue: 0.949, alpha: 1)
        self.innerCircleView.layer.cornerRadius = 60.0
        self.pulsingButton.addSubview(self.innerCircleView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
