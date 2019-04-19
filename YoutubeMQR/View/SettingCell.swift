//
//  SettingCell.swift
//  YoutubeMQR
//
//  Created by Pungs on 09/03/19.
//  Copyright © 2019 Pungs. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            IconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.black
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            
            if let imageName = setting?.imageName{
                IconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                IconImageView.tintColor = UIColor.darkGray
            }
            
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        return label
    }()
    
    let IconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "setting")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(IconImageView)
        
        addConstraintWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: IconImageView, nameLabel)
        addConstraintWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintWithFormat(format: "V:[v0(30)]", views: IconImageView)
        
        addConstraint(NSLayoutConstraint(item: IconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
