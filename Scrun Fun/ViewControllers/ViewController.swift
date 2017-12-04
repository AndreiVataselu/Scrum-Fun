//
//  ViewController.swift
//  Scrun Fun
//
//  Created by Andrei Vataselu on 10/27/17.
//  Copyright © 2017 Andrei Vataselu. All rights reserved.
//

import UIKit

func getPlanningEvents() -> [PlanningEvent]{
 
    var planEvent = [PlanningEvent]()
    
    for i in 0...5 {
        planEvent.append(PlanningEvent(index: i))
    }
    
    return planEvent
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var phaseTimeLabel: UILabel!
    @IBOutlet weak var teamSatLabel : UILabel!
    @IBOutlet weak var customerSatLabel : UILabel!
    @IBOutlet weak var projectInvFundLabel : UILabel!
    @IBOutlet weak var etaWeeksLabel : UILabel!
    @IBOutlet weak var backlogLabel : UILabel!
    @IBOutlet weak var velocityLabel : UILabel!
    @IBOutlet weak var questionLabel : UILabel!
    @IBOutlet weak var tableView : UITableView!
    var multipleSelectionCancel : Bool = false
    

    var index : Int?

    
    func hideOutlets() {
        questionLabel.isHidden = true
        tableView.isHidden = true
    }
    
    func showOutlets() {
        tableView.reloadData()
        questionLabel.isHidden = false
        tableView.isHidden = false
    }
    
    
    let game = Game.getGame()
    let dailyPhase = ["Planning", "Daily Scrum", "Retrospective", "Review"]
    
    
    func getPhaseDisplay() -> String {
        
        let phase = game.getCurrentPhase()
        var returnString = "Sprint: \(phase.sprintIndex+1) - \(dailyPhase[phase.phaseType.hashValue])"
        
        if phase.phaseType == .daily {
            returnString.append(" \(phase.phaseIndex+1)")
        }
        
        return returnString
        
        
    }
    
    func getEstimatedWeeks() -> Int {
        return Int(ceil(Double((game.currentState.currentBacklogSize)/(game.currentState.velocity))))
    }
    
    func refreshView() {
        phaseTimeLabel.text = getPhaseDisplay()
        
        teamSatLabel.text = "Team satisfaction: \(game.currentState.teamSatisfaction)%"
        customerSatLabel.text = "Customer satisfaction: \(game.currentState.customerSatisfaction)%"
        projectInvFundLabel.text = "Project investment fund: $\(game.currentState.projectInvestmentFund)"
        etaWeeksLabel.text = "Estimated weeks: \(getEstimatedWeeks())"
        backlogLabel.text = "Current backlog size: \(game.currentState.currentBacklogSize)"
        velocityLabel.text = "Velocity: \(game.currentState.velocity) (modifier: \(game.currentState.velocityModifier)%)"

    }
    
    
    override func viewDidLoad() {
        
        checkForPlanningEvent()
        refreshView()
        self.tableView.tableFooterView = UIView()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkForPlanningEvent() {
        if game.getCurrentPhase().phaseType == .planning && Game.getGame().totalPlanningEvents.count > 0 {
            questionLabel.text = "Planning Event"
    
            showOutlets()
        }
    }

    func modifyFromPlanningEvent(planEvent : PlanningEvent) {
        
        
        game.currentState.projectInvestmentFund += planEvent.fundModifier * game.currentState.listOfDevelopers.count
        game.currentState.velocityModifier += planEvent.velocityModif
        game.currentState.teamMotivation += planEvent.motivationModif
        game.currentState.teamSatisfaction += planEvent.teamSatisfModi
        game.currentState.customerSatisfaction += planEvent.customerSatisfModif
        
        refreshView()
        hideOutlets()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        if game.getCurrentPhase().phaseType == .planning {
            if index != nil {
                let event = game.totalPlanningEvents.remove(at: index!)
                modifyFromPlanningEvent(planEvent: event)
            }
            index = nil
            hideOutlets()
        }
        
        
        game.updateMetrics()
        if game.nextPhase() == true {
            
            checkForPlanningEvent()
            refreshView()
        } else {
            self.performSegue(withIdentifier: "startEndGameSegue", sender: self)
        }
        
}

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanEventCell") as! PlanEventCell
        cell.configureCell(option: Game.getGame().totalPlanningEvents[indexPath.row].text)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.getGame().totalPlanningEvents.count
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PlanEventCell
        let sprintIndex = game.getCurrentPhase().sprintIndex

        if cell.selectedCell == false {
            cell.selectedCell = true
            cell.selImage.isHidden = false
            game.planningEvents[sprintIndex] = Game.getGame().totalPlanningEvents[indexPath.row]
            index = indexPath.row
        } else {
            cell.selectedCell = false
            cell.selImage.isHidden = true
            game.planningEvents[sprintIndex] = nil
            index = nil
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PlanEventCell
        let sprintIndex = game.getCurrentPhase().sprintIndex

        cell.selectedCell = false
        cell.selImage.isHidden = true
        game.planningEvents[sprintIndex] = nil
        index = nil

    }
    
}
