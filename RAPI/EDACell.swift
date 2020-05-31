//
//  EDACell.swift
//  RAPI
//
//  Created by LA'D on 26.05.2020.
//  Copyright © 2020 Garonum. All rights reserved.
//



import UIKit

class EDACell: BaseCell {
    
//    override var isHighlighted: Bool {
//        didSet {
//            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
//            
//            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
//            
//            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
//        }
//    }
    
    var fullName: String? {
        didSet {
            nameLabel.text = fullName!
            
//            if let imageName = setting?.imageName {
//                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
//                iconImageView.tintColor = UIColor.darkGray
//            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nav_more_icon")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
       
   
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor(red: 0.6667, green: 0.702, blue: 1, alpha: 1.0)
        addSubview(nameLabel)
       addSubview(iconImageView)
        
        addConstraintsWithFormat("H:|-8-[v0][v1(30)]-8-|", views: nameLabel, iconImageView)
        
        addConstraintsWithFormat("V:|[v0]|", views: nameLabel)
        
        addConstraintsWithFormat("V:|-[v0(30)]-|", views: iconImageView)
        
        //addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
}






