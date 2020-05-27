//
//  Schedule.swift
//  RAPI
//
//  Created by LA'D on 17.05.2020.
//  Copyright © 2020 Garonum. All rights reserved.
//

import UIKit

class Schedule: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var users: [[String : AnyObject]]?
    var date:Int?
    var curMounth = 0
    
    func setupCollectionView() {
        view.backgroundColor = UIColor.blue
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.register(ScheduleCell.self, forCellWithReuseIdentifier: "CellIDS")

        var topbarHeight: CGFloat {
                 return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                     (self.navigationController?.navigationBar.frame.height ?? 0.0) + 50
             }
        collectionView.frame = CGRect(x: 0, y: topbarHeight, width: view.frame.width, height:view.frame.height)
     
        //print(self.navigationController?.navigationItem.accessibilityFrame.height)
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = UIColor.white.withAlphaComponent(0.8)

        collectionView.isScrollEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
    
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }

        collectionView.isPagingEnabled = true
        collectionView.collectionViewLayout = CustomCollectionViewLayout()

        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Расписание"
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
       let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
       navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
            self.navigationItem.rightBarButtonItem  = moreButton
        
        
        setupCollectionView()
    }
   
    let monthLauncher = MounthLauncher()
    @objc func handleMore() {
        monthLauncher.showMounth()
    }
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private let itemsPerRow: CGFloat = 3
    private let minimumItemSpacing: CGFloat = 13
}

extension Schedule {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return users?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 31
      }
      
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIDS", for: indexPath) as! ScheduleCell
        //print(self.users?[indexPath.row]["fullName"])
       // cell.department = departments?[indexPath.item]
        if indexPath.row == 0 {
//            let user = users as [[String: AnyObject]]
//            print(user. as Any)
            if indexPath.section == 0 {
                cell.date = "ФИО/Дата"
            } else{
                cell.date = self.users?[indexPath.section]["fullName"] as? String
            }
          
            
        } else {
            if indexPath.section == 0 {
                cell.date = "\(indexPath.row)"
            } else{
                let dayStarus = self.users?[indexPath.section]["schedule"]?["\(curMounth)"] as? [String : String]
                cell.date = dayStarus?["1"] ?? "_"
            }
            
            
            
        }
        
        cell.backgroundColor = UIColor(red: 0.6667, green: 0.702, blue: 1, alpha: 1.0)
          return cell
      }
    
     
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
           let itemSize: CGSize

        itemSize = CGSize(width: 20, height: 15)
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
extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
class CustomCollectionViewLayout: UICollectionViewLayout {
    
    
    let CELL_HEIGHT = 50.0
    let CELL_WIDTH = 50.0
    let STATUS_BAR = UIApplication.shared.accessibilityFrame.height
//    let STATUS_BAR = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0//UIApplication.shared.statusBarFrame.height
 
    var cellAttrsDictionary = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    
    var contentSize = CGSize.zero
    
    
    var dataSourceDidUpdate = true
    
    override var collectionViewContentSize : CGSize {
        return self.contentSize
    }
    
    override func prepare() {
     
        if !dataSourceDidUpdate {
            
            // Determine current content offsets.
            let xOffset = collectionView!.contentOffset.x
            let yOffset = collectionView!.contentOffset.y
            
            if let sectionCount = collectionView?.numberOfSections, sectionCount > 0 {
                for section in 0...sectionCount-1 {
                    
                    // Confirm the section has items.
                    if let rowCount = collectionView?.numberOfItems(inSection: section), rowCount > 0 {
                        // Update all items in the first row.
                        if section == 0 {
                            for item in 0...rowCount-1 {
                                // Build indexPath to get attributes from dictionary.
                                let indexPath = IndexPath(item: item, section: section)
                                // Update y-position to follow user.
                                if let attrs = cellAttrsDictionary[indexPath] {
                                    var frame = attrs.frame
                                    // Also update x-position for corner cell.
                                    if item == 0 {
                                        frame.origin.x = xOffset
                                    }
                                    frame.origin.y = yOffset
                                    attrs.frame = frame
                                }
                                
                            }
                            
                            // For all other sections, we only need to update
                            // the x-position for the fist item.
                        } else {
                            
                            // Build indexPath to get attributes from dictionary.
                            let indexPath = IndexPath(item: 0, section: section)
                            
                            // Update y-position to follow user.
                            if let attrs = cellAttrsDictionary[indexPath] {
                                var frame = attrs.frame
                                frame.origin.x = xOffset
                                attrs.frame = frame
                            }
                            
                        } // else
                    } // num of items in section > 0
                } // sections for loop
            } // num of sections > 0
            
            
            // Do not run attribute generation code
            // unless data source has been updated.
            return
        }
        
        // Acknowledge data source change, and disable for next time.
        dataSourceDidUpdate = false
        
        // Cycle through each section of the data source.
        if let sectionCount = collectionView?.numberOfSections, sectionCount > 0 {
            for section in 0...sectionCount-1 {
                
                // Cycle through each item in the section.
                if let rowCount = collectionView?.numberOfItems(inSection: section), rowCount > 0 {
                    for item in 0...rowCount-1 {
                        if item == 0 {
                            // Build the UICollectionVieLayoutAttributes for the cell.
                            let cellIndex = IndexPath(item: item, section: section)
                            let xPos = Double(item) * 200
                            let yPos = Double(section) * CELL_HEIGHT
                            
                            let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
                            cellAttributes.frame = CGRect(x: xPos, y: yPos, width: 200, height: CELL_HEIGHT)
                            
                            // Determine zIndex based on cell type.
                            if section == 0 && item == 0 {
                                cellAttributes.zIndex = 4
                            } else if section == 0 {
                                cellAttributes.zIndex = 3
                            } else if item == 0 {
                                cellAttributes.zIndex = 2
                            } else {
                                cellAttributes.zIndex = 1
                            }
                            
                            // Save the attributes.
                            cellAttrsDictionary[cellIndex] = cellAttributes
                        } else{
                            // Build the UICollectionVieLayoutAttributes for the cell.
                          let cellIndex = IndexPath(item: item, section: section)
                          let xPos = Double(item) * CELL_WIDTH + 150
                          let yPos = Double(section) * CELL_HEIGHT
                          
                          let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
                          cellAttributes.frame = CGRect(x: xPos, y: yPos, width: CELL_WIDTH, height: CELL_HEIGHT)
                          
                          // Determine zIndex based on cell type.
                          if section == 0 && item == 0 {
                              cellAttributes.zIndex = 4
                          } else if section == 0 {
                              cellAttributes.zIndex = 3
                          } else if item == 0 {
                              cellAttributes.zIndex = 2
                          } else {
                              cellAttributes.zIndex = 1
                          }
                          
                          // Save the attributes.
                          cellAttrsDictionary[cellIndex] = cellAttributes
                        }
                        
                        
                    }
                }
                
            }
        }
        
        // Update content size.
        let contentWidth = Double(collectionView!.numberOfItems(inSection: 0)) * 200//CELL_WIDTH
        let contentHeight = Double(collectionView!.numberOfSections) * CELL_HEIGHT
        self.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // Create an array to hold all elements found in our current view.
        var attributesInRect = [UICollectionViewLayoutAttributes]()
        
        // Check each element to see if it should be returned.
        for cellAttributes in cellAttrsDictionary.values {
            if rect.intersects(cellAttributes.frame) {
                attributesInRect.append(cellAttributes)
            }
        }
        
        // Return list of elements.
        return attributesInRect
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttrsDictionary[indexPath]!
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
