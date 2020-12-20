//
//  ViewController.swift
//  TelstraPOC
//
//  Created by Anil Gupta on 17/12/20.
//  Copyright © 2020 Anil Gupta. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

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
    var viewModel = HomeViewModel()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let refreshControl = UIRefreshControl()
    var tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // adding UI conponents to view
        addActivityIndicator()  // Function to add activity Indicator
        addRefreshControl()     // Function to add Pull to Refresh feature
        addTableView()          // Function to add UITableView programmatically
        homeTableViewLayout()   // Table view layout
        homeAPICallForData()    // GET API call for home data
    }
    
    // Adding table view
    func addTableView() {
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeConstants.cellIdentifier)
        tableView.backgroundColor = UIColor.gray
        self.tableView.separatorColor = UIColor.clear
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(activityIndicator)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    func homeAPICallForData(){
        //checking network connectivity then call API service
         if Reachability.isConnectedToNetwork() {
            viewModel.homeViewController = self
            viewModel.getAllHomeData()
            self.navigationBarTitleSetup()
        } else {
            self.activityIndicator.stopAnimating()
            self.showAlert(title: HomeConstants.alertTitle, desc: HomeConstants.noNetworkAvailable)
        }
    }

    // Adding refresh control
    func addRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.attributedTitle = NSAttributedString(string: HomeConstants.updatingData)
        refreshControl.addTarget(self, action: #selector(refreshHomeData(_:)), for: .valueChanged)
    }

    // Adding activity indicator
    func addActivityIndicator() {
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
    }

    //Showing alert to user
    func showAlert(title: String, desc: String) {
        let alert = UIAlertController(title: title, message: desc, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: HomeConstants.okAlert, style: .default, handler: { action in
            switch action.style {
            case .default:
                    print(HomeConstants.defaultValue)
            case .cancel:
                    print(HomeConstants.cancelValue)
            case .destructive:
                    print(HomeConstants.destructiveValue)
            @unknown default: break
            }}))
        self.present(alert, animated: true, completion: nil)
    }

    // refreshing home screen data
    @objc func refreshHomeData(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            refreshHomeScreenPulled()
        } else {
            self.showAlert(title: HomeConstants.alertTitle, desc: HomeConstants.noNetworkAvailable)
        }
    }

    // home view layout using snapkit
    func homeTableViewLayout() {
        tableView.snp.makeConstraints {(make) -> Void in
            make.edges.equalToSuperview()
        }
    }

    //Refresh the data on pull to refresh
    func refreshHomeScreenPulled() {
        viewModel.getAllHomeData()
        if viewModel.baseModel != nil{
            self.activityIndicator.stopAnimating()
            self.refreshControl.endRefreshing()
            self.navigationBarTitleSetup()
            self.tableView.reloadData()
        }
    }

    //Function to set the title of the navigation bar
    func navigationBarTitleSetup() {
        guard let title = self.viewModel.baseModel?.title else { return }
        self.navigationController?.navigationBar.topItem?.title = title
    }
}

// Extension of UITableView
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.baseModel != nil {
            guard let count = viewModel.baseModel?.rows?.count else {return 0}
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeConstants.cellIdentifier, for: indexPath) as? HomeTableViewCell else {return UITableViewCell()}
        
        cell.descriptionLbl.text = nil
        cell.headingLbl.text = nil
        cell.thumbnailImage.image = UIImage(named: "placeholderImage")

        if viewModel.baseModel?.rows != nil {
                let headingLabel = self.viewModel.returnHeadingLabel(indexpath: indexPath.row)
                let descriptionLabel = self.viewModel.returnDescriptionLabel(indexpath: indexPath.row)
                let imageURL = self.viewModel.returnImage(indexpath: indexPath.row)

            if headingLabel != "" {
                cell.headingLbl.text = headingLabel
            }
            if descriptionLabel != "" {
                cell.descriptionLbl.text = descriptionLabel
            }
            if imageURL != "" {
                let urlForImage = URL(string: imageURL)
                cell.thumbnailImage.sd_setImage(with: urlForImage, placeholderImage: UIImage(named: "placeholderImage"), options: SDWebImageOptions(rawValue: 0), completed: { image, _, _, _ in
                        if image != nil {
                            cell.thumbnailImage.image = image
                    }
                })
            }
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
}
