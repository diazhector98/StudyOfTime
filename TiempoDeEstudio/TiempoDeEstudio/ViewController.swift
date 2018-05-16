//
//  ViewController.swift
//  TiempoDeEstudio
//
//  Created by Hector Díaz Aceves on 13/08/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var estaciones: [NSManagedObject] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func deleteAllData (){
    
        var request = NSFetchRequest<NSManagedObject>(entityName: "Station")
        
        if let result = try? context.fetch(request) {
        
            for object in result {
            
                context.delete(object)
            
            
            }
        
        }
        
        request = NSFetchRequest<NSManagedObject>(entityName: "Element")
        
        if let result = try? context.fetch(request) {
            
            for object in result {
                
                context.delete(object)
                
                
            }
            
        }
        
        do {
            try context.save()
        } catch let error as NSError {
        
            print(error.localizedDescription)
        
        }
    
    
    }
    
    lazy var tableView: UITableView = {
    
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    
    }()
    
    let button: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Add station", for: .normal)
        button.tintColor = UIColor(red:0.65, green:0.66, blue:1.00, alpha:1.0)
        button.titleLabel?.font = UIFont(name: (button.titleLabel?.font.fontName)!, size: 30)
        button.addTarget(self, action: #selector(handleAgregarEstacion), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func handleAgregarEstacion(){
        
        
        let controller = NombreDeEstacion()
        
        let navigationController = UINavigationController(rootViewController: controller)
    
        present(navigationController, animated: true, completion: nil)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Stations"
        view.backgroundColor = .white
        
        
        getData()
        self.tableView.reloadData()

        view.addSubview(tableView)
        view.addSubview(button)
        
        tableView.register(StationCell.self, forCellReuseIdentifier: "cellId")
        
        setupComponents()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getData(){
    

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
        
            return
        
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Station")
        
        
        do {
        
            estaciones = try managedContext.fetch(fetchRequest)
        
        
        } catch let error as NSError {
        
        print(error.localizedDescription)
        
        }
        
        tableView.reloadData()
        
        
    
    }
    
    func setupComponents(){
    
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true

        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true

        tableView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10).isActive = true

        
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true

        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true

        button.widthAnchor.constraint(equalToConstant: 200).isActive = true

        button.heightAnchor.constraint(equalToConstant: 30).isActive = true

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return estaciones.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as? StationCell
        
        cell?.stationLabel.text = estaciones[indexPath.row].value(forKeyPath: "name") as? String
        
        return cell!
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let estactionId: String = estaciones[indexPath.row].objectID.description
        let estacionName: String = estaciones[indexPath.row].value(forKeyPath: "name") as! String
        
        handleTomaDeTiempos(estacionId: estactionId, estacionName: estacionName)
        
        
        
    }
    
    func handleTomaDeTiempos(estacionId: String, estacionName: String){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            
            return
            
            
        }
    
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Element")
        
        let pred = NSPredicate(format: "(stationId = %@)", estacionId)
        
        let sort = NSSortDescriptor(key: "step", ascending: true)
        
        fetchRequest.predicate = pred
        
        fetchRequest.sortDescriptors = [sort]
        
        var elements:[NSManagedObject] = []
        
        
        do {
            
            elements = try context.fetch(fetchRequest)
            
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
            
        }
        
        var elementos: [String] = []
        
        for element in elements {
                        
            elementos.append((element.value(forKeyPath: "name") as! String))
            
        }
        
        let tomaDeTiemposController = TomaDeTiempos()
        tomaDeTiemposController.estacionId = estacionId
        tomaDeTiemposController.stationTitle = estacionName
        tomaDeTiemposController.elementos = elementos
        
        let nc = UINavigationController(rootViewController: tomaDeTiemposController)
        
        present(nc, animated: true, completion: nil)
        
        
    
    
    }
    

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
        
            var request = NSFetchRequest<NSManagedObject>(entityName: "Element")
            var id = estaciones[indexPath.row].objectID
            
            let predicate = NSPredicate(format: "(stationId = %@)", id)
            request.predicate = predicate
            
            
            //Delete station from stations
            context.delete(estaciones[indexPath.row])
            
            //Delete elements of station
            if let result = try? context.fetch(request){
                for object in result {
                    context.delete(object)
                }
            }
            
            do {
                try context.save()
            } catch let error as NSError {
                
                print(error.localizedDescription)
                
            }
            
            //Delete row from tableview
            self.estaciones.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            
            
        }
        
        
    }
    

}











































