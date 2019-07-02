//
//  AppDelegate.swift
//  Todo
//
//  Created by Ahmed on 6/24/19.
//  Copyright © 2019 Ahmed sobhi. All rights reserved.
//

import UIKit

import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        do {
            _ = try Realm()

        } catch {
            print("error intialising new realm, \(error)")
        }
        
        return true
    }



}

