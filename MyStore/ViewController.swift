//
//  ViewController.swift
//  MyStore
//
//  Created by Devansh on 12/03/19.
//  Copyright © 2019 Devansh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {

    var devicesArr : [NSManagedObject]?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devicesArr != nil ? devicesArr!.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellView = tableView.dequeueReusableCell(withIdentifier: "LIST_IDENTIFIER", for: indexPath)
    
        cellView.textLabel?.text = devicesArr != nil && indexPath.row < devicesArr!.count
            ? (devicesArr![indexPath.row] as? Device)?.name : "No data available"
        
        return cellView
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        managedContext.delete(devicesArr![indexPath.row])
        do {
            try managedContext.save()
            devicesArr?.remove(at: indexPath.row)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Device")
        do {
            devicesArr = try managedContext.fetch(fetchRequest)
            self.tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}

