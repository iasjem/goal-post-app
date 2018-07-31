//
//  FinishGoalVC.swift
//  goal-post-app
//
//  Created by Jemimah Beryl M. Sai on 31/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var createGoalButton: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalButton.bindToKeyboard()
        pointsTextField.delegate = self
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func createGoalButtonPressed(_ sender: Any) {
        if pointsTextField != nil {
            self.save { (complete) in
                if complete {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func save(completion: @escaping (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {  return  }
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        do {
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save \(error.localizedDescription)")
            completion(false)
        }
    }
}
