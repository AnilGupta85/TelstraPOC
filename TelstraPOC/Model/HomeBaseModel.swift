//
//  HomeBaseModel.swift
//  TelstraPOC
//
//  Created by Anil Gupta on 18/12/20.
//  Copyright © 2020 Anil Gupta. All rights reserved.
//

import Foundation
import UIKit

struct HomeBaseModel : Codable {
let title: String?
let rows: [RowsDataModel]?

enum CodingKeys: String, CodingKey {
case title = "title"
case rows = "rows"
}

init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    title = try values.decodeIfPresent(String.self, forKey: .title)
    rows = try values.decodeIfPresent([RowsDataModel].self, forKey: .rows)
 }
}

