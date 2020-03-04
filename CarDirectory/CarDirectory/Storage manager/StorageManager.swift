//
//  StorageManager.swift
//  CarDirectory
//
//  Created by Денис Гынгазов on 04.03.2020.
//  Copyright © 2020 Денис Гынгазов. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ car: Car) {
        try! realm.write {
            realm.add(car)
        } 
    }
    
    static func deleteObject(_ car: Car) {
        try! realm.write{
            realm.delete(car)
        }
    }
}


