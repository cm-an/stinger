//
//  GraphTableViewCell.swift
//  stinger
//
//  Created by 안춘모 on 2/8/24.
//

import UIKit

class GraphTableViewCell: InnerCollectionViewTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
