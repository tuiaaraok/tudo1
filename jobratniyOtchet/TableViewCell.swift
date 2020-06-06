//
//  TableViewCell.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 17/05/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var strelkaImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        strelkaImageView.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        createConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createConstraints() {
        
        
        strelkaImageView.widthAnchor.constraint(
        equalTo: contentView.widthAnchor,
        multiplier: 2/3
        ).isActive = true
                    
        strelkaImageView.heightAnchor.constraint(
        equalTo: contentView.heightAnchor,
        multiplier: 2/3
        ).isActive = true
                    
        strelkaImageView.centerYAnchor.constraint(
        equalTo: contentView.centerYAnchor
        ).isActive = true
                    
         strelkaImageView.centerXAnchor.constraint(
        equalTo: contentView.leftAnchor,
        constant: 27
            
        ).isActive = true
        
        
        
        
           
        mainLabel.widthAnchor.constraint(
            equalTo: contentView.widthAnchor,
        multiplier: 4/7
        ).isActive = true
                    
        mainLabel.heightAnchor.constraint(
        equalTo: contentView.heightAnchor
        ).isActive = true
                    
        mainLabel.centerYAnchor.constraint(
        equalTo: contentView.centerYAnchor
        ).isActive = true
                    
        mainLabel.centerXAnchor.constraint(
            equalTo: strelkaImageView.rightAnchor,
            constant: 5
        ).isActive = true
        
        
        
        
        numberLabel.widthAnchor.constraint(
            equalTo: contentView.widthAnchor,
        multiplier: 4/30
        ).isActive = true
                    
        numberLabel.heightAnchor.constraint(
        equalTo: contentView.heightAnchor,
        multiplier: 4/5
        ).isActive = true
                    
        numberLabel.centerYAnchor.constraint(
        equalTo: contentView.centerYAnchor
        ).isActive = true
                    
        numberLabel.centerXAnchor.constraint(
        equalTo: mainLabel.rightAnchor,
        constant: 20
        ).isActive = true
        
//        numberLabel.rightAnchor.constraint(
//        equalTo: editButton.leftAnchor,
//        constant: 4
//        ).isActive = true
        
        
        
        
        
        editButton.widthAnchor.constraint(
        equalTo: contentView.heightAnchor,
        multiplier: 5/10
        ).isActive = true

        editButton.heightAnchor.constraint(
            equalTo: contentView.heightAnchor,
        multiplier: 4/10
        ).isActive = true

        editButton.centerYAnchor.constraint(
        equalTo: contentView.centerYAnchor
        ).isActive = true

//        editButton.centerXAnchor.constraint(
//        equalTo: numberLabel.rightAnchor//,
//       // constant:
//        ).isActive = true
        
        editButton.leftAnchor.constraint(
            equalTo: numberLabel.rightAnchor,
            constant: 3)
        
        editButton.rightAnchor.constraint(
        equalTo: contentView.rightAnchor,
        constant: -16
        ).isActive = true
               
    
}
}
