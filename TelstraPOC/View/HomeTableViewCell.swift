//
//  HomeTableViewCell.swift
//  TelstraPOC
//
//  Created by Anil Gupta on 18/12/20.
//  Copyright © 2020 Anil Gupta. All rights reserved.
//

import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {
    let thumbnailImage = UIImageView()
    let headingLbl = UILabel()
    let descriptionLbl = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        //adding image view to content view
        contentView.addSubview(thumbnailImage)
        thumbnailImage.contentMode = .scaleAspectFill
        thumbnailImage.clipsToBounds = true

        //adding heading label to content view
        headingLbl.textColor = UIColor.black
        headingLbl.numberOfLines = 0
        headingLbl.lineBreakMode = .byWordWrapping
        headingLbl.font = UIFont(name: "ArialMT", size: 18.0)
        contentView.addSubview(headingLbl)

        //adding description label to content view
        descriptionLbl.textColor = UIColor.gray
        descriptionLbl.numberOfLines = 0
        descriptionLbl.textAlignment = .left
        descriptionLbl.lineBreakMode = .byWordWrapping
        descriptionLbl.font = UIFont(name: "ArialMT", size: 12.0)
        contentView.addSubview(descriptionLbl)
        
        //updaing the constraints
        setNeedsUpdateConstraints()
    }

    //updating the constraints using SnapKit framework
    override func updateConstraints() {
        //adding constraints for ImageView
        thumbnailImage.snp.updateConstraints {(make) -> Void in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(100)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
        //adding constraints for Heading Label
        headingLbl.snp.updateConstraints {(make) -> Void in
            make.top.equalTo(thumbnailImage.snp.top)
            make.left.equalTo(thumbnailImage.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
        }
        //adding constraints for Description Label
        descriptionLbl.snp.updateConstraints {(make) -> Void in
            make.left.equalTo(headingLbl.snp.left)
            make.right.equalTo(headingLbl.snp.right)
            make.top.equalTo(headingLbl.snp.bottom).offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
        super .updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
