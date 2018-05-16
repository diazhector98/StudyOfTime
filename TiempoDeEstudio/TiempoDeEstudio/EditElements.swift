//
//  EditElements.swift
//  TiempoDeEstudio
//
//  Created by Hector Díaz Aceves on 05/11/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit
import CoreData

class EditElements: UITableViewController {
    
    var elements: [NSManagedObject] = []
    
    var sArrElements: [String] = []
    
    var estacionId: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        
        let uibbAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        
        let uibbSave = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        navigationItem.rightBarButtonItems = [uibbSave, uibbAdd]
        
        tableView.register(StationCell.self, forCellReuseIdentifier: "cellId")
        getElements(estacionId)
        
    
    }
    
    
    func getElements(_ estacionId: String){
        
        print("Fetching elements")
    
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            
            return
            
            
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Element")
        
        let pred = NSPredicate(format: "(stationId = %@)", estacionId)
        
        let sort = NSSortDescriptor(key: "step", ascending: true)
        
        fetchRequest.predicate = pred
        
        fetchRequest.sortDescriptors = [sort]
        
        do {
            
            elements = try context.fetch(fetchRequest)
            
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
            
        }
        
        for nsoElement in elements {
        
            sArrElements.append(nsoElement.value(forKeyPath: "name") as! String);
        
        
        }
        
        tableView.reloadData()
    
    }
    
    func deleteElementsFromCoreData(_ estacionId: String){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        for object in elements {
        
            context.delete(object)
        
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            
            print(error.localizedDescription)
            
        }
        
    }
    
    func handleBack(){
    
        self.dismiss(animated: true, completion: nil)
    
    
    }
    
    func handleAdd(){
        
        var inputTextField: UITextField?
    
        let alert = UIAlertController(title: "Add element", message: "Type element name", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            inputTextField = textField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //Add element
            print(inputTextField?.text)
            
            self.addElement(elementName: (inputTextField?.text)!)
            
        }
        
        alert.addAction(cancelAction)
        
        alert.addAction(addAction)
        
        
        self.present(alert, animated: true, completion: nil)
    
    
    }
    
    func addElement(elementName: String){
    
        sArrElements.append(elementName)
        
        self.tableView.reloadData()
    
    
    }
    
    func handleSave(){
        
        deleteElementsFromCoreData(estacionId)
    
        //Saving elements in core data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            
            return
            
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Element", in: context)!
        
        
        var step = 0;
        
        for elementoName in sArrElements {
            
            
            let object = NSManagedObject(entity: entity, insertInto: context)
            
            object.setValue(estacionId, forKey: "stationId")
            
            object.setValue(elementoName, forKey: "name")
            
            object.setValue(step, forKey: "step")
            
            step += 1
            
            print(object.objectID)
            
        }
        
        do {
            
            try context.save()
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
            
        }
        
        let controller = ViewController()
        let nc = UINavigationController(rootViewController: controller);
        present(nc, animated: true, completion: nil)

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sArrElements.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as? StationCell
        
        cell?.stationLabel.text = sArrElements[indexPath.row]
        
        return cell!
    
    
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            sArrElements.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
