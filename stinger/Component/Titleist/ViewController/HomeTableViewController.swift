//
//  HomeTableViewController.swift
//  stinger
//
//  Created by 안춘모 on 2/21/24.
//

import UIKit

class HomeTableViewController: BaseTableViewController {
    
    private enum Section: Int, CaseIterable {
        case collection, number, rollingNumber, pulsing
    }
    
    override var navigationBarHeight: BaseNavigationController.NavigationBarHeight {
        get {
            return .ninety
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let logoButton = UIButton(type: .custom)
        logoButton.setImage(UIImage(named: "titleist"), for: .normal)
        logoButton.addTarget(self, action: #selector(self.touchUpInsideLeftBarButtonItem(_:)), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoButton)
        self.view.backgroundColor = .white
        self.tableView?.backgroundColor = .white
        
        self.tableView?.register(
            UINib(nibName: "TileCell", bundle: nil), 
            forCellReuseIdentifier: TileCell.reuseIdentifier())
        self.tableView?.register(
            UINib(nibName: "CountScrollCell", bundle: nil),
            forCellReuseIdentifier: CountScrollCell.reuseIdentifier())
        self.tableView?.register(
            UINib(nibName: "RollingNumberCell", bundle: nil),
            forCellReuseIdentifier: RollingNumberCell.reuseIdentifier())
        self.tableView?.register(
            UINib(nibName: "PulsingCell", bundle: nil),
            forCellReuseIdentifier: PulsingCell.reuseIdentifier())
    }


    
    // MARK: - touch up inside event
    @objc func touchUpInsideLeftBarButtonItem(_ sender: Any) {
        print("touchUpInside Titleist Logo")
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Section.collection.rawValue:
            return 0
        case Section.number.rawValue:
            return 1
        case Section.rollingNumber.rawValue:
            return 1
        case Section.pulsing.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch indexPath.section {
        case Section.collection.rawValue:
            let tileCell = tableView.dequeueReusableCell(
                withIdentifier: TileCell.reuseIdentifier()) as! TileCell
            cell = tileCell
        case Section.number.rawValue:
            let countScrollCell = tableView.dequeueReusableCell(
                withIdentifier: CountScrollCell.reuseIdentifier()) as! CountScrollCell
            cell = countScrollCell
        case Section.rollingNumber.rawValue:
            let rollingNumberCell = tableView.dequeueReusableCell(
                withIdentifier: RollingNumberCell.reuseIdentifier()) as! RollingNumberCell
            cell = rollingNumberCell
        case Section.pulsing.rawValue:
            let pulsingCell = tableView.dequeueReusableCell(
                withIdentifier: PulsingCell.reuseIdentifier()) as! PulsingCell
            pulsingCell.pulsingButton.pulse()
            cell = pulsingCell
        default:
            break
        }
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Section.collection.rawValue:
            return 100.0
        case Section.number.rawValue:
            return 130.0
        case Section.rollingNumber.rawValue:
            return 100.0
        case Section.pulsing.rawValue:
            return 200.0
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Section.collection.rawValue:
            return 100.0
        default:
            return UITableView.automaticDimension
        }
    }
}
