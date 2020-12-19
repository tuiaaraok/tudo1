//
//  ActionViewController.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 01/05/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController {
    
    @IBOutlet var taskLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    
    @IBOutlet var ostalosLabel: UILabel!
    @IBOutlet var pauseButton: UIButton!
    @IBOutlet var finishButton: UIButton!

    var currentTask: Task!
    var currentNum: Int!
    var actionNumber: Int!
    var actionPause = 0
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        guard let stringCountOfTask = currentTask?.countOfTask else { return }
        guard let countOfTask = Int(stringCountOfTask) else { return }
        if countOfTask - currentTask.currentNumber < 0 {
            actionNumber = 0
        } else {
            actionNumber = countOfTask - currentTask.currentNumber
        }
        currentNum = currentTask.currentNumber

        doneButton.layer.cornerRadius = doneButton.frame.width / 35
        finishButton.isHidden = true
        
        taskLabel.text = currentTask.task
        numberLabel.text = String(actionNumber)
     
        createConstraints()
    }
    
    @IBAction func pressButton() {
        
        actionNumber-=1
        numberLabel.text = String(actionNumber)
        actionPause += 1
        
        if actionNumber == 0 {
           try! realm.write {
                guard let countOfTask = Int(currentTask.countOfTask) else { return }
                currentTask.currentNumber = countOfTask
                currentTask.overDo = 0
            }
         performSegue(withIdentifier: "finish", sender: nil)
        }
        
        if actionNumber < 0 {
            let chetNum = actionNumber*(-1)
            numberLabel.text = String(chetNum)
            numberLabel.textColor = .cyan
            overDoValue+=1
        }
    }
    
    @IBAction func pause() {
       
        currentNum += actionPause
        actionPause = 0
        try! realm.write {
            currentTask.currentNumber = currentNum
            currentTask.overDo = 0
        }
         performSegue(withIdentifier: "finish", sender: nil)
    }
    
    @IBAction func pressFinish() {
        guard let countOfTask = Int(currentTask.countOfTask) else { return }
        currentNum = countOfTask + overDoValue
        try! realm.write {
            currentTask.currentNumber = currentNum
            currentTask.overDo = overDoValue
        }
        performSegue(withIdentifier: "finish", sender: nil)
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindSegue1 (_ sender: UIStoryboardSegue) {
         
         finishButton.isHidden = true
         pauseButton.isHidden = false
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "finish" else { return }
        guard let finishVC = segue.destination as? FinishViewController else { return }
        finishVC.currentTask = currentTask
    }
    
    // MARK: - Constraints
    
    private func createConstraints() {
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        let currentHeight = self.view.frame.size.height

        if currentHeight > 736 {
          doneButton.centerYAnchor.constraint(equalTo: numberLabel.bottomAnchor,
                                              constant: 100).isActive = true
        } else {
          doneButton.centerYAnchor.constraint(equalTo: numberLabel.bottomAnchor,
                                              constant: 60).isActive = true
        }
        
        doneButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 37).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           
        pauseButton.widthAnchor.constraint(equalTo: view.widthAnchor,
                                           multiplier: 3/5).isActive = true
        pauseButton.heightAnchor.constraint(equalTo: view.heightAnchor,
                                            multiplier: 1/15).isActive = true
        pauseButton.centerYAnchor.constraint(equalTo: doneButton.bottomAnchor,
                                             constant: 50).isActive = true
        pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
