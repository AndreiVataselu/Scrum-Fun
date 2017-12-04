//
//  Event.swift
//  Scrun Fun
//
//  Created by Andrei Vataselu on 10/27/17.
//  Copyright © 2017 Andrei Vataselu. All rights reserved.
//

import Foundation
import SwiftyJSON



class PlanningEvent {
    
    var text : String
    var fundModifier : Int
    var velocityModif : Int
    var motivationModif : Int
    var teamSatisfModi : Int
    var customerSatisfModif : Int
    
    
    init(index: Int) {
        self.text = ""
        self.fundModifier = 0
        self.velocityModif = 0
        self.motivationModif = 0
        self.teamSatisfModi = 0
        self.customerSatisfModif = 0
        
        if let path = Bundle.main.path(forResource: "events", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = JSON(data: data)
                self.text = json[index]["text"].stringValue
                self.fundModifier = json[index]["fund"].intValue
                self.velocityModif = json[index]["velocity"].intValue
                self.motivationModif = json[index]["motivation"].intValue
                self.teamSatisfModi = json[index]["team satisfaction"].intValue
                self.customerSatisfModif = json[index]["customer satisfaction"].intValue
                
            } catch {
                print("Couldn't parse JSON")
            }
        }
    }
    
}
