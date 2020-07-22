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
     
         if actionIndex == nil {
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
         
         }
    
    taskLabel.translatesAutoresizingMaskIntoConstraints = false
    taskTextField.translatesAutoresizingMaskIntoConstraints = false
    countLabel.translatesAutoresizingMaskIntoConstraints = false
    countOfTasksTextField.translatesAutoresizingMaskIntoConstraints = false
    saveButton.translatesAutoresizingMaskIntoConstraints = false
    addButtonOut.translatesAutoresizingMaskIntoConstraints = false
    
    createConstraints()
    
    taskTextField.delegate = self
   
    
     }
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        return updateText.count<35
    }
    
    
    
    
   
    @IBAction func addButton() {
        guard Int(countOfTasksTextField.text!) != nil else{showAlert(title: "Ошибка", messge: "напишите число!"); return}
        guard taskTextField.text?.isEmpty == false  else { showAlert(title: "Ошибка!", messge: "Напишите задание!"); return }
              
             let task = Answer()
              task.countOfTask = countOfTasksTextField.text!
              task.task = taskTextField.text!
              task.currentNumber = 0
              task.overDo = 0
              
              StorageManager.saveTasksList(task)
    }

    @IBAction func save() {
      
        StorageManager.editTaskAndCount(
            tasksLists[actionIndex],
            newTask: taskTextField.text!,
            newCount: countOfTasksTextField.text!
        )
    }
  
    
    
    
    
    
    
    
    // MARK: - Constraints
    
    func createConstraints() {
        
        taskLabel.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 4/5
            ).isActive = true
                 
        taskLabel.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/20
            ).isActive = true
                 
        taskLabel.centerYAnchor.constraint(
            equalTo: view.topAnchor,
            constant: 100
            ).isActive = true
                 
        taskLabel.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true
        
        
        
        taskTextField.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 4/5
            ).isActive = true
                        
        taskTextField.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/20
            ).isActive = true
                        
        taskTextField.centerYAnchor.constraint(
            equalTo: taskLabel.bottomAnchor,
            constant: 35
            ).isActive = true
                        
        taskTextField.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true
                        
                
        
        
        countLabel.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 4/5
            ).isActive = true
                               
        countLabel.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/20
            ).isActive = true
                               
        countLabel.centerYAnchor.constraint(
            equalTo: taskTextField.bottomAnchor,
            constant: 50
            ).isActive = true
                               
        countLabel.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true
        
        
        
        
        countOfTasksTextField.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 4/5
            ).isActive = true
                               
        countOfTasksTextField.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/20
            ).isActive = true
                               
        countOfTasksTextField.centerYAnchor.constraint(
            equalTo: countLabel.bottomAnchor,
            constant: 35
            ).isActive = true
                               
        countOfTasksTextField.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true
                               
        
        
        
        saveButton.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 1/3
            ).isActive = true
                                      
        saveButton.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/20
            ).isActive = true
                                      
        saveButton.centerYAnchor.constraint(
            equalTo: countOfTasksTextField.bottomAnchor,
            constant: 80
            ).isActive = true
                                      
        saveButton.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true
        
        
        
        
        addButtonOut.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 1/3
            ).isActive = true
                                      
        addButtonOut.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/20
            ).isActive = true
                                      
        addButtonOut.centerYAnchor.constraint(
            equalTo: countOfTasksTextField.bottomAnchor,
            constant: 80
            ).isActive = true
                                      
        addButtonOut.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true
        
    }
    
    
    
    // MARK: - Extentions
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.taskTextField {
               textField.resignFirstResponder()
            self.countOfTasksTextField.becomeFirstResponder()
        } 
            //else скрыть клавиатуру
        
           return true
       }
}

