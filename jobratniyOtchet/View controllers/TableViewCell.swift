//
//  TableViewCell.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 17/05/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewCell: UITableViewCell {

    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var strelkaImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = #colorLiteral(red: 0.4690965603, green: 0.4316392344, blue: 0.8572700777, alpha: 1)
    }
    
    func configure(_ indexPath: IndexPath) {
        
         let cellText = tasksLists[indexPath.row]
        mainLabel.text = cellText.task
        numberLabel.text = " \(cellText.currentNumber)/\(cellText.countOfTask)"
        overDoValue = 0
        editButton.tag = indexPath.row
    }
}
