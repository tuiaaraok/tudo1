//
//  ViewController.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 01/05/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController {

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
        setupScreen()
        taskTextField.delegate = self
    }
   
    @IBAction func addButton() {

        guard Int(countOfTasksTextField.text!) != nil else {
            showAlert(title: "Ошибка", messge: "напишите число!"); return}
        
        guard taskTextField.text?.isEmpty == false  else {
            showAlert(title: "Ошибка!", messge: "Напишите задание!"); return }
              
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
    
    private func setupScreen() {
        
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
    }
}

// MARK: - Extentions

extension EditViewController {
    
    private func showAlert (title: String, messge: String, textField: UITextField? = nil) {
        
        let alert = UIAlertController(title: title, message: messge, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            textField?.text = nil
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension EditViewController: UITextFieldDelegate {
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.taskTextField {
               textField.resignFirstResponder()
            self.countOfTasksTextField.becomeFirstResponder()
        }
           return true
       }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        return updateText.count<35
    }
}
