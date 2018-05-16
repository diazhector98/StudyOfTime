//
//  NombrarElementosViewController.swift
//  TiempoDeEstudio
//
//  Created by Hector Díaz Aceves on 15/08/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit
import CoreData

class NombrarElementosViewController: UIViewController {


    var nombreDeEstacion: String?
    
    var shifts: Int?
    
    var currentIndexPath: IndexPath = IndexPath()
    
    var elementos = [String]()
    
    var operadores = [String]()
    
    var maxTurnos: Int?
    
    lazy var tableView: UITableView = {
    
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        tv.delegate = self
        return tv
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        navigationItem.title = "Add Elements"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleNext))
        
        tableView.register(ChooseOperadorCell.self, forCellReuseIdentifier: "cellId")
        
        setupComponents()

        // Do any additional setup after loading the view.
    }
    
    func handleCancel(){
    
        self.dismiss(animated: true, completion: nil)
    
    }
    
    func handleNext(){
        
        //Check if last item has text
        
        let cell = tableView.cellForRow(at: currentIndexPath) as? ChooseOperadorCell
        
        if(cell?.nameTextField.text != ""){
            let alert = UIAlertController(title: "It seems you wrote something on the last element but didn't add it.", message: "This element won't be added. Continue?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in

            }))
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                self.addStationAndElementsToCoreData()
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {

        addStationAndElementsToCoreData()
        
        }
        
       
    
    }
    
    func addStationAndElementsToCoreData(){
        
        if(elementos.count == 0){
        
            let alert = UIAlertController(title: "No elements!", message: "A station can't have 0 elements", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(alert, animated: true, completion: nil)
        
        } else {
        
        //Saving station in core data
        
        ////////////
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            
            return
            
            
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        var entity = NSEntityDescription.entity(forEntityName: "Station", in: managedContext)!
        
        let estacion = NSManagedObject(entity: entity, insertInto: managedContext)
        
        print("Id: \(estacion.objectID.description)")
        
        estacion.setValue(nombreDeEstacion, forKey: "name")
        
        estacion.setValue(Int16(shifts!), forKey: "shifts")
        
        
        do {
            
            try managedContext.save()
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
            
        }
        
        
        var estacionId = estacion.objectID.description
        
        
        //Saving elements in core data

        entity = NSEntityDescription.entity(forEntityName: "Element", in: managedContext)!
        
        var step = 0;
        for elementoName in elementos {
            
            
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            
            object.setValue(estacionId, forKey: "stationId")
            
            object.setValue(elementoName, forKey: "name")
            
            object.setValue(step, forKey: "step")
            
            step += 1
            
            print(object.objectID)
            
        }
        
        do {
            
            try managedContext.save()
            
        } catch let error as NSError {
            
            print(error.localizedDescription)
            
        }
        
        //Presenting next view controller
        
        //        let controller = EstacionSeleccionada()
        //        controller.operadores = self.operadores
        //        controller.elementos = self.elementos
        //        controller.nombreDeEstacion = self.nombreDeEstacion
        //
        //
        //        controller.maxTurnos = self.maxTurnos
        
        let controller = TomaDeTiempos()
        controller.elementos = self.elementos
        
        //
        
        let nc = UINavigationController(rootViewController: controller)
        present(nc, animated: true, completion: nil)
        
        }
        
    }
    
    
    func setupComponents(){
    
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

    
   
}

extension NombrarElementosViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as? ChooseOperadorCell
        
        if cell == nil{
            
            
            tableView.register(ChooseOperadorCell.self, forCellReuseIdentifier: "cellId")
            cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as? ChooseOperadorCell
            
        }
        
        if indexPath.row != elementos.count{
            
            cell?.nameTextField.placeholder = elementos[indexPath.row]
            
            
        }
        
        self.currentIndexPath = indexPath
        
        
        cell?.setFunction {
            
            cell?.addButton.isHidden = true

            self.addElemento((cell?.nameTextField.text)!)
            
        }
        
        
        return cell!
    }
    
    func addElemento(_ name: String){
        
        print("\(name) Added")
        elementos.append(name)
        tableView.reloadData()
        
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementos.count + 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    


}
