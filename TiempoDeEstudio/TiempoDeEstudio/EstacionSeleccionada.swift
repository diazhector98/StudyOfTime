//
//  EstacionSeleccionada.swift
//  TiempoDeEstudio
//
//  Created by Hector Díaz Aceves on 19/08/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit

class EstacionSeleccionada: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var nombre: String?
    
    var operadores = [String]()
    
    var elementos = [String]()
    
    var nombreDeEstacion: String?
    
    var maxTurnos: Int? {
    
        didSet {
        
            turnoStepper.maximumValue = Double(maxTurnos!)
        
        }
    
    }
    
    let operadorLabel: UILabel = {
    
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose operator"
        return label
    
    
    }()
    
    lazy var operadorPickerView : UIPickerView = {
    
        let pv = UIPickerView()
        pv.dataSource = self
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.delegate = self
        return pv
    
    }()
    
    let turnoLabel: UILabel = {
    
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose shift"
        return label
    
    }()
    
    let turnoNumberLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        return label
    
    }()
    
    lazy var turnoStepper: UIStepper = {
    
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.addTarget(self, action: #selector(handleChangeTurn), for: .valueChanged)
        return stepper
    
    
    }()
    
    func handleChangeTurn(){
    
        turnoNumberLabel.text = String(Int(turnoStepper.value))
    
    }
    
    lazy var nextButton: UIButton = {
    
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    
    }()
    
    func handleSave(){
    
        saveStation()
        
        let controller = TomaDeTiempos()
        controller.elementos = self.elementos
        let nc = UINavigationController(rootViewController: controller)
        present(nc, animated: true, completion: nil)
        
    
    }
    
    func saveStation(){
    
        
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleCancel))
        
        view.addSubview(operadorLabel)
        view.addSubview(operadorPickerView)
        view.addSubview(turnoLabel)
        view.addSubview(turnoNumberLabel)
        view.addSubview(turnoStepper)
        view.addSubview(nextButton)
        
        setupComponents()
        

        // Do any additional setup after loading the view.
    }
    
    func handleCancel(){
    
        self.dismiss(animated: true, completion: nil)
    
    }
    
    func setupComponents(){
    
        operadorLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        operadorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        operadorLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        operadorLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        operadorPickerView.topAnchor.constraint(equalTo: operadorLabel.bottomAnchor, constant: 30).isActive = true
        operadorPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        operadorPickerView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        operadorPickerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        turnoLabel.topAnchor.constraint(equalTo: operadorPickerView.bottomAnchor, constant: 30).isActive = true
        turnoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        turnoLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        turnoLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        turnoNumberLabel.topAnchor.constraint(equalTo: turnoLabel.bottomAnchor, constant: 30).isActive = true
        turnoNumberLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        turnoNumberLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        turnoNumberLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        turnoStepper.topAnchor.constraint(equalTo: turnoLabel.bottomAnchor, constant: 10).isActive = true
        turnoStepper.leftAnchor.constraint(equalTo: turnoNumberLabel.rightAnchor, constant: 10).isActive = true
        turnoStepper.widthAnchor.constraint(equalToConstant: 40).isActive = true
        turnoStepper.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        nextButton.topAnchor.constraint(equalTo: turnoStepper.bottomAnchor, constant: 30).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        

    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return operadores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return operadores[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
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

}
