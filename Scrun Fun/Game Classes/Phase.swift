//
//  Phase.swift
//  Scrun Fun
//
//  Created by Andrei Vataselu on 10/27/17.
//  Copyright © 2017 Andrei Vataselu. All rights reserved.
//

import Foundation
import SwiftyJSON

enum PhaseType {
    case planning
    case daily
    case retro
    case review
}

class Phase {
    
    var phaseType : PhaseType
    var sprintIndex : Int
    var phaseIndex : Int
    var sprintSize : Int
    
    
    
    init(phaseType : PhaseType, sprintIndex : Int, phaseIndex : Int, sprSize: Int) {
        self.sprintIndex = sprintIndex
        self.phaseIndex = phaseIndex
        self.phaseType = phaseType
        self.sprintSize = sprSize
    }
    
}
