//
//  SpisokTableViewController.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 01/05/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import UIKit


class SpisokTableViewController: UITableViewController {
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 52
        tasksLists = realm.objects(Answer.self)
        
    }
    
    
    // MARK: - Table view data source

   
   // сэгвэй назад
    @IBAction func unwindSegue (_ sender: UIStoryboardSegue) {
    tableView.reloadData()
         }
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasksLists.count
        
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "tasks", for: indexPath) as! TableViewCell
      
        
        cell.backgroundColor = #colorLiteral(red: 0.4690965603, green: 0.4316392344, blue: 0.8572700777, alpha: 1)
       
        let cellText = tasksLists[indexPath.row]
        cell.mainLabel.text = cellText.task
        cell.numberLabel.text = " \(cellText.currentNumber)/\(Int(cellText.countOfTask)!)"
             
        overDoValue = 0
              
        cell.startButton.tag = indexPath.row
        cell.startButton.addTarget(self, action: #selector(btnaction), for: .touchUpInside)
               
            return cell
        
    }
    


 // это для перехода на редактирование
    @objc func btnaction(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let next:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "second") as! ViewController
        
        glb = indexPath.row
        indexP = 1

        self.navigationController?.pushViewController(next, animated: true)
      
    }
    
    

    // delete func
    
 override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
     
     let currentList = tasksLists[indexPath.row]
     
     let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { _, _ in StorageManager.deleteList(currentList)
         tableView.deleteRows(at: [indexPath], with: .automatic)
     }
     
     return [deleteAction]
 }
    


   // сброс количества на след день
   @IBAction func restartButtonPressed(_ sender: Any) {
       for i in tasksLists {
           StorageManager.editRestart(i)
           tableView.reloadData()
       }
   }
   


   
   // MARK: - Navigation

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let indexPath = tableView.indexPathForSelectedRow {
        if segue.identifier == "start2" {
            let cellText = tasksLists[indexPath.row]
            let actionVC = segue.destination as! ActionViewController
            actionVC.task = cellText.task
            
            if Int(cellText.countOfTask)! - cellText.currentNumber < 0 {
                actionVC.number = 0
            } else {
                actionVC.number = Int(cellText.countOfTask)! - cellText.currentNumber
            }
            
            actionVC.currentNum = cellText.currentNumber
            actionVC.actionIndex = indexPath.row
                }
           }
   
       }
   
    }
        
    
    
  
