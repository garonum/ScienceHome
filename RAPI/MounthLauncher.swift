//
//  MounthLauncher.swift
//  RAPI
//
//  Created by LA'D on 22.05.2020.
//  Copyright © 2020 Garonum. All rights reserved.
//
import UIKit

class MounthLauncher:  BaseCell,
UIPickerViewDelegate, UIPickerViewDataSource {
    
    let blackView = UIView()
    let mounthArray = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Деркабрь"]
             
    let mounthView = UIView()
    
    func showMounth() {
           //show menu
           
           if let window = UIWindow.key {
               
               blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
               
               blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
               
               window.addSubview(blackView)
               mounthView.backgroundColor = UIColor.white
               window.addSubview(mounthView)
            
                UIPicker.delegate = self as UIPickerViewDelegate
                UIPicker.dataSource = self as UIPickerViewDataSource
                UIPicker.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: 200)
                mounthView.addSubview(UIPicker)
               
               let height: CGFloat = 200
               let y = window.frame.height - height
               mounthView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
               
               blackView.frame = window.frame
               blackView.alpha = 0
               
               UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                   
                   self.blackView.alpha = 1
                   
                   self.mounthView.frame = CGRect(x: 0, y: y, width: self.mounthView.frame.width, height: self.mounthView.frame.height)
                   
               }, completion: nil)
           }
       }
    
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIWindow.key {
                self.mounthView.frame = CGRect(x: 0, y: window.frame.height, width: self.mounthView.frame.width, height: self.mounthView.frame.height)
            }
        }
    }
    override func setupViews() {
        super.setupViews()
        
        
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
                   return 1
                }
              
                func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
              
                   return mounthArray.count
                }
              
                func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                  gradeTextField.text = mounthArray[row]
                   let row = mounthArray[row]
                   return row
                }
              
              func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
               //    gradeTextField.text = dataArray[row]
                //  G_Res.selectInterval(indexPath: [gradeTextField.tag,row], rayName:rayName)
                  
                 //  self.endEditing(true)
               }
    
    let gradeTextField: UITextField = {
                  let UIPicker = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
              UIPicker.tag = 0
                  //UIPicker.placeholder = "Enter text here"
                  UIPicker.font = UIFont.systemFont(ofSize: 15)
                  UIPicker.borderStyle = UITextField.BorderStyle.roundedRect
                  //UIPicker.isUserInteractionEnabled = false
                  //UIPicker.autocorrectionType = UITextAutocorrectionType.no
                  //UIPicker.keyboardType = UIKeyboardType.default
                  //UIPicker.returnKeyType = UIReturnKeyType.done
                  //UIPicker.clearButtonMode = UITextField.ViewMode.whileEditing
                  UIPicker.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
                  
                  return UIPicker
              
             }()
              
              let UIPicker: UIPickerView = {
                  
                  let UIPicker: UIPickerView = UIPickerView()

                  return UIPicker
                 }()
    
}
class TimeFactor: BaseCell,
UIPickerViewDelegate, UIPickerViewDataSource {
    
  
    var rN: String? {
          didSet {
              
            rayName = rN
              
          }
      }
    
    var rayName : String!
    var commentForInt:String? {
       didSet {
           
           coment.text = commentForInt
           
           }
           
       }
       var coment: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = ""
           label.numberOfLines = 2
           label.textColor = UIColor.black
           return label
       }()
    
    override func setupViews() {
            
            addSubview(coment)
                    
            addConstraintsWithFormat("H:|-25-[v0]-25-|", views: coment)
            addConstraintsWithFormat("V:|-15-[v0]", views: coment)
        
          UIPicker.delegate = self as UIPickerViewDelegate
          UIPicker.dataSource = self as UIPickerViewDataSource
        
          addSubview(gradeTextField)
            
            addConstraintsWithFormat("H:|-25-[v0]-25-|", views: gradeTextField)
            addConstraintsWithFormat("V:|-75-[v0]", views: gradeTextField)
          addSubview(UIPicker)
        
        addConstraintsWithFormat("H:|-25-[v0]-25-|", views: UIPicker)
        addConstraintsWithFormat("V:|-75-[v0]", views: UIPicker)
          gradeTextField.inputView = UIPicker
          gradeTextField.text = dataArray[0]
          setup()
          
      }
    
    let dataArray = ["От 1 с - до 5 мин", "От 5 мин - до 20 мин", "От 20 мин - до 1 ч", "От 1 ч - до 2 ч", "От 2 ч - до 6 ч", "От 6 ч - до 24 ч", "От 1 дня - до 2 дней", "От 2 дней - до 5 дней", "От 5 дней - до 7 дней", "От 1 недели - до 1 месяца", "От 1 месяца - до 6 мес.", "От 6 мес - до 12 мес", "более года"]
    
      func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
      }
    
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
         return dataArray.count
      }
    
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        gradeTextField.text = dataArray[row]
         let row = dataArray[row]
         return row
      }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
     //    gradeTextField.text = dataArray[row]
      //  G_Res.selectInterval(indexPath: [gradeTextField.tag,row], rayName:rayName)
        
         self.endEditing(true)
     }
    
//    var slice: Slices? {
//        didSet {
////            titleLabel.text = rayOfReturn?.productsName
////            platName.text = rayOfReturn?.platName
////            directionOfObservation.text = rayOfReturn?.directionOfObservation
//
//
//        }
//    }
    
   let gradeTextField: UITextField = {
        let UIPicker = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    UIPicker.tag = 0
        //UIPicker.placeholder = "Enter text here"
        UIPicker.font = UIFont.systemFont(ofSize: 15)
        UIPicker.borderStyle = UITextField.BorderStyle.roundedRect
        //UIPicker.isUserInteractionEnabled = false
        //UIPicker.autocorrectionType = UITextAutocorrectionType.no
        //UIPicker.keyboardType = UIKeyboardType.default
        //UIPicker.returnKeyType = UIReturnKeyType.done
        //UIPicker.clearButtonMode = UITextField.ViewMode.whileEditing
        UIPicker.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        return UIPicker
    
   }()
    
    let UIPicker: UIPickerView = {
        
        let UIPicker: UIPickerView = UIPickerView()

        return UIPicker
       }()
    
 
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    func setup(){
        
           let button = UIButton.init(type: .system)
        button.frame = CGRect(x: 50.0, y: 135.0, width: 200.0, height: 52.0)
              button.layer.borderWidth = 5.0
              button.layer.borderColor = UIColor.white.cgColor
              button.backgroundColor = UIColor.green
              button.titleLabel?.textColor = UIColor.black
              button.tintColor = UIColor.white
              button.layer.cornerRadius = 15.0
               button.setTitle("Добавить", for: .normal)
               button.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
            addSubview(button)
        
        //addConstraintsWithFormat("H:|-25-[v0]-25-|", views: button)
        //addConstraintsWithFormat("V:|-130-[v0]", views: button)
       }
    
       @objc func buttonClicked() {

        NotificationCenter.default.post(name: NSNotification.Name("Луч Земли"), object: nil)
       
        
       }
   
    
  
   
   
}


