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

    func createConstraints() {
        
        strelkaImageView.widthAnchor.constraint(
            equalTo: contentView.widthAnchor,
            multiplier: 1/12
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
        
        
        
                    
        mainLabel.heightAnchor.constraint(
            equalTo: contentView.heightAnchor
        ).isActive = true
                    
        mainLabel.centerYAnchor.constraint(
            equalTo: contentView.centerYAnchor
        ).isActive = true
                    
        mainLabel.leftAnchor.constraint(
            equalTo: strelkaImageView.rightAnchor,
            constant: 10
        ).isActive = true
        
        mainLabel.rightAnchor.constraint(
            equalTo: numberLabel.leftAnchor,
            constant: -2
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
        
        numberLabel.rightAnchor.constraint(
            equalTo: editButton.leftAnchor,
            constant: -10
        ).isActive = true
        

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
        
        editButton.leftAnchor.constraint(
            equalTo: numberLabel.rightAnchor,
            constant: 3).isActive = true
        
        editButton.rightAnchor.constraint(
            equalTo: contentView.rightAnchor,
            constant: -16
        ).isActive = true
    }
}
