//
//  EditViewController.swift
//  RAPI
//
//  Created by LA'D on 28.05.2020.
//  Copyright © 2020 Garonum. All rights reserved.
//

import UIKit


class EditViewController: UIViewController {
    var eda:EDAController?
      var fullName: String? {
            didSet {
                fullNameField.text = fullName!
                
            }
        }
    var indexPath: IndexPath?
     var departments: [[String : AnyObject]]?
    var mainController: MainController!
    let fullNameField: UITextField = {
           let sampleTextField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
                    sampleTextField.placeholder = "Full Name"
                    sampleTextField.font = UIFont.systemFont(ofSize: 15)
                    sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
                    sampleTextField.autocorrectionType = UITextAutocorrectionType.no
                    sampleTextField.keyboardType = UIKeyboardType.default
                    sampleTextField.returnKeyType = UIReturnKeyType.done
                    sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
                    sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
                    
          return sampleTextField
      
     }()
    
    var saveButton:UIButton = {
           
              let button = UIButton.init(type: .system)
                  button.frame = CGRect()
                  button.layer.borderWidth = 5.0
                  button.layer.borderColor = UIColor.white.cgColor
                  button.backgroundColor = UIColor(red: 0.2627, green: 0.8275, blue: 0.302, alpha: 1.0)
                  button.titleLabel?.textColor = UIColor.black
                  button.tintColor = UIColor.white
                  button.layer.cornerRadius = 15.0
                  button.setTitle("Сохранить", for: .normal)
                  button.addTarget(self, action:#selector(save), for: .touchUpInside)
              return button
          }()

          @objc func save() {

            var dep = departments?[0]["departments"] as? [[String: AnyObject]]
            var users = dep?[indexPath?.section ?? 0]["users"] as? [[String : AnyObject]]
            users?[indexPath?.row ?? 0]["fullName"] = fullNameField.text as AnyObject
            dep?[indexPath?.section ?? 0]["users"] = users as AnyObject?
            departments?[0]["departments"] = dep as AnyObject
            eda?.reload(dep:departments?[0]["departments"] as! [[String: AnyObject]])
            mainController.reload(dep:departments?[0]["departments"] as! [[String: AnyObject]])
            mainController.deleteButton()
            
            guard let urld = URL(string: "http://localhost:3000/posts") else { return }
                       
                       var urlRequestd = URLRequest(url: urld)
                       urlRequestd.httpMethod = "POST"
            let params  = departments?[0]

                          do {
                            let data = try JSONSerialization.data(withJSONObject: params as Any, options: .init())
                              
                              urlRequestd.httpBody = data
                              urlRequestd.setValue("application/json", forHTTPHeaderField: "content-type")
                                  
                              URLSession.shared.dataTask(with: urlRequestd) { (data, resp, err) in
                                  // check error
                                  
                                  //guard let data = data else { return }
                                  
                                  //completion(nil)
                                  
                                  }.resume() // i always forget this
                          } catch {
                              //completion(error)
                          }

          }

    var deleteButton:UIButton = {
     
        let button = UIButton.init(type: .system)
            button.frame = CGRect()
            button.layer.borderWidth = 5.0
            button.layer.borderColor = UIColor.white.cgColor
            button.backgroundColor = UIColor.red
            button.titleLabel?.textColor = UIColor.black
            button.tintColor = UIColor.white
            button.layer.cornerRadius = 15.0
            button.setTitle("Удалить", for: .normal)
           button.addTarget(self, action:#selector(deleteUser), for: .touchUpInside)
        return button
    }()
    
    @objc func deleteUser() {


         }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Редактирование"
        
        fullNameField.delegate = self
        
        self.view.addSubview(fullNameField)
        self.view.addSubview(saveButton)
        self.view.addSubview(deleteButton)
        
        
        addConstraintsWithFormat("H:[v0(100)]-15-[v1(100)]-25-|", views: saveButton, deleteButton)
        
        addConstraintsWithFormat("V:|-150-[v0(50)]", views: saveButton)
        addConstraintsWithFormat("V:|-150-[v0(50)]", views: deleteButton)
    }
    

    
}
extension EditViewController: UITextFieldDelegate {
//
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        // return NO to disallow editing.
//        print("TextField should begin editing method called")
//        return true
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        // became first responder
//        print("TextField did begin editing method called")
//    }
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
//        print("TextField should snd editing method called")
//        return true
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
//        print("TextField did end editing method called")
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//        // if implemented, called in place of textFieldDidEndEditing:
//        print("TextField did end editing with reason method called")
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // return NO to not change text
//        print("While entering the characters this method gets called")
//        return true
//    }
//
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        // called when clear button pressed. return NO to ignore (no notifications)
//        print("TextField should clear method called")
//        return true
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        // called when 'return' key pressed. return NO to ignore.
//        print("TextField should return method called")
//        // may be useful: textField.resignFirstResponder()
//        return true
//    }

}

