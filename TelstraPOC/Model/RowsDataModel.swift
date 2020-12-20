//
//  RowsDataModel.swift
//  TelstraPOC
//
//  Created by Anil Gupta on 18/12/20.
//  Copyright © 2020 Anil Gupta. All rights reserved.
//

import Foundation
import UIKit

struct RowsDataModel: Codable {
    let title: String?
    let description: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case imageHref = "imageHref"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageHref = try values.decodeIfPresent(String.self, forKey: .imageHref)
    }
}
