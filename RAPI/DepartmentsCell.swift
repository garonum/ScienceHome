//
//  VideoCell.swift
//  youtube
//
//  Created by Brian Voong on 6/3/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DepartmentsCell: BaseCell {
    var department: Department? {
        didSet {
            titleLabel.text = department?.title
                        
        }
    }

   
    override func setupViews() {
        
      addSubview(titleLabel)
        addConstraintsWithFormat("H:|-16-[v0]|", views: titleLabel)
        addConstraintsWithFormat("V:|[v0]|", views: titleLabel)
    }
    
    let titleLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = ""
           label.numberOfLines = 2
           return label
       }()
}
