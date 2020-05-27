//
//  ScheduleClell.swift
//  RAPI
//
//  Created by LA'D on 20.05.2020.
//  Copyright © 2020 Garonum. All rights reserved.
//

import UIKit

class ScheduleCell: BaseCell {
    var department: Department? {
        didSet {
            //titleLabel.text = department?.title
                        
        }
    }
    var date: String? {
           didSet {
            titleLabel.text = date!
                           
           }
       }
    var fullname: String? {
        didSet {
         titleLabel.text = fullname
                        
        }
    }

   
    override func setupViews() {
        
      addSubview(titleLabel)
        addConstraintsWithFormat("H:|[v0]|", views: titleLabel)
        addConstraintsWithFormat("V:|[v0]|", views: titleLabel)
    }
    
    let titleLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = ""
           label.numberOfLines = 2
           return label
       }()
    
    
    static var identifier: String = "Cell"

    weak var textLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            self.contentView.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
        ])
        self.textLabel = textLabel
        self.reset()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }

    func reset() {
        self.textLabel.textAlignment = .center
    }
}
