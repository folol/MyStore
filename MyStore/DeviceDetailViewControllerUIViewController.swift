//
//  DeviceDetailViewControllerUIViewController.swift
//  MyStore
//
//  Created by Devansh on 14/03/19.
//  Copyright © 2019 Devansh. All rights reserved.
//

import UIKit
import CoreData

class DeviceDetailViewControllerUIViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var versionTF: UITextField!
    @IBOutlet weak var companyTF: UITextField!
    
    @IBAction func cancelButtonPress(_ sender: Any) {
        //self.navigationController?.popViewController(animated: false)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPress(_ sender: Any) {
        let nameStr = nameTF.text
        let versionStr = versionTF.text
        let companyStr = companyTF.text
        
        if nameStr?.isEmpty != true {
            if versionStr?.isEmpty != true {
                if companyStr?.isEmpty != true {
                    guard let appDelegate =
                        UIApplication.shared.delegate as? AppDelegate else {
                            return
                    }
                    let managedContext =
                        appDelegate.persistentContainer.viewContext
                    let entity =
                        NSEntityDescription.entity(forEntityName: "Device",
                                                   in: managedContext)!
                    let person = NSManagedObject(entity: entity,
                                                 insertInto: managedContext)
                    person.setValue(nameStr, forKeyPath: "name")
                    person.setValue(versionStr, forKey: "version")
                    person.setValue(companyStr, forKey: "company")
                    do {
                        try managedContext.save()
                        //self.navigationController?.popViewController(animated: false)
                        dismiss(animated: true, completion: nil)
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
                else{
                    showAlert(title: "Error", message: "Enter company")
                    return
                }
            }
            else{
                showAlert(title: "Error", message: "Enter version")
                return
            }
        }
        else{
            showAlert(title: "Error", message: "Enter name")
            return
        }
        
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
