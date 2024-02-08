//
//  GraphContainerViewController.swift
//  stinger
//
//  Created by 안춘모 on 2/8/24.
//

import UIKit

class GraphContainerViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        // Do any additional setup after loading the view.
    }
}
