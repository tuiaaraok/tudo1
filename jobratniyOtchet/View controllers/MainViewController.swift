//
//  SpisokTableViewController.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 01/05/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {
    
    var tasksLists: Results<Task>!
    let refreshManager = RefreshManager()
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 52
        tasksLists = realm.objects(Task.self)
        refreshManager.loadDataIfNeeded(tasks: tasksLists, tableView: tableView)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tasks", for: indexPath) as? TableViewCell
        guard let cell = tableViewCell else { return UITableViewCell() }
        let task = tasksLists[indexPath.row]
        cell.configure(indexPath, task: task)
        cell.editButton.addTarget(self, action: #selector(btnaction), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appDelegate?.scheduleNotification(notificationType: "Local notification")
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let currentList = tasksLists[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            StorageManager.deleteList(currentList)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])

        return swipeActions
    }
    
    // MARK: - IBActions

   @IBAction func resetButtonPressed(_ sender: Any) {
       for task in tasksLists {
           StorageManager.editRestart(task)
           tableView.reloadData()
       }
   }
    
    @IBAction func unwindSegue (_ sender: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    @objc func btnaction(sender: UIButton) {
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "second") as? EditViewController
        if let editVC = editVC {
            editVC.currentTask = tasksLists[indexPath.row]
            self.navigationController?.pushViewController(editVC, animated: true)
        }
    }
    
   // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            if segue.identifier == "start2" {
                let currentTask = tasksLists[indexPath.row]
                guard let actionVC = segue.destination as? ActionViewController else { return }
                actionVC.currentTask = currentTask
            }
        }
    }
}

