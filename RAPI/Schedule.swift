//
//  Schedule.swift
//  RAPI
//
//  Created by LA'D on 17.05.2020.
//  Copyright © 2020 Garonum. All rights reserved.
//

import UIKit

class Schedule: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()

//    @objc func hM() {print("test")
//            UIView.animate(withDuration: 0.5) {
//                                // self.blackView.alpha = 0
//
//                                 if let window = UIWindow.key {
//                                     self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
//                                 }
//                             }
//          }
    
    func showSettings() {
        //show menu
        
        
//        if let window = UIWindow.key {
//            //window.addSubview(collectionView)
//
//
//            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
//
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//
//                self.collectionView.frame = CGRect(x: 0, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
//
//            }, completion: nil)
//
//
//            //self.collectionView.addSubview(navBar)
//
//        }
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Расписание"
       let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
       navigationController?.navigationBar.titleTextAttributes = textAttributes
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
            self.navigationItem.rightBarButtonItem  = moreButton

    }
   
    @objc func handleMore() {
       print("test")
    }
}
extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
