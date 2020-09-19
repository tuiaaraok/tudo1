//
//  Task.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 19/09/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import Foundation
import RealmSwift

var overDoValue =  0

class Task: Object {
    
    @objc  dynamic  var task =  " "
    @objc  dynamic  var countOfTask =  " "
    @objc  dynamic  var overDo =  0
    @objc  dynamic  var currentNumber =  0
}
