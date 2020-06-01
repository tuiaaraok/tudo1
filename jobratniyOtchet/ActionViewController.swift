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
        doneButton.layer.cornerRadius = doneButton.frame.width / 35
        taskLabel.text = task
       
        finishButton.isHidden = true
        actionNumber = number
        numberLabel.text = String(actionNumber)
      
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
        
    }
    
    
 
    
    @IBAction func pressFinish() {
        performSegue(withIdentifier: "finish", sender: nil)
        currentNum = Int(tasksLists[actionIndex].countOfTask)! + overDoValue
        StorageManager.editList(tasksLists[actionIndex], newCurrentNum: currentNum, newOverDo: overDoValue)
    }
}
