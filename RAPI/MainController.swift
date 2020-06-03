//
//  MainController.swift
//  RAPI
//
//  Created by LA'D on 15.05.2020.
//  Copyright © 2020 Garonum. All rights reserved.
//
import UIKit
struct Dep: Codable {
    var name:String
}
class MainController: UIViewController, UICollectionViewDataSource{
 
        
    let sectionInsets = UIEdgeInsets(top: 25.0, left: 20.0, bottom: 5.0, right: 20.0)
    //var departments: [Department]?
    var departments: [[String: AnyObject]] = []
    var main: [[String: AnyObject]] = []
    var titlesDepartments: [String] = []
    var collectionView: UICollectionView!
    var mainController: MainController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //post()
        fetchData()
        
        
        view.backgroundColor = UIColor.blue//.withAlphaComponent(0.9)
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        self.navigationItem.rightBarButtonItem  = moreButton
        self.navigationItem.title = "Департаменты"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        setupCollectionView()
        //setup()
        //setupMoreButton()
        
    }
    
    func setupCollectionView() {
        mainController = self
          let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
            layout.itemSize = CGSize(width: self.view.frame.width-20, height: 70)
        collectionView = UICollectionView(frame:CGRect(x: 0, y: 74, width: self.view.frame.width, height: self.view.frame.height-70), collectionViewLayout: layout)
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
                    flowLayout.scrollDirection = .horizontal
                    flowLayout.minimumLineSpacing = 0
                }
        
    
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(DepartmentsCell.self, forCellWithReuseIdentifier: "CellID")
            
            collectionView.showsVerticalScrollIndicator = false
            collectionView.backgroundColor = UIColor.white.withAlphaComponent(0.8)

            collectionView?.isScrollEnabled = false
        
            collectionView?.isPagingEnabled = true
        
            self.view.addSubview(collectionView)
        
      }
    
    lazy var settingsLauncher: SettingsLauncher = {
             let launcher = SettingsLauncher()
             launcher.mainController = self
             return launcher
         }()
       //let settingsLauncher = SettingsLauncher()
       @objc func handleMore() {
           settingsLauncher.showSettings()
       }
  
      
    func fetchData() {
         departments = []
         titlesDepartments = []
          guard let url = URL(string: "http://localhost:3000/posts") else { return }
          URLSession.shared.dataTask(with: url) { (data, response, error) in
              
              if error != nil {
                  print(error ?? "")
                  return
              }
              
              do {
                  let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                self.main = json as! [[String: AnyObject]]
                
                for deparments in json as! [[String: AnyObject]]{
                    self.departments = deparments["departments"] as! [[String: AnyObject]] 
                    //let x = self.departments[0]["users"] as? [[String : AnyObject]]
                    for deparment in deparments["departments"] as! [[String: AnyObject]]{
                        self.titlesDepartments.append(deparment["title"] as! String )
                        
                    }
                }
                
                
               //   self.departments = [Department]()
                
//                for dictionary in json as! [[String: AnyObject]]{
//                    for d in dictionary["departments"] as! [String: AnyObject]{
//                        print(d.key)
//                        for u in d.value as! [String: AnyObject]{
//                            for n in u.value as! [String: AnyObject]{
//
//                            }
//                        }
//                    }
//                }
//
//
//                    }
//                      let department = Department()
                      //department.title = dictionary //as? String
                      //department.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                      
    //                  let channelDictionary = dictionary["channel"] as! [String: AnyObject]
    //
    //                  let channel = Channel()
    //                  channel.name = channelDictionary["name"] as? String
    //                  channel.profileImageName = channelDictionary["profile_image_name"] as? String
    //
    //                  department.channel = channel
                      
                      //self.departments?.append(department)
                  
                  
                  DispatchQueue.main.async {
                      self.collectionView?.reloadData()
                    
                  }
                  
                  
              } catch let jsonError {
                  print(jsonError)
              }
              
              
              
          }.resume()
        
      }
     func reload(dep:[[String : AnyObject]]){

        self.departments = dep
        self.collectionView.reloadData()
        
        }
    
    func showControllerForSetting(setting: Setting) {
        
        if setting.name == "Администратор справочника работников"{
            let edAdmin = EDAController(collectionViewLayout: UICollectionViewFlowLayout())
            edAdmin.users = self.departments as [[String : AnyObject]]
            edAdmin.titles = self.titlesDepartments
            edAdmin.departments = self.main
            edAdmin.mainController = mainController
                self.show(edAdmin, sender: self)
        } else{
            let dummySettingsViewController = UIViewController()
                 dummySettingsViewController.view.backgroundColor = UIColor.white
                 dummySettingsViewController.navigationItem.title = setting.name
                 navigationController?.navigationBar.tintColor = UIColor.white
                 navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                 navigationController?.pushViewController(dummySettingsViewController, animated: true)
        }
         
        //self.show(dummySettingsViewController, sender: self)
      }
 
   
   
}
extension MainController: UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titlesDepartments.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath) as! DepartmentsCell
        //let department = self.departments?[indexPath.item]["departments"] as! [String: AnyObject]
        
        cell.departmentName = self.titlesDepartments[indexPath.item]
        cell.backgroundColor = UIColor(red: 0.6667, green: 0.702, blue: 1, alpha: 1.0)
          return cell
      }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let schedule = Schedule(collectionViewLayout: UICollectionViewFlowLayout())
        //let department = self.departments[indexPath.item]

        schedule.users = self.departments[indexPath.item]["users"] as? [[String : AnyObject]]
        //schedule.date = indexPath.row
        //schedule.showSettings()
        self.show(schedule, sender: self)
    }
//    func collectionView(_ collectionView: UICollectionView,
//                         layout collectionViewLayout: UICollectionViewLayout,
//                         insetForSectionAt section: Int) -> UIEdgeInsets {
//       return sectionInsets
//     }
//
//     func collectionView(_ collectionView: UICollectionView,
//                         layout collectionViewLayout: UICollectionViewLayout,
//                         minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//       return sectionInsets.left
//     }
//
//func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//       let height = (view.frame.width - 16 - 16) * 9 / 16
//       return CGSize(width: 300, height:7)
//   }
   
}

extension MainController{
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
            view.addSubview(button)
            
            let button1 = UIButton.init(type: .system)
                       button1.frame = CGRect(x: 50.0, y: 275.0, width: 200.0, height: 52.0)
                             button1.layer.borderWidth = 5.0
                             button1.layer.borderColor = UIColor.white.cgColor
                             button1.backgroundColor = UIColor.green
                             button1.titleLabel?.textColor = UIColor.black
                             button1.tintColor = UIColor.white
                             button1.layer.cornerRadius = 15.0
                              button1.setTitle("Показать", for: .normal)
                              button1.addTarget(self, action:#selector(buttonShow), for: .touchUpInside)
                   view.addSubview(button1)
                
                //addConstraintsWithFormat("H:|-25-[v0]-25-|", views: button)
                //addConstraintsWithFormat("V:|-130-[v0]", views: button)
            let button2 = UIButton.init(type: .system)
                            button2.frame = CGRect(x: 50.0, y: 375.0, width: 200.0, height: 52.0)
                                  button2.layer.borderWidth = 5.0
                                  button2.layer.borderColor = UIColor.white.cgColor
                                  button2.backgroundColor = UIColor.green
                                  button2.titleLabel?.textColor = UIColor.black
                                  button2.tintColor = UIColor.white
                                  button2.layer.cornerRadius = 15.0
                                   button2.setTitle("Удалить", for: .normal)
                                   button2.addTarget(self, action:#selector(deleteButton), for: .touchUpInside)
                        view.addSubview(button2)
                     
                     //addConstraintsWithFormat("H:|-25-[v0]-25-|", views: button)
                     //addConstraintsWithFormat("V:|-130-[v0]", views: button)
                    
               }

        @objc func post(){
            guard let url = URL(string: "http://localhost:3000/posts") else { return }
                  
                  var urlRequest = URLRequest(url: url)
                  urlRequest.httpMethod = "POST"
                  
//            let params:[String: Any] = ["departments": [ "Департамент №1":["users":[
//                                      "Kavin Bakon": [
//                                              "shedule":[
//                                                      "month":[
//                                                          "Январь":[
//                                                              "1": "Я"
//                                                           ]
//                                                      ]
//                                                  ]
//                                       ]
//                                  ]
//                       ]]]
            
            //let params2:[String: Any] = ["departments": [ "Департамент №1":["0":"0"],"Департамент №2":["1":"1"]]]
//            let params:Dep = Dep(name: "bj")
            
            let params : [String : Any] = [
                "departments":[["title":"Департамент №1",
                                "users":[["fullName":"Oneel Blake","schedule":["Январь":["1":"Я"]]]]],
                               ["title":"Департамент №2",
                                "users":[["fullName":"Oneel Blake","schedule":["Январь":["1":"Я"]]]]]
                ]
            ]
                  do {
                      let data = try JSONSerialization.data(withJSONObject: params, options: .init())
                      
                      urlRequest.httpBody = data
                      urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
                          
                      URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
                          // check error
                          
                          //guard let data = data else { return }
                          
                          //completion(nil)
                          
                          }.resume() // i always forget this
                  } catch {
                      //completion(error)
                  }
        }
               @objc func buttonClicked() {
                    let url = URL(string: "http://localhost:3000/posts")!
                    
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                  // prepare json data
                     let json: [String: Any] = ["title": "ABC",
                                                "dict": ["1":"First", "2":"Second"]]

                     let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .init())

                    request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "content-type")
                     

                     let task = URLSession.shared.dataTask(with: request) { data, response, error in
                         guard let data = data, error == nil else {
                             print(error?.localizedDescription ?? "No data")
                             return
                         }
                         let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                         if let responseJSON = responseJSON as? [String: Any] {
                             print(responseJSON)
                         }
                     }

                     task.resume()
               
                
               }
        @objc func buttonShow() {

          guard let url = URL(string: "http://localhost:3000/posts") else { return }
                  URLSession.shared.dataTask(with: url) { (data, response, error) in
                      
                      if error != nil {
                          print(error ?? "")
                          return
                      }
                      
                      do {
                          let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                          
                          //self.videos = [Video]()
                          
                          for dictionary in json as! [[String: AnyObject]] {
                              print(dictionary)
    //                          let video = Video()
    //                          video.title = dictionary["title"] as? String
    //                          video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                              
                              //let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                              
    //                          let channel = Channel()
    //                          channel.name = channelDictionary["name"] as? String
    //                          channel.profileImageName = channelDictionary["profile_image_name"] as? String
    //
    //                          video.channel = channel
    //
    //                          self.videos?.append(video)
                          }
                          
                          DispatchQueue.main.async {
                             // self.collectionView?.reloadData()
                          }
                          
                          
                      } catch let jsonError {
                          print(jsonError)
                      }
                      
                      
                      
                  }.resume()
        
         
        }
        @objc func deleteButton(){
            let id = 1
            guard let url = URL(string: "http://localhost:3000/posts/\(id)") else { return }
                 
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
        }
        
        
    //    func setupMoreButton() {
    //
    //
    //       }
       
        
     
}

