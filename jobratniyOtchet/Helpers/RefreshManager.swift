//
//  RefreshManager.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 19/09/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import UIKit
import RealmSwift

class RefreshManager: NSObject {

    static let shared = RefreshManager()
    private let defaults = UserDefaults.standard
    private let defaultsKey = "lastRefresh"
    private let calender = Calendar.current

    func loadDataIfNeeded(tasks: Results<Task>, tableView: UITableView) {

        if isRefreshRequired() {
  
            defaults.set(Date(), forKey: defaultsKey)
            for task in tasks {
                StorageManager.editRestart(task)
            }
            tableView.reloadData()
        }
    }

    private func isRefreshRequired() -> Bool {

        guard let lastRefreshDate = defaults.object(forKey: defaultsKey) as? Date else {
            return true
        }

        if let diff = calender.dateComponents([.day], from: lastRefreshDate, to: Date()).day, diff > 1 {
            return true
        } else {
            return false
        }
    }
}

