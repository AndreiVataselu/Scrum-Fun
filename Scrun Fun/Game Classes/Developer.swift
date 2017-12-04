//
//  Developer.swift
//  Scrun Fun
//
//  Created by Andrei Vataselu on 10/27/17.
//  Copyright © 2017 Andrei Vataselu. All rights reserved.
//

import Foundation

enum technology : Int {
    case frontEnd = 0
    case backEnd = 1
    case integrations = 2
    case ai = 3
    
}

func randomBool () -> Bool {
    return arc4random_uniform(2) == 0
}

func randomMotivation () -> Int {
    return Int(arc4random_uniform(51) + 50)
}

func randomVelocity () -> Int {
    return Int(arc4random_uniform(5) + 1)
}

func randomTechnology() -> technology {
    return technology(rawValue: Int(arc4random_uniform(4)))!
    
}

func getGender(genderBool : Bool)-> String {
    if genderBool == true {
        return "M"
    }
    return "F"
}

func randomNameGenerator(gender: String) -> String {
    let maleNames = ["John", "Mark", "Dean", "Stephen", "Aaron", "Paul", "David", "Brad", "Mario", "Bryan", "Elon", "Steven", "Gibson", "Ivan", "Julian", "Chris", "Max", "Louis", "Marcel", "Tyron", "Zack"]
    let femaleNames = ["Emily", "Julia", "Olivia", "Charlotte", "Violet", "Adeline", "Elizabeth", "Anna", "Iris", "Chloe", "Clara", "Beatrice", "Scarlett", "Madeline", "Hannah", "Eve", "Felicity", "Rosalie", "Sofia", "Louise", "Claudia"]
    
    if gender == "M" {
        return maleNames[Int(arc4random_uniform(21))]
    } else {
        return femaleNames[Int(arc4random_uniform(21))]
    }
    
}

class Developer {
    var name : String
    var gender : Bool
    var motivationLevel : Int
    var velocityPerWeek : Int
    
    var primary : technology
    var secondary : technology
    
    
    init() {
        self.gender = randomBool()
        self.name = randomNameGenerator(gender: getGender(genderBool: self.gender))
        self.motivationLevel = randomMotivation()
        self.velocityPerWeek = randomVelocity()
        self.primary = randomTechnology()
        self.secondary = randomTechnology()
    }
}
