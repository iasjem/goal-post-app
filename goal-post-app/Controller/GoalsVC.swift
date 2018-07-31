//
//  GoalsVC.swift
//  goal-post-app
//
//  Created by Jemimah Beryl M. Sai on 30/07/2018.
//  Copyright © 2018 Jemimah Beryl M. Sai. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addGoalButtonPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "createGoalVC") else {  return  }
        presentDetail(createGoalVC)
    }
    }
    
    
extension GoalsVC {
    func fetch(completion: @escaping (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {  return  }
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {  return  }
        managedContext.delete(goals[indexPath.row])
        do {
            try managedContext.save()
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
    
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {  return  }
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {
            return
        }
        do {
            try managedContext.save()
        } catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
}

