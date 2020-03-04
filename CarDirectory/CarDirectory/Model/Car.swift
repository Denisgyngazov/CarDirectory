//
//  Car.swift
//  CarDirectory
//
//  Created by Денис Гынгазов on 03.03.2020.
//  Copyright © 2020 Денис Гынгазов. All rights reserved.
//

import RealmSwift

class Car: Object {
    @objc dynamic var year: String?
    @objc dynamic var manufacturer: String?
    @objc dynamic var model: String?
    @objc dynamic var bodyType: String?
    
    convenience init(manufacturer: String?, model: String?, bodyType: String?, year: String?) {
        self.init()
        self.year = year
        self.manufacturer = manufacturer
        self.model = model
        self.bodyType = bodyType
    }
}




