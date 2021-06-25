//
//  ViewController.swift
//  Realm_IOS
//
//  Created by somsak on 3/9/2563 BE.
//  Copyright © 2563 professor. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var data: Results<Dog>!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        
        configView()
        displayData()
    }

    func configView(){
        let newData = Dog()
        newData.name = "somsee"
        newData.age = 81
        
        let realm = RealmService.shared.realm
        print("realm", realm)
        
        RealmService.shared.create(newData)
    }
    
    func displayData(){
        
        
        
                let realm = RealmService.shared.realm
                data = realm.objects(Dog.self)
        
        print("self.data", self.data.count)
        self.nameLabel.text = self.data[0].name
        self.ageLabel.text = "\(self.data[0].age)"
    }
    
    @IBAction func changDataAction(_ sender: Any) {
        let dict: [String: Any?] = ["name": "changData",
                                    "age": 50]
        
        print("self.data", self.data[0])
        
        RealmService.shared.update(self.data[0], with: dict)
        displayData()
    }
}

class RealmService {
    private init() {}
    static let shared = RealmService()

    var realm = try! Realm()

    func create<T: Object>(_ object: T){
        do {
            try realm.write {
                realm.add(object)
            }
        }catch {
//            post(error)
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]){
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        }catch {
//            post(error)
        }
    }
    
    func delete<T: Object>(_ object: T){
        do {
            try realm.write {
                realm.delete(object)
            }
        }catch {
//            post(error)
        }
    }
}

class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}


