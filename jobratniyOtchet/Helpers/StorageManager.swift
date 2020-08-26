//
//  StorageManager.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 01/06/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveTasksList ( _ tasksLists: Task ) {
        try! realm.write {
            realm.add(tasksLists)
        }
    }
    
    static func editRestart( _ tasksList: Task) {
        try! realm.write {
            tasksList.currentNumber = 0
        }
    }
    
    static func deleteList(_ tasksList: Task) {
           
           try! realm.write {
               realm.delete(tasksList)
           }
       }
}
