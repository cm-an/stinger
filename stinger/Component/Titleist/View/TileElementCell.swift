//
//  TileElementCell.swift
//  stinger
//
//  Created by 안춘모 on 2/21/24.
//

import UIKit

class TileElementCell: UICollectionViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.containerView.backgroundColor = .white
        
//        self.imageView.image = UIImage(named: "userInfoBlue30")
        self.titleLabel.attributedText =
            .attributedString(with: "test", font: .systemFont(ofSize: 14.0), color: .black)
    }
    
}
