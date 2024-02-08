//
//  InnerCollectionViewTableViewCell.swift
//  stinger
//
//  Created by 안춘모 on 2/7/24.
//

import UIKit

class InnerCollectionViewTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var tag: Int {
        didSet {
            self.collectionView.tag = self.tag
        }
    }
    
    func set(innerCollectionView contentOffset: CGPoint, animated: Bool) {
        self.collectionView.setContentOffset(contentOffset, animated: animated)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

}
