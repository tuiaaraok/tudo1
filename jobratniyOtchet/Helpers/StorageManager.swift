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
    
    static func saveTasksList ( _ tasksLists: Answer ) {
        try! realm.write {
            realm.add(tasksLists)
        }
    }
    
    static func editList(_ tasksList: Answer, newCurrentNum: Int, newOverDo: Int ) {
        try! realm.write {
            tasksList.currentNumber = newCurrentNum
        }
    }
    
    static func editTaskAndCount(_ taskList: Answer, newTask: String, newCount: String) {
        try! realm.write{
            taskList.task = newTask
            taskList.countOfTask = newCount
        }
    }
    
    static func editRestart( _ tasksList: Answer) {
        try! realm.write {
            tasksList.currentNumber = 0
        }
    }
    
    static func deleteList(_ tasksList: Answer) {
           
           try! realm.write {
               realm.delete(tasksList)
           }
       }
}
