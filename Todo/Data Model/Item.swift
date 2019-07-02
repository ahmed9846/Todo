//
//  Item.swift
//  Todo
//
//  Created by Ahmed on 7/1/19.
//  Copyright © 2019 Ahmed sobhi. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
     @objc dynamic var dateCreated: Date?
    
    
   var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
