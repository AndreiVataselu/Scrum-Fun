//
//  SetupScreen.swift
//  Scrun Fun
//
//  Created by Andrei Vataselu on 10/27/17.
//  Copyright © 2017 Andrei Vataselu. All rights reserved.
//

import UIKit

class SetupScreen: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sprintSize.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sprintSize[row]
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clientExpectationsLabel: UILabel!
    @IBOutlet weak var backlogSizeLabel: UILabel!
    @IBOutlet weak var weekPicker: UIPickerView!
    @IBOutlet weak var startSprintingButton : UIButton!
    
    let sprintSize = ["1 Week", "2 Weeks", "3 Weeks"]
    let game = Game.getGame()

        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        clientExpectationsLabel.text = "Client Expectations: \(game.initialNumberOfWeeks) weeks"
        backlogSizeLabel.text = "Backlog size: \(game.initialBacklogSize)"
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getSelectedDevelopers() -> [Developer] {
        var selectedDevs = [Developer]()
        for i in 0...9 {
            if game.selectedDeveloper[i] == true {
                selectedDevs.append(game.developers[i])
            }
        }
        return selectedDevs
    }
    
    
    @IBAction func startSprintingButtonPressed(_ sender: Any) {
        if getSelectedDevelopers().count == 0 {
            let devAlert = UIAlertController(title: "No developers selected", message: nil, preferredStyle: .alert)
            
            let devAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            devAlert.addAction(devAction)
            present(devAlert, animated: true, completion: nil)
            
        } else {
        
        game.startSprinting(selDevs : getSelectedDevelopers(), sprintDuration: (weekPicker.selectedRow(inComponent: 0)+1))
        
        self.performSegue(withIdentifier: "loadPhase", sender: self)
        }
        
    }
    
}

extension SetupScreen : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.developers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell") as! TeamCell
        cell.configureCell(developer: game.developers[indexPath.row], selectedDev: game.selectedDeveloper[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TeamCell
        
        if game.selectedDeveloper[indexPath.row] == false {
            game.selectedDeveloper[indexPath.row] = true
            cell.selectedView.isHidden = false
        } else {
            game.selectedDeveloper[indexPath.row] = false
            cell.selectedView.isHidden = true
        }        
    }
}
