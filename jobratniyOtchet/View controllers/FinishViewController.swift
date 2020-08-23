//
//  FinishViewController.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 06/06/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    @IBOutlet var congratsLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var willDoButton: UIButton!
    @IBOutlet var toMainButton: UIButton!

    var indexPath: IndexPath!
    var task: Answer!
    private var persentage: Float!
    private var animatedCircle = AnimatedCircle()
    
    let persentageLabel: CountingLabel = {
          let label = CountingLabel()
          label.text = "0%"
          label.textAlignment = .center
          label.font = UIFont.boldSystemFont(ofSize: 32)
          label.textColor =  .white
          return label
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        task = tasksLists[indexPath.row]
        
        guard let countofTask = Int(task.countOfTask) else {return}
        persentage = Float(task.currentNumber) / Float(countofTask)
        
        createConstraints()
        animatedCircle.setText(congratsLabel: congratsLabel, textLabel: textLabel, persentage)
    }
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        animatedCircle.setupNotificationObservers()
        animatedCircle.setupCircleLayers(view)
        animatedCircle.setupPersentageLabel(view, persentageLabel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .nanoseconds(50), execute: {
            self.animatedCircle.beginCountOfPercent(self.persentageLabel, self.persentage)
        })
    }
    
    private func createConstraints() {
        
        willDoButton.translatesAutoresizingMaskIntoConstraints = false
        toMainButton.translatesAutoresizingMaskIntoConstraints = false
           
        willDoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        willDoButton.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 1/10).isActive = true
        willDoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85).isActive = true
        willDoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        toMainButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        toMainButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        toMainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        toMainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
