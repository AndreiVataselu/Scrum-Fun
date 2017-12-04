//
//  TeamCell.swift
//  Scrun Fun
//
//  Created by Andrei Vataselu on 10/27/17.
//  Copyright © 2017 Andrei Vataselu. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {

    
    @IBOutlet weak var nameGenderLabel : UILabel!
    @IBOutlet weak var primarySecondaryLabel : UILabel!
    @IBOutlet weak var motivationVelocityLabel : UILabel!
    @IBOutlet weak var selectedView : UIView!
    
    func getGender (genderBool : Bool) -> String {
        if genderBool == true {
            return "M"
        }
        return "F"
    }
    
    func configureCell (developer: Developer, selectedDev: Bool) {
        
        self.nameGenderLabel.text = "Name: \(developer.name) | Gender: \(getGender(genderBool: developer.gender))"
        self.primarySecondaryLabel.text = "Skills: \(developer.primary), \(developer.secondary)"
        self.motivationVelocityLabel.text = "Motivation: \(developer.motivationLevel)% | Velocity: \(developer.velocityPerWeek)"
        self.selectedView.isHidden = !selectedDev
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
