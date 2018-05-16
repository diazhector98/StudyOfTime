//
//  TomaDeTiempos.swift
//  TiempoDeEstudio
//
//  Created by Hector Díaz Aceves on 20/08/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit
import Canvas

class TomaDeTiempos: UIViewController {

    var timer: Timer!
    
    var estacionId: String = String()
    
    var stationTitle: String = String()
    
    var elementos = [String]()
    
    var currentElementIndex = 0
    
    var totalTimeCycle = 0
    
    var data: [[Int]] = []
    
    var cycleData: [Int] = []
    
    var totalMiliseconds = 0

    
    var secondsOfCycles: [Int] = []
    
    var secondsInCurrentCycle: Int = 0
    
    var cycle: Int = 1

    
    var secondsOfElements: [Int] = []
    
    var secondsOfElementsInCycles: [[Int]] = []
    
    var secondsInCurrentElement: Int = 0
    
    var buttonsTapped: Int = 0
    
    
    //Seconds in cycle
    
    var cycleMiliseconds: Int = 0
    var cycleSeconds: Int = 0
    var cycleMinutes: Int = 0
    
    
    //Total seconds in time study
    var numberOfMiliseconds: Int = 0
    var numberOfSeconds: Int = 0
    var numberOfMinutes: Int = 0
    
    let cycleTimeLabel: UILabel = {
        
        let label = UILabel()
        label.text = "00 : 00 : 00"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir", size: 48)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()

    
    let timeLabel: UILabel = {
    
        let label = UILabel()
        label.text = "00 : 00 : 00"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir", size: 20)
        label.textColor = UIColor(red:0.35, green:0.64, blue:0.91, alpha:1.0)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    let cycleLabel: UILabel = {
    
        let label = UILabel()
        label.text = "Cycle 1"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir", size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    
    }()
    
    lazy var restartCycle: UIButton = {
    
        let button = UIButton(type: .system)
        button.setTitle("Restart", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        button.setTitleColor(UIColor(red:0.29, green:0.33, blue:0.89, alpha:1.0), for: .normal)
        button.addTarget(self, action: #selector(handleRestartCycle), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    }()
    
    func handleRestartCycle(){

        currentElementIndex = 0
        
        cycleData.removeAll()
        
        secondsOfElements.removeAll()
        
        secondsInCurrentElement = 0
        
        buttonsTapped = 1

        self.collectionView.reloadData()
    
    }
    
    lazy var deleteCycle: UIButton = {
    
        let button = UIButton(type: .system)
        button.setTitle("Delete Cycle", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        button.setTitleColor(UIColor(red:0.29, green:0.33, blue:0.89, alpha:1.0), for: .normal)
        button.addTarget(self, action: #selector(handleDeleteCycle), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    }()
    
    func handleDeleteCycle(){
    
        if cycle != 1 {
        
            cycle -= 1
            buttonsTapped = 0
            cycleLabel.text = "Cycle \(cycle)"
            self.collectionView.reloadData()
        
        }
    
    
    }
    
    lazy var endCycle: UIButton = {
    
        let button = UIButton(type: .system)
        button.setTitle("End", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        button.setTitleColor(UIColor(red:0.29, green:0.33, blue:0.89, alpha:1.0), for: .normal)
        button.addTarget(self, action: #selector(handleEndCycle), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    }()
    
    func handleEndCycle(){
    
        cycle += 1
        
        for _ in buttonsTapped...elementos.count {
            
            secondsOfElements.append(0)
            
            cycleData.append(totalMiliseconds)

        
        }
        
        data.append(cycleData)
        
        secondsOfElementsInCycles.append(secondsOfElements)
        
        currentElementIndex = 0
        
        cycleData.removeAll()
        
        secondsOfElements.removeAll()
        
        secondsInCurrentElement = 0
        
        
        buttonsTapped = 1
        cycleLabel.text = "Cycle \(cycle)"
        collectionView.reloadData()
    
        
    
    }
    
    lazy var newCycle: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("New", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        button.setTitleColor(UIColor(red:0.29, green:0.33, blue:0.89, alpha:1.0), for: .normal)
        button.addTarget(self, action: #selector(handleNewCycle), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    func handleNewCycle(){
    
    
        cycle += 1
        buttonsTapped = 0
        cycleLabel.text = "Cycle \(cycle)"
        collectionView.reloadData()
        

    
    }
    
    let currentElementLabel: UILabel = {
    
        let label = UILabel()
        label.text = "00 : 00 : 00"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir", size: 25)
        label.textColor = UIColor(red:0.84, green:0.20, blue:0.20, alpha:1.0)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var doneButton: UIButton = {
    
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont(name: (button.titleLabel?.fontName)!, size: 25)
        
        button.tintColor = UIColor(red:0.65, green:0.66, blue:1.00, alpha:1.0)
        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    
    }()
    
    func handleDone(){
        
        if(data.isEmpty){
        
            handleHome()
            
        
        } else{
    
        let vController = DataSpreadsheet()
        
        if(data.count == 0){
        
            for _ in buttonsTapped...elementos.count {
                
                secondsOfElements.append(0)
                
                cycleData.append(totalMiliseconds)
                
            }
            
            data.append(cycleData)
            
            secondsOfElementsInCycles.append(secondsOfElements)
            
        
        }
        vController.data = data
        vController.totalSeconds = secondsOfCycles
        vController.elementMiliseconds = secondsOfElementsInCycles
        vController.elementos = elementos
        let nc = UINavigationController(rootViewController: vController)
        present(nc, animated: true, completion: nil)
            
        }
        
    
    }
    
    var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = stationTitle;
        
        view.backgroundColor = .white
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(handleHome))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEdit))
        
    
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        print("Height \(view.frame.height)")
        print(view.frame.width * 0.95)
                
        let cellWidth = view.frame.width * 0.95 / 4;
        
        let cellHeight = cellWidth;
        
        
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(ElementoButtonCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self

        
        view.addSubview(cycleTimeLabel)
        view.addSubview(timeLabel)
        view.addSubview(collectionView)
        view.addSubview(cycleLabel)
        
        view.addSubview(restartCycle)
        view.addSubview(endCycle)
        view.addSubview(newCycle)
        
        view.addSubview(currentElementLabel)
        
        view.addSubview(doneButton)
        
        setupComponents()
        
        // Do any additional setup after loading the view.
    }
    
    func handleHome(){
    
        let controller = ViewController()
        let nc = UINavigationController(rootViewController: controller)
        present(nc, animated: true, completion: nil)
    
    }
    
    func handleEdit(){
    
        let controller = EditElements()
        
        controller.estacionId = estacionId
        
        let nc = UINavigationController(rootViewController: controller)
        self.present(nc, animated: true, completion: nil)
    
    
    }
    
    func handleAddTime(){
        
        totalMiliseconds += 1
        secondsInCurrentCycle += 1
        secondsInCurrentElement += 1
        cycleMiliseconds += 1
        
        //Total Time Setup
            
        if numberOfMiliseconds == 9 {
        
            numberOfMiliseconds = 0
            numberOfSeconds += 1
            if numberOfSeconds == 60 {
                numberOfSeconds = 0
                numberOfMinutes += 1
            }
    
        } else {
            numberOfMiliseconds += 1
        }
        var numberOfSecondsString: String = String(numberOfSeconds)
        if numberOfSeconds < 10 {
            numberOfSecondsString = "0\(numberOfSecondsString)"
        
        }
        
        var numberOfMinutesString: String = String(numberOfMinutes)
        
        if numberOfMinutes < 10 {
            
            numberOfMinutesString = "0\(numberOfMinutesString)"
            
        }
        
        timeLabel.text = "\(numberOfMinutesString) : \(numberOfSecondsString) : \(numberOfMiliseconds)"
        
        cycleTimeLabel.text = "\(getTimeString(miliseconds: secondsInCurrentCycle))"
        
        //Time of element setup
        
        currentElementLabel.text = "\(elementos[currentElementIndex]) \(getTimeString(miliseconds: secondsInCurrentElement))"
        
    
    }
    
    func getTimeString(miliseconds : Int) -> String {
    
        var timeString: String = ""
        
        var seconds: Int = 0
        var minutes: Int = 0
        var deciseconds: Int = 0
        
        minutes = miliseconds / 600
        
        seconds = (miliseconds - minutes * 600) / 10
        
        deciseconds = (miliseconds - minutes * 600 - seconds * 10)
        
        var numberOfSecondsString: String = String(seconds)
        
       
        if seconds < 10 {
            
            numberOfSecondsString = "0\(numberOfSecondsString)"
            
        }
        
        var numberOfMinutesString: String = String(minutes)
        
        if deciseconds < 10 {
            
            numberOfMinutesString = "0\(numberOfMinutesString)"
            
        }

        
        timeString = "\(numberOfMinutesString) : \(numberOfSecondsString) : \(deciseconds)"
        
        
        return timeString
        
    
    
    }
    
    func setupComponents(){
        
        cycleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        cycleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cycleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cycleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        cycleTimeLabel.topAnchor.constraint(equalTo: cycleLabel.bottomAnchor, constant: 5).isActive = true
        cycleTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        cycleTimeLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true

        cycleTimeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        timeLabel.topAnchor.constraint(equalTo: cycleTimeLabel.bottomAnchor, constant: 5).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        timeLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        
        restartCycle.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5).isActive = true
        
        restartCycle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        restartCycle.widthAnchor.constraint(equalToConstant: 100).isActive = true
        restartCycle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        endCycle.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5).isActive = true
        endCycle.rightAnchor.constraint(equalTo: restartCycle.leftAnchor, constant: -10).isActive = true
        endCycle.widthAnchor.constraint(equalToConstant: 100).isActive = true
        endCycle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        newCycle.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5).isActive = true
        newCycle.leftAnchor.constraint(equalTo: restartCycle.rightAnchor, constant: 10).isActive = true
        newCycle.widthAnchor.constraint(equalToConstant: 100).isActive = true
        newCycle.heightAnchor.constraint(equalToConstant: 25).isActive = true


        doneButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        currentElementLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        currentElementLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        currentElementLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currentElementLabel.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -10).isActive = true
        
        
        collectionView.topAnchor.constraint(equalTo: newCycle.bottomAnchor, constant: 20).isActive = true

        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true

        collectionView.bottomAnchor.constraint(equalTo: currentElementLabel.topAnchor, constant: -10).isActive = true

    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension TomaDeTiempos: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elementos.count
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? ElementoButtonCell
        
        cell?.button.setTitle(elementos[indexPath.row], for: .normal)
        
        cell?.button.layer.borderColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1).cgColor
        
        if(indexPath.row+1 <= buttonsTapped){
        
            cell?.button.layer.borderColor = UIColor.lightGray.cgColor
        
        }
        
        cell!.setFunction {
            
            self.checkIfNewCycle()
            
            if indexPath.row == 0 && self.cycle == 1{

                self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleAddTime), userInfo: nil, repeats: true)
                
                
            }
        
            cell?.button.layer.borderColor = UIColor.lightGray.cgColor
            

        }
        
        
        
        
        return cell!
        
        
    }
    
    func checkIfNewCycle(){
        
        self.buttonsTapped += 1;
        
        if(!(buttonsTapped == 1 && cycle == 1)){
            
            cycleData.append(totalMiliseconds)
            
            secondsOfElements.append(secondsInCurrentElement)
            
            secondsInCurrentElement = 0
            
            if(currentElementIndex < elementos.count-1){
            
                currentElementIndex += 1
            
            } else {
            
                currentElementIndex = 0
            
            }
            
            
            if(buttonsTapped == elementos.count){
                
                self.collectionView.reloadData()
                
                
                cycle += 1
                
                buttonsTapped = 0
                
                
            }
            
            if(buttonsTapped == 1 && cycle != 0){
                
                data.append(cycleData)
                
                secondsOfElementsInCycles.append(secondsOfElements)
                
                secondsOfCycles.append(secondsInCurrentCycle)
                
                cycleLabel.text = "Cycle \(cycle)"
                
//                UIView.animate(withDuration: 1, animations: {
//                })
                
                UIView.animate(withDuration: 1, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: { 
                    
                    self.cycleLabel.alpha = 0;

                    
                }, completion: nil)
                
                UIView.animate(withDuration: 1, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                    
                    self.cycleLabel.alpha = 1;
                    
                    
                }, completion: nil)
                
                
                
                secondsInCurrentCycle = 0
                
                cycleData.removeAll()
                
                secondsOfElements.removeAll()
                
                
            }
            
        
        }
        
            

            
        
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }



}
