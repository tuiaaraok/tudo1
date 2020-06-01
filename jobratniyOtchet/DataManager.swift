//
//  DataManager.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 02/05/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import Foundation
import RealmSwift


var overDoValue = 0
var indexP = 0

  var tasksLists: Results<Answer>!

class Answer: Object {
@objc dynamic var task = ""
@objc dynamic var countOfTask = ""
@objc dynamic var overDo = 0
@objc dynamic var currentNumber = 0
}




