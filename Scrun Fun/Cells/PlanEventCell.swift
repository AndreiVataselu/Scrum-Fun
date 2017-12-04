//
//  PlanEventCell.swift
//  Scrun Fun
//
//  Created by Andrei Vataselu on 10/28/17.
//  Copyright © 2017 Andrei Vataselu. All rights reserved.
//

import Foundation
import UIKit

class PlanEventCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var selImage : UIImageView!
    var selectedCell : Bool = false

    
    func configureCell(option : String) {
        self.titleLabel.text = option
        self.selImage.isHidden = true
    }
    
}
