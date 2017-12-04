//
//  StartEndGame.swift
//  Scrun Fun
//
//  Created by Andrei Vataselu on 10/27/17.
//  Copyright © 2017 Andrei Vataselu. All rights reserved.
//

import Foundation
import UIKit

class StartEndGame: UIViewController {
        
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var winnerLoserLabel : UILabel! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let game = Game.getGame()
        
        if game.currentState.phasesIndex > 0 {
            
            if game.isWinner() {
                winnerLoserLabel.text = "Winner"
            } else {
                winnerLoserLabel.text = "Loser"
            }
            
            winnerLoserLabel.isHidden = false

        } else {
            winnerLoserLabel.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    
    @IBAction func startButtonPressed(_ sender: Any) {
        Game.resetGame()
        self.performSegue(withIdentifier: "newGame", sender: self)
    }
    
}
