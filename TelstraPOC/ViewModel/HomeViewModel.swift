//
//  HomeViewModel.swift
//  TelstraPOC
//
//  Created by Anil Gupta on 18/12/20.
//  Copyright © 2020 Anil Gupta. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewModel {
    // MARK: - URL
    private var apiURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    weak var homeViewController: HomeViewController?
    var baseModel: HomeBaseModel?

func getAllHomeData() {
        URLSession.shared.dataTask(with: URL(string: apiURL)!) { (data, response, error) in
            if error == nil {
                // encoding the data received to UTF8
                  let encodingString = String(data: data!, encoding: .isoLatin1)
                  let dataUsingTF8: Data? = encodingString?.data(using: .utf8)
                      if let dataUsingTF8 = dataUsingTF8 {
                    do {  // Parse JSON response
                        let jsonAPIResponse = try JSONDecoder().decode(HomeBaseModel.self, from: dataUsingTF8)
                        self.baseModel = jsonAPIResponse
                        debugPrint(jsonAPIResponse)
                        DispatchQueue.main.async {
                            self.homeViewController?.activityIndicator.stopAnimating()
                            self.homeViewController?.refreshControl.endRefreshing()
                            self.homeViewController?.tableView.reloadData()
                            // Set the title of the navigation bar
                            guard let title = self.baseModel?.title else { return }
                            self.homeViewController?.navigationController?.navigationBar.topItem?.title = title
                        }
                    } catch let error as NSError {
                        debugPrint("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                    }
                }
            } else {
                debugPrint(error?.localizedDescription as Any)
            }
        }.resume()
  }

    // returing the heading label to view controller
    func returnHeadingLabel(indexpath: Int) -> String {
        guard let headingLabel = self.baseModel?.rows?[indexpath].title else { return ""}
        return headingLabel
    }

    // returing the description label to view controller
    func returnDescriptionLabel(indexpath: Int) -> String {
        guard let descriptionLabel = self.baseModel?.rows?[indexpath].description else { return ""}
        return descriptionLabel
    }

    // returing the imageUrl String to view controller
    func returnImage(indexpath: Int) -> String {
        guard let imageUrl = self.baseModel?.rows?[indexpath].imageHref else { return ""}
        return imageUrl
    }
}
