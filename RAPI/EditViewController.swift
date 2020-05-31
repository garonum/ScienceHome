//
//  EditViewController.swift
//  RAPI
//
//  Created by LA'D on 28.05.2020.
//  Copyright © 2020 Garonum. All rights reserved.
//

import UIKit


class EditViewController: UIViewController {
    
      var fullName: String? {
            didSet {
                fullNameField.text = fullName!
                
            }
        }
     var departments: [[String : AnyObject]]?
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
    func setupButton(){
           
              let button = UIButton.init(type: .system)
                  button.frame = CGRect(x: 50.0, y: 135.0, width: 200.0, height: 52.0)
                  button.layer.borderWidth = 5.0
                  button.layer.borderColor = UIColor.white.cgColor
                  button.backgroundColor = UIColor.green
                  button.titleLabel?.textColor = UIColor.black
                  button.tintColor = UIColor.white
                  button.layer.cornerRadius = 15.0
                  button.setTitle("Сохранить", for: .normal)
                  button.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
              self.view.addSubview(button)
        let button1 = UIButton.init(type: .system)
            button1.frame = CGRect(x: 50.0, y: 195.0, width: 200.0, height: 52.0)
            button1.layer.borderWidth = 5.0
            button1.layer.borderColor = UIColor.white.cgColor
            button1.backgroundColor = UIColor.green
            button1.titleLabel?.textColor = UIColor.black
            button1.tintColor = UIColor.white
            button1.layer.cornerRadius = 15.0
            button1.setTitle("Clear", for: .normal)
            button1.addTarget(self, action:#selector(buttonClicked1), for: .touchUpInside)
        self.view.addSubview(button)
           
           //addConstraintsWithFormat("H:|-25-[v0]-25-|", views: button)
           //addConstraintsWithFormat("V:|-130-[v0]", views: button)
          }
    @objc func buttonClicked1() {
       
                   
                   
    }
          @objc func buttonClicked() {

            var dep = departments?[0]["departments"] as! [[String: AnyObject]]
            var users = dep[0]["users"] as? [[String : AnyObject]]
            users?[0]["fullName"] = "Benjamin Franklin" as AnyObject
            dep[0]["users"] = users as AnyObject?
            departments?[0]["departments"] = dep as AnyObject

                                       guard let url = URL(string: "http://localhost:3000/posts/1") else { return }

                                            var urlRequest = URLRequest(url: url)
                                            urlRequest.httpMethod = "DELETE"
                                            URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
                                                DispatchQueue.main.async {
                                                    if let err = err {
                                                        print(err)
                                                        return
                                                    }

                                                    if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                                                        let errorString = String(data: data ?? Data(), encoding: .utf8) ?? ""
                                                       print(errorString)
                                                        return
                                                    }

                                                    print(err ?? "")

                                                }
                                                // check error

                                                }.resume() // i always forget this
            
            
            
            
            
            
            guard let urld = URL(string: "http://localhost:3000/posts") else { return }
                       
                       var urlRequestd = URLRequest(url: urld)
                       urlRequestd.httpMethod = "POST"
            let params  = departments?[0]
//                [
//                        "departments":[["title":"Департамент №1",
//                                        "users":[["fullName":"Oneel Blake","schedule":["Январь":["1":"Я"]]]]],
//                                       ["title":"Департамент №2",
//                                        "users":[["fullName":"Oneel Blake","schedule":["Январь":["1":"Я"]]]]]
//                        ]
//                    ]
           // departments?[0]["users"] = users as AnyObject?
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


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Редактирование"
        
            fullNameField.delegate = self
           self.view.addSubview(fullNameField)
        setupButton()
    }
    

    
}
extension EditViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
        return true
    }

}
