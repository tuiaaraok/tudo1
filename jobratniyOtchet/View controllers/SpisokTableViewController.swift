//
//  SpisokTableViewController.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 01/05/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import UIKit

class SpisokTableViewController: UITableViewController {
    
    let date = Date()
    let calendar = Calendar.current
    let appDelegate = UIApplication.shared.delegate as? AppDelegate // создаем делегат для выполнения уведомлений
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 52
        tasksLists = realm.objects(Answer.self)
        getCurrentDay()
    }
    
    @IBAction func unwindSegue (_ sender: UIStoryboardSegue) {
        tableView.reloadData()
         }
   
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "tasks", for: indexPath) as! TableViewCell
      
        cell.backgroundColor = #colorLiteral(red: 0.4690965603, green: 0.4316392344, blue: 0.8572700777, alpha: 1)
       
        let cellText = tasksLists[indexPath.row]
        cell.mainLabel.text = cellText.task
        cell.numberLabel.text = " \(cellText.currentNumber)/\(cellText.countOfTask)"
             
        overDoValue = 0
              
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(btnaction), for: .touchUpInside)
               
            return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        appDelegate?.scheduleNotification(notificationType: "Local notification")
    }

 // это для перехода на редактирование
    @objc func btnaction(sender: UIButton) {
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let next:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "second") as! ViewController
        next.actionIndex = indexPath.row

        self.navigationController?.pushViewController(next, animated: true)
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

   // сброс количества
   @IBAction func restartButtonPressed(_ sender: Any) {
       for task in tasksLists {
           StorageManager.editRestart(task)
           tableView.reloadData()
       }
   }
    
    private func getCurrentDay () {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, dd, yyyy"
        let str = formatter.string(from: Date())
        print(str)
    }
    
   // MARK: - Navigation

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if let indexPath = tableView.indexPathForSelectedRow {
        if segue.identifier == "start2" {
            let currentTask = tasksLists[indexPath.row]
            let actionVC = segue.destination as! ActionViewController
            actionVC.currentTask = currentTask
            actionVC.indexPath = indexPath
                }
           }
       }
    }

