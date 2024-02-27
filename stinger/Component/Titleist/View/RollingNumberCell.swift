//
//  RollingNumberCell.swift
//  stinger
//
//  Created by 안춘모 on 2/22/24.
//

import UIKit
import RollingNumbers

class RollingNumberCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var rollingView: UIView!
    @IBOutlet private weak var rollingLabel: UILabel!
    @IBOutlet private weak var startButton: UIButton!
    
    var rollingNumbersView = RollingNumbersView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = .clear
        self.containerView.backgroundColor = .white
        self.rollingView.backgroundColor = .white
        self.rollingLabel.text = nil
        self.startButton.setTitle("시작", for: .normal)
        
        self.rollingNumbersView.frame = CGRect(
            x: 0.0,
            y: 0.0,
            width: 200.0,
            height: 50.0)
        self.rollingNumbersView.setNumber(7194736)
        self.rollingNumbersView.characterSpacing = 1
        self.rollingNumbersView.textColor = .black
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        self.rollingNumbersView.formatter = formatter
        self.rollingNumbersView.alignment = .left
        self.rollingNumbersView.font = .systemFont(ofSize: 20.0)
        
        self.rollingView.addSubview(self.rollingNumbersView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchUpInsideStartButton(_ sender: Any) {
        self.rollingNumbersView.setNumberWithAnimation(7194736, animationType: .allNumbers, rollingDirection: .up)
    }
}
