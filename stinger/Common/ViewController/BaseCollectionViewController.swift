//
//  BaseCollectionViewController.swift
//  stinger
//
//  Created by 안춘모 on 2/7/24.
//

import UIKit

class BaseCollectionViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView?
    var refreshControl: UIRefreshControl?
    private(set) var isLoadingDataSource: Bool = false
    private(set) var isFinishedFirstTimeLoad: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.alwaysBounceVertical = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.adjustCenterOfProgressHUD(screenCenter: self.screenCenter(from: self))
    }
    
    func useRefreshControl() {
        guard self.refreshControl == nil else { return }
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(
            self,
            action: #selector(self.valueChangedRefreshControl(_:)),
            for: .valueChanged)
    }
    
    func reloadDataSource() {
        self.isLoadingDataSource = true
        _ = self.view.showProgressHUD(mode: .customView, isUserInteractionEnabled: false)
    }
    
    func beginRefreshing() {
        self.reloadDataSource()
        self.isLoadingDataSource = true
    }
    
    func endRefreshing() {
        self.isLoadingDataSource = false
        self.isFinishedFirstTimeLoad = true
        self.view.hideProgressHUD()
    }
    
    // MARK: - value change event
    @objc func valueChangedRefreshControl(_ sender: Any) {
        if self.refreshControl!.isRefreshing {
            self.beginRefreshing()
        } else {
            self.endRefreshing()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
