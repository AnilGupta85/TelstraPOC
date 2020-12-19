//
//  HomeViewModel.swift
//  TelstraPOC
//
//  Created by Anil Gupta on 18/12/20.
//  Copyright © 2020 Anil Gupta. All rights reserved.
//

import Foundation
import Alamofire

class HomeViewModel{

weak var homeViewController: ViewController?
var homeData = [HomeBaseModel]()

func getAllHomeData(){
    AF.request("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json").response { response in
        if let data = response.data {
            do{
                let jsonAPIResponse = try JSONDecoder().decode([HomeBaseModel].self, from: data)
                self.homeData.append(contentsOf: jsonAPIResponse)
                DispatchQueue.main.async{
                 self.homeViewController?.homeTableView.reloadData()
                }
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
  }
}
