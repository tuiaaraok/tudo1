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

    
    var task: String!
    var number: Int!
    var currentNum: Int!
    var actionNumber: Int!
   
    var actionIndex: Int!
    var actionPause = 0
    

    override func viewDidLoad() {
         super.viewDidLoad()
        
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        ostalosLabel.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        finishButton.translatesAutoresizingMaskIntoConstraints = false
       
        doneButton.layer.cornerRadius = doneButton.frame.width / 35
        finishButton.isHidden = true
        
        taskLabel.text = task
        actionNumber = number
        numberLabel.text = String(actionNumber)
     
        createConstraints()
       
    }
    

    
      @IBAction func unwindSegue1 (_ sender: UIStoryboardSegue) {
        finishButton.isHidden = false
        pauseButton.isHidden = true
    }
    
    @IBAction func pressButton() {
        
        actionNumber-=1
        numberLabel.text = String(actionNumber)
        actionPause += 1
        
        if actionNumber == 0 {
            StorageManager.editList(tasksLists[actionIndex], newCurrentNum: Int(tasksLists[actionIndex].countOfTask)!, newOverDo: 0)
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
        StorageManager.editList(tasksLists[actionIndex], newCurrentNum: currentNum, newOverDo: 0)
            //dismiss(animated: true, completion: nil)
        
    }
    

    
    @IBAction func pressFinish() {
        performSegue(withIdentifier: "finish", sender: nil)
        currentNum = Int(tasksLists[actionIndex].countOfTask)! + overDoValue
        StorageManager.editList(tasksLists[actionIndex], newCurrentNum: currentNum, newOverDo: overDoValue)
    }
    
    
    
    func createConstraints() {
          
           numberLabel.widthAnchor.constraint(
               equalTo: view.widthAnchor,
               multiplier: 1/2
           ).isActive = true
           
           numberLabel.heightAnchor.constraint(
               equalTo: view.heightAnchor,
               multiplier: 1/4
           ).isActive = true
           
           numberLabel.centerYAnchor.constraint(
               equalTo: view.centerYAnchor,
               constant: 30
           ).isActive = true
           
           numberLabel.centerXAnchor.constraint(
               equalTo: view.centerXAnchor
           ).isActive = true
           
           
           
       
           ostalosLabel.widthAnchor.constraint(
               equalTo: view.widthAnchor,
               multiplier: 1/2
           ).isActive = true
           
           ostalosLabel.heightAnchor.constraint(
               equalTo: view.heightAnchor,
               multiplier: 1/10
           ).isActive = true
           
           ostalosLabel.centerYAnchor.constraint(
               equalTo: numberLabel.topAnchor,
               constant: -50
           ).isActive = true
           
           ostalosLabel.centerXAnchor.constraint(
               equalTo: view.centerXAnchor
           ).isActive = true
           
           
           
           
           taskLabel.widthAnchor.constraint(
               equalTo: view.widthAnchor,
               multiplier: 1
           ).isActive = true
           
           taskLabel.heightAnchor.constraint(
               equalTo: view.heightAnchor,
               multiplier: 1/2
           ).isActive = true
           taskLabel.centerYAnchor.constraint(
               equalTo: ostalosLabel.topAnchor,
               constant:  -55
           ).isActive = true
           taskLabel.centerXAnchor.constraint(
               equalTo: view.centerXAnchor
           ).isActive = true
           
           

           
           doneButton.widthAnchor.constraint(
               equalTo: view.widthAnchor,
               multiplier: 4/7
           ).isActive = true
           
           doneButton.heightAnchor.constraint(
               equalTo: view.heightAnchor,
               multiplier: 1/15
           ).isActive = true
           
           doneButton.centerYAnchor.constraint(
               equalTo: numberLabel.bottomAnchor,
               constant: 60
           ).isActive = true
           doneButton.centerXAnchor.constraint(
               equalTo: view.centerXAnchor
           ).isActive = true
           
           
           
           
           pauseButton.widthAnchor.constraint(
               equalTo: view.widthAnchor,
               multiplier: 3/5
           ).isActive = true
           
           pauseButton.heightAnchor.constraint(
               equalTo: view.heightAnchor,
               multiplier: 1/15
           ).isActive = true
           pauseButton.centerYAnchor.constraint(
               equalTo: doneButton.bottomAnchor,
               constant: 50
           ).isActive = true
           pauseButton.centerXAnchor.constraint(
               equalTo: view.centerXAnchor
           ).isActive = true
           
           
           
           
           finishButton.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 3/5
           ).isActive = true
           finishButton.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/15
           ).isActive = true
           finishButton.centerYAnchor.constraint(
            equalTo: doneButton.bottomAnchor,
            constant: 50
           ).isActive = true
           finishButton.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
           ).isActive = true
    }
  
}
