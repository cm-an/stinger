//
//  BaseTableViewController.swift
//  stinger
//
//  Created by 안춘모 on 2/2/24.
//

import UIKit

class BaseTableViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView?
    var refreshControl: UIRefreshControl?
    private(set) var isLoadingDataSource: Bool = false
    private(set) var isFinishedFirstTimeLoad: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if #available(iOS 15.0, *) {
            self.tableView?.sectionHeaderTopPadding = 0.0
        }
        if let tableView = self.tableView {
            tableView.layoutMargins = UIEdgeInsets(
                top: tableView.layoutMargins.top,
                left: 0.0,
                bottom: tableView.layoutMargins.bottom,
                right: 0.0)
        }
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
        self.tableView?.refreshControl = self.refreshControl
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
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
