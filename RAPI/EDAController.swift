//
//  EDAController.swift
//  RAPI
//
//  Created by LA'D on 26.05.2020.
//  Copyright © 2020 Garonum. All rights reserved.
//

import UIKit
//    EDA = Employee Directory Administrator 
class EDAController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private let itemsPerRow: CGFloat = 3
    private let minimumItemSpacing: CGFloat = 13
   
    var users: [[String : AnyObject]]?
    var date:Int?
    var titles:[String]?
    
    func setupCollectionView() {
        view.backgroundColor = UIColor.blue
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        self.collectionView.register(EDACell.self, forCellWithReuseIdentifier: "EDACell")

        var topbarHeight: CGFloat {
                 return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                     (self.navigationController?.navigationBar.frame.height ?? 0.0) + 50
             }
        collectionView.frame = CGRect(x: 0, y: topbarHeight, width: view.frame.width, height:view.frame.height)
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        collectionView.isScrollEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        collectionView.isPagingEnabled = true
        collectionView.allowsMultipleSelection = false
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Управление справочником"
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
       let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
       navigationController?.navigationBar.titleTextAttributes = textAttributes
//
//        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
//            self.navigationItem.rightBarButtonItem  = moreButton
        
        setupCollectionView()
    }
   
//    let monthLauncher = MounthLauncher()
//    @objc func handleMore() {
//        monthLauncher.showMounth()
//    }
    
}

extension EDAController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return titles?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users?[section]["users"]?.count ?? 0
      }
      
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EDACell", for: indexPath) as! EDACell
        let fullName = users?[indexPath.section]["users"] as? [[String : AnyObject]]
        
        cell.fullName = fullName?[indexPath.row]["fullName"] as? String
          return cell
      }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
           //  if kind == UICollectionView.elementKindSectionHeader {
                 guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? Header
               else {
                        fatalError("Invalid view type")
                    }
        header.title =  titles?[indexPath.section]
                 header.backgroundColor = .blue
                 return header
//             }else{
//
//        }
        
         }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
       }
     
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
           let itemSize: CGSize
        itemSize = CGSize(width: (self.navigationController?.navigationBar.frame.width ?? 0) - 50, height: 50)
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       insetForSectionAt section: Int) -> UIEdgeInsets {
       return sectionInsets
   }
  
   
   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 1
   }
   
   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return minimumItemSpacing
   }
   
}
