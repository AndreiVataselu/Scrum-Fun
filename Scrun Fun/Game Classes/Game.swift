//
//  Game.swift
//  Scrun Fun
//
//  Created by Andrei Vataselu on 10/27/17.
//  Copyright © 2017 Andrei Vataselu. All rights reserved.
//

import Foundation

func randomBacklogSize() -> Int {
    return Int(arc4random_uniform(200) + 200)
}

func randomEstimateWeeks() -> Int {
    return Int(arc4random_uniform(8) + 7)
}

func randomCustomerSatisfaction() -> Int {
    return Int(arc4random_uniform(10) + 90)
}

func randomTeamSatisfaction() -> Int {
    return Int(arc4random_uniform(10) + 85)

}

func randomProjectInvestment() -> Int {
    return Int(arc4random_uniform(500) + 500)
}

class Game {
    // To do:
    // - Timp
    
    
    static var game = Game()
    
//    var planningEvents : [PlanningEvent]
    var developers : [Developer]
    var selectedDeveloper : [Bool]
    
    var initialTeamSatisfaction : Int
    var initialTeamMotivation : Int
    var initialCustomerSatisfaction : Int
    var initialProjectInvestmentFund : Int
    var initialNumberOfWeeks : Int
    var initialBacklogSize : Int
    var technologiesUsed : [Int] = [technology.ai.hashValue + 1]
    var phases : [Phase]
    var sDuration : Int
    var planningEvents = [PlanningEvent?]()
    var currentState : State
    var numberOfSprints : Int
    var totalPlanningEvents : [PlanningEvent]
    
    private init() {
        
        developers = [Developer]()
        selectedDeveloper = [Bool]()
        
        for _ in 0...9 {
            developers.append(Developer())
            selectedDeveloper.append(false)
        }

        self.initialTeamMotivation = 0
        self.initialTeamSatisfaction = randomTeamSatisfaction()
        self.initialCustomerSatisfaction = randomCustomerSatisfaction()
        self.initialProjectInvestmentFund = randomProjectInvestment()
        self.initialNumberOfWeeks = randomEstimateWeeks()
        self.phases = [Phase]()
        self.sDuration = 0
        self.initialBacklogSize = randomBacklogSize()
        self.currentState = State(developers: developers, tMotivation: 0, tSatisfaction: 0, cSatisfaction: 0, projInvestment: 0, pIndex: 0, currBacklogSize: 0)
        self.numberOfSprints = 0
        self.totalPlanningEvents = getPlanningEvents()

    }
    
    func getCurrentPhase() -> Phase {
        return phases[(currentState.phasesIndex)]

    }
    
    static func resetGame() {
        game = Game()
    }
    
    static func getGame() -> Game{
        return game
    }
    
    func nextPhase() -> Bool {
                
        
        self.currentState.phasesIndex += 1
        
        // MARK: - Check Condition
        if self.currentState.phasesIndex >= self.phases.count || checkEndOfGameCondition() || self.currentState.currentBacklogSize < 0 {
            return false
        }
        return true
    }
    
    
    func getRemainingWeeks() -> Int {
        return 0
    }
    
    func checkEndOfGameCondition() -> Bool {
        if self.currentState.teamSatisfaction < 70 || self.currentState.customerSatisfaction < 70 || self.currentState.projectInvestmentFund < -1000 {
            return true
        }
        return false
    }
    
    func isWinner() -> Bool {
        return Double(self.currentState.currentBacklogSize / self.initialBacklogSize) < 0.15 && self.currentState.teamSatisfaction > 85 && self.currentState.customerSatisfaction > 90 && self.currentState.projectInvestmentFund > 0 
    }
    
    func updateBacklog(){
        
        if self.currentState.teamSatisfaction < 75 {
            self.currentState.velocityModifier -= 20
        } else
        if self.currentState.teamSatisfaction < 85 {
            self.currentState.velocityModifier -= 10
        } else if self.currentState.teamSatisfaction > 100 {
            self.currentState.velocityModifier += 30
        } else if self.currentState.teamSatisfaction > 90 {
            self.currentState.velocityModifier += 10
        }
        
        // MARK: - Customer Satisfaction
        
        let actualVelocity : Int = self.currentState.velocity + Int(Double(self.currentState.velocity * self.currentState.velocityModifier) / 100.0)
        self.currentState.currentBacklogSize -= actualVelocity * getCurrentPhase().sprintSize
    }
    
    func updateMetrics() {
        if getCurrentPhase().phaseType == .retro {
            updateBacklog()
        }
    }
    
    func generatePhases(sprintDuration: Int) {
        
         numberOfSprints = Int(ceil(Double(initialNumberOfWeeks) / Double(sprintDuration)))
        
        for i in 0..<numberOfSprints {
            
            var sd = self.sDuration * 5
            
            if (i == (numberOfSprints-1))
            {
                sd = (initialNumberOfWeeks - (i*sDuration)) * 5
            }
            
            phases.append(Phase(phaseType: .planning, sprintIndex: i, phaseIndex: 0, sprSize: sd/5))
            
        
            
            for j in 0..<sd {
                phases.append(Phase(phaseType: .daily, sprintIndex: i, phaseIndex: j, sprSize: sd/5))
            }
            
            phases.append(Phase(phaseType: .retro, sprintIndex: i, phaseIndex: 0, sprSize: sd/5))
            phases.append(Phase(phaseType: .review, sprintIndex: i, phaseIndex: 0, sprSize: sd/5))
            
        }
    }
    
    func initState(selDevs: [Developer]) {
        self.currentState = State(developers: selDevs, tMotivation: self.initialTeamMotivation, tSatisfaction: self.initialTeamSatisfaction, cSatisfaction: self.initialCustomerSatisfaction, projInvestment: self.initialProjectInvestmentFund, pIndex: 0, currBacklogSize: self.initialBacklogSize)
        
        
        
    }
    
    public func startSprinting(selDevs: [Developer], sprintDuration: Int ) {
        sDuration = sprintDuration
        generatePhases(sprintDuration: sDuration)
        for i in 0..<numberOfSprints {
            planningEvents.append(nil)
        }
        initState(selDevs: selDevs)
        
    }
    
}
