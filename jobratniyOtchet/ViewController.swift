//
//  ViewController.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 01/05/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import UIKit
import RealmSwift
var glb: Int? = nil
class ViewController: UIViewController {

    
    @IBOutlet var taskTextField: UITextField!
    @IBOutlet var countOfTasksTextField: UITextField!
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var addButtonOut: UIButton!
    @IBOutlet var taskLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    
    var taskText: String!
    var countOfTaskText: String!
    var actionIndex: Int!

    
   override func viewDidLoad() {
         super.viewDidLoad()
         actionIndex = glb
     
         
         if indexP == 0 {
            saveButton.isHidden = true
            countLabel.text = "Напишите количество:"
            taskLabel.text = "Напишите задание:"
             
         } else {
             countLabel.text = "Редактировать количество:"
             taskLabel.text = "Редактировать задание:"
             addButtonOut.isHidden = true
             saveButton.isHidden = false
             taskTextField.text = tasksLists[actionIndex].task
             countOfTasksTextField.text = tasksLists[actionIndex].countOfTask
             indexP = 0
             
         }
     }
   
   
 
    
    @IBAction func addButton() {
        guard Int(countOfTasksTextField.text!) != nil else{showAlert(title: "Ошибка", messge: "напишите число!"); return}
              
             let task = Answer()
              task.countOfTask = countOfTasksTextField.text!
              task.task = taskTextField.text!
              task.currentNumber = 0
              task.overDo = 0
              
              StorageManager.saveTasksList(task)
    }

    @IBAction func save() {
         indexP=0
        StorageManager.editTaskAndCount(
            tasksLists[actionIndex],
            newTask: taskTextField.text!,
            newCount: countOfTasksTextField.text!
        )
    }
  
    

    
}
extension ViewController {
    private func showAlert (title: String, messge: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: messge, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            textField?.text = nil
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
extension ViewController: UITextFieldDelegate {
    // скрытие клавиатуры по тапу в любом месте
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

