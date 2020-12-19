//
//  ViewController.swift
//  TelstraPOC
//
//  Created by Anil Gupta on 17/12/20.
//  Copyright © 2020 Anil Gupta. All rights reserved.
//

import UIKit
import SnapKit

struct HomeConstants {
static let noNetworkAvailable = "Please Check Network Connection"
static let alertTitle = "Alert"
static let cellIdentifier = "cell"
static let updatingData = "Updating Data"
static let errorAlertTitle = "Error"
static let okAlert = "OK"
static let defaultValue = "default"
static let cancelValue = "cancel"
static let destructiveValue = "destructive"
}

class ViewController: UIViewController {
    @IBOutlet weak var homeTableView: UITableView!
    var homeViewModelData = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        homeViewModelData.homeViewController = self
        homeViewModelData.getAllHomeData()
    }
}
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell
        
        return cell!
    }
}

