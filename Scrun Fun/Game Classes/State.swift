//
//  State.swift
//  Scrun Fun
//
//  Created by Andrei Vataselu on 10/27/17.
//  Copyright © 2017 Andrei Vataselu. All rights reserved.
//

import Foundation



class State {
    var teamSatisfaction : Int
    var teamMotivation : Int
    var customerSatisfaction : Int
    var projectInvestmentFund : Int
    var listOfDevelopers : [Developer]
    var phasesIndex : Int
    
    var currentBacklogSize : Int
    var velocity : Int
    var velocityModifier : Int

    
    init(developers: [Developer], tMotivation : Int, tSatisfaction : Int, cSatisfaction : Int, projInvestment: Int, pIndex : Int, currBacklogSize: Int) {
        
        var sum = 0
        for i in 0..<developers.count {
            sum += developers[i].velocityPerWeek
        }
        
        self.teamMotivation = tMotivation
        self.teamSatisfaction = tSatisfaction
        self.customerSatisfaction = cSatisfaction
        self.projectInvestmentFund = projInvestment
        self.phasesIndex = pIndex
        self.listOfDevelopers = developers
        self.currentBacklogSize = currBacklogSize
        self.velocity = sum
        self.velocityModifier = 0
        
        switch(developers.count) {
        case 5:
            self.velocityModifier -= 5
            
        case 6:
            self.velocityModifier -= 10
            
        case 7:
            self.velocityModifier -= 15
            
        case 8,9,10:
            self.velocityModifier -= 20
            
        default:
            break
        }
        
        var maleDevs : Double = 0
        for i in 0..<developers.count {
            if developers[i].gender == true {
                maleDevs += 1
            }
        }
        
        let malePercent = maleDevs / Double(developers.count)
        if malePercent > 0.6 || malePercent < 0.4 {
            self.velocityModifier -= 20
        }
    }
    
    
    
}
