//
//  TableViewCell.swift
//  stinger
//
//  Created by 안춘모 on 2/2/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet private weak var firstLabel: UILabel!
    @IBOutlet private weak var secondLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(number: Int, string: String) {
        self.firstLabel.text = "\(number)"
        self.secondLabel.text = string
    }
    
}
