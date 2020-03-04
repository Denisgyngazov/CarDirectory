//
//  CarTableViewController.swift
//  CarDirectory
//
//  Created by Денис Гынгазов on 03.03.2020.
//  Copyright © 2020 Денис Гынгазов. All rights reserved.
//

import UIKit
import RealmSwift

class CarTableViewController: UITableViewController {
    var car: Results<Car>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        car = realm.objects(Car.self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return car.isEmpty ? 0 : car.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarDirectoryCell
        
        cell.manufacturerLabel?.text = car[indexPath.row].manufacturer
        cell.modelLabel?.text = car[indexPath.row].model
        cell.bodyTypeLabel?.text = car[indexPath.row].bodyType
        cell.yearLabel?.text = car[indexPath.row].year
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
        let newCar = car[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
        StorageManager.deleteObject(newCar)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        complete(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
               configuration.performsFirstActionWithFullSwipe = true
               return configuration
            
        
    }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let newCarVC = segue.destination as! NewCarTableViewController
            newCarVC.currentCar = car[indexPath.row]
        }
    }
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newCarVC = segue.source as? NewCarTableViewController else {return}
        newCarVC.saveCar()
        tableView.reloadData()
    }
  
    
}

