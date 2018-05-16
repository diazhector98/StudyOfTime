//
//  NombreYNumeroDeElementos.swift
//  TiempoDeEstudio
//
//  Created by Hector Díaz Aceves on 13/08/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit
import CoreData

class NombreDeEstacion: UIViewController {
    
    var operadores = [String]()
    
    let nombreLabel: UILabel = {
    
        let label = UILabel()
        label.text = "Type station name"
        label.font = UIFont(name: "Avenir", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    let nombreTextField: UITextField = {
    
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    
    
    }()
    
    lazy var nextButton: UIButton = {
    
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.tintColor = UIColor(red:0.65, green:0.66, blue:1.00, alpha:1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    
    
    }()
    
    var numeroDeTurnos: UILabel = {
        
        let label = UILabel()
        label.text = "Shifts"
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

    }()
    
    let shiftSwitch: UISwitch = {
    
        let shiftSwitch = UISwitch()
        shiftSwitch.translatesAutoresizingMaskIntoConstraints = false
        shiftSwitch.addTarget(self, action: #selector(toggleShifts), for: .valueChanged)
        return shiftSwitch
    
    }()
    
    func toggleShifts(){
    
        if turnosSlider.isHidden {
        
            turnosSlider.isHidden = false
        
        } else {
        
            turnosSlider.isHidden = true
        
        }
    
    }
    
    lazy var turnosSlider: UISlider = {
    
        let slider = UISlider()
        slider.isHidden = true
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.addTarget(self, action: #selector(handleChangeTurnos), for: .valueChanged)
        return slider
    
    
    }()
    
    func handleChangeTurnos(){
    
        var turnos = Int(turnosSlider.value)
        
        numeroDeTurnos.text = "\(turnos) Shifts"
        
    
    }
    
    let operadoresLabel: UILabel = {
    
        let label = UILabel()
        label.text = "Operators"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    

    
    let operadorTextField: UITextField = {
        
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
        
    }()
    
    lazy var tableView: UITableView = {
    
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.register(ChooseOperadorCell.self, forCellReuseIdentifier: "cellId")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        
        view.addSubview(nombreLabel)
        view.addSubview(nombreTextField)
        view.addSubview(nextButton)
        
//        view.addSubview(numeroDeTurnos)
//        view.addSubview(shiftSwitch)
//        
//
//        
//        view.addSubview(turnosSlider)
//        view.addSubview(operadoresLabel)
//        view.addSubview(tableView)
        
        
        setupComponents()

        // Do any additional setup after loading the view.
    }
    
    func setupComponents(){
        
        nombreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        nombreLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nombreLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nombreLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nombreTextField.topAnchor.constraint(equalTo: nombreLabel.bottomAnchor, constant: 20).isActive = true
        nombreTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nombreTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        nombreTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nextButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: nombreTextField.bottomAnchor, constant: 10).isActive = true
        
        
//        numeroDeTurnos.topAnchor.constraint(equalTo: nombreTextField.bottomAnchor, constant: 30).isActive = true
//        numeroDeTurnos.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        numeroDeTurnos.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        numeroDeTurnos.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        
//        shiftSwitch.rightAnchor.constraint(equalTo: numeroDeTurnos.rightAnchor, constant: 10).isActive = true
//        shiftSwitch.topAnchor.constraint(equalTo: nombreTextField.bottomAnchor, constant: 30).isActive = true
//        shiftSwitch.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        shiftSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        
//        
//        turnosSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        turnosSlider.topAnchor.constraint(equalTo: numeroDeTurnos.bottomAnchor, constant: 20).isActive = true
//        turnosSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        turnosSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
//        
//        operadoresLabel.topAnchor.constraint(equalTo: turnosSlider.bottomAnchor, constant: 30).isActive = true
//        operadoresLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        operadoresLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        operadoresLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        
//        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        tableView.topAnchor.constraint(equalTo: operadoresLabel.bottomAnchor, constant: 20).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
//        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        
        
    }
    

    
    
    func handleCancel(){
    
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleNext(){
        
        let nombreDeEstacion = nombreTextField.text
        
        if(nombreDeEstacion == ""){
        
            let alert = UIAlertController(title: "Station Name Empty", message: "Please enter station name.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(alert, animated: true, completion: nil)
        
        
        } else{
        
            let shifts = Int(turnosSlider.value)
        
            let view = NombrarElementosViewController()

            view.shifts = shifts
        
            view.operadores = self.operadores
        
            view.maxTurnos = Int(turnosSlider.value)
        
            view.nombreDeEstacion = nombreDeEstacion
        
            let controller = UINavigationController(rootViewController: view)
        
            present(controller, animated: true, completion: nil)
        
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    


}

extension NombreDeEstacion: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as? ChooseOperadorCell
        
        if cell == nil{
        
            
            tableView.register(ChooseOperadorCell.self, forCellReuseIdentifier: "cellId")
            cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as? ChooseOperadorCell
        
        }
        
        if indexPath.row != operadores.count{
            
            cell?.nameTextField.placeholder = operadores[indexPath.row]
        
        
        }
        
        
        
        cell?.setFunction {
            self.addOperador((cell?.nameTextField.text)!)
        }
        
        
        return cell!
    }
    
    func addOperador(_ name: String){
    
        print("\(name) Added")
        operadores.append(name)
        tableView.reloadData()
        
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operadores.count + 1
    }

}
