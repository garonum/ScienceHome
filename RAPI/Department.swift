//
//  Department.swift
//  RAPI
//
//  Created by LA'D on 16.05.2020.
//  Copyright © 2020 Garonum. All rights reserved.
//

import UIKit

class Department: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
    
}
class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}

