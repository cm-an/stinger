//
//  TileCell.swift
//  stinger
//
//  Created by 안춘모 on 2/21/24.
//

import UIKit

class TileCell: InnerCollectionViewTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .white
        
        self.collectionView.register(
            UINib(nibName: "TileElementCell", bundle: nil),
            forCellWithReuseIdentifier: TileElementCell.reuseIdentifier())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        let tileElementCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TileElementCell.reuseIdentifier(),
            for: indexPath) as! TileElementCell
        cell = tileElementCell
        
        return cell!
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 100.0)
    }
}
