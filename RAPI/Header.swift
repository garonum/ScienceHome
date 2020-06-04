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
    
    var addUserButton: UIButton = {
           
      let button = UIButton.init(type: .system)
          button.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.blue.cgColor
          button.backgroundColor = UIColor(red: 0.2627, green: 0.8275, blue: 0.302, alpha: 1.0)
          button.titleLabel?.textColor = UIColor.black
          button.tintColor = UIColor.white
          button.layer.cornerRadius = 15.0
          button.setTitle("+Сотрудник", for: .normal)
          button.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
        
        return button
           
          }()
    
    @objc func buttonClicked() {
        
    }
    
   
       
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
   
    
    override func setupViews() {
        addSubview(titleLabel)
        addSubview(addUserButton)
        
        
        addConstraintsWithFormat("H:|-25-[v0][v1(100)]-15-|", views: titleLabel, addUserButton)
               
        //addConstraintsWithFormat("H:|-25-[v0]|", views: titleLabel)
        addConstraintsWithFormat("V:|-[v0]-|", views: titleLabel)
        
        //addConstraintsWithFormat("H:|-25-[v0]|", views: addUserButton)
        addConstraintsWithFormat("V:|-[v0]-|", views: addUserButton)
        
    }
    
   
}
