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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         congratsLabel.translatesAutoresizingMaskIntoConstraints = false
         textLabel.translatesAutoresizingMaskIntoConstraints = false
         willDoButton.translatesAutoresizingMaskIntoConstraints = false
         toMainButton.translatesAutoresizingMaskIntoConstraints = false

       createConstraints()
    }
    
    
       func createConstraints() {
           
        congratsLabel.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 4/5
            ).isActive = true
                    
        congratsLabel.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/10
            ).isActive = true
                    
        congratsLabel.centerYAnchor.constraint(
            equalTo: view.topAnchor,
            constant: 200
            ).isActive = true
                    
        congratsLabel.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true
   
        
        
        
        textLabel.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 4/5
            ).isActive = true
                           
        textLabel.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/10
            ).isActive = true
                           
        textLabel.centerYAnchor.constraint(
            equalTo: congratsLabel.bottomAnchor,
            constant: 50
            ).isActive = true
                           
        textLabel.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true
        
        
        
        
        willDoButton.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 4/5
            ).isActive = true
                           
        willDoButton.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/10
            ).isActive = true
                           
        willDoButton.centerYAnchor.constraint(
            equalTo: textLabel.bottomAnchor,
            constant: 100
            ).isActive = true
                           
        willDoButton.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true
        
        
        
        
        toMainButton.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 4/5
            ).isActive = true
                                  
        toMainButton.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 1/10
            ).isActive = true
                                  
        toMainButton.centerYAnchor.constraint(
            equalTo: willDoButton.bottomAnchor,
            constant: 20
            ).isActive = true
                                  
        toMainButton.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
            ).isActive = true
}
}
