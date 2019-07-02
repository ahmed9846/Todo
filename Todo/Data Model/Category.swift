//
//  Category.swift
//  Todo
//
//  Created by Ahmed on 7/1/19.
//  Copyright © 2019 Ahmed sobhi. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
   @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
