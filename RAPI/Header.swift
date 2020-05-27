//
//  Header.swift
//  RayNutrition_1.0
//
//  Created by LA'D on 07.05.2020.
//  Copyright © 2020 Garonum. All rights reserved.
//

import UIKit

class Header: BaseCell {
    
    var title:String? {
    didSet {
        
        titleLabel.text = title
        
        }
        
    }
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 2
        label.textColor = UIColor.white
        return label
    }()
    
   
       
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
   
    
    override func setupViews() {
        addSubview(titleLabel)
        
        addConstraintsWithFormat("H:|-25-[v0]|", views: titleLabel)
        addConstraintsWithFormat("V:|-5-[v0]|", views: titleLabel)
        
    }
    
   
}
