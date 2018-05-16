//
//  DataSpreadsheet.swift
//  TiempoDeEstudio
//
//  Created by Hector Díaz Aceves on 17/09/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit
import SpreadsheetView

class DataSpreadsheet: UIViewController, SpreadsheetViewDelegate, SpreadsheetViewDataSource {

    let heightOfRow: Int = 50
    
    var elementos = [String]()
    
    var data = [[Int]]()
    
    var totalSeconds = [Int]()
    
    var elementMiliseconds = [[Int]]()
    
    let spreadsheetView: SpreadsheetView = {
    
        let sv = SpreadsheetView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    
    
    }()
    
//    lazy var shareButton: UIButton = {
//    
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Share", for: .normal)
//        button.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
//        return button
//    
//    }()
    
    func handleShare(){
    
        let filename = "Times.csv"
        
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(filename)
        
        var transposeData = [[Int]]()
        
        let firstElements = elementMiliseconds[0]
            
        
        var elementIndex = 0
        
        for element in firstElements {
            
            var elementArray = [Int]()

            var index = 0
            
            for cycle in elementMiliseconds{
                
                elementArray.append(elementMiliseconds[index][elementIndex])
                
                index += 1
                
            }
            
            transposeData.append(elementArray)
            
            elementIndex += 1
        
        }
        
        var csvText = ""
        
        for element in transposeData {
            
            var newLine = ""
            
            let limit = element.count-1
        
            for i in 0...limit-1 {
                
                newLine.append("\(element[i]),")
                
            }
            
            newLine.append("\(element[limit])\n")
            
            csvText.append(newLine)
        
        
        }
        
        print(csvText)
        
        do{
        
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            
            let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
            
            present(vc, animated: true, completion: nil)

        
        } catch{
        
            print("Failed to create file")
            print("\(error)")
        
        }
        
        
    
    
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(handleHome))
        
        spreadsheetView.delegate = self
        spreadsheetView.dataSource = self
        
        spreadsheetView.backgroundColor = UIColor.white
        
        spreadsheetView.register(HourCell.self, forCellWithReuseIdentifier: String(describing: HourCell.self))
        spreadsheetView.register(ChannelCell.self, forCellWithReuseIdentifier: String(describing: ChannelCell.self))
        spreadsheetView.register(UINib(nibName: String(describing: SlotCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SlotCell.self))
        spreadsheetView.register(BlankCell.self, forCellWithReuseIdentifier: String(describing: BlankCell.self))
        
        spreadsheetView.backgroundColor = .black
        
        let hairline = 1 / UIScreen.main.scale
        spreadsheetView.intercellSpacing = CGSize(width: hairline, height: hairline)
        spreadsheetView.gridStyle = .solid(width: hairline, color: .lightGray)
        spreadsheetView.circularScrolling = CircularScrolling.Configuration.horizontally.rowHeaderStartsFirstColumn
        
        view.addSubview(spreadsheetView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupComponents()
        
       
        
        // Do any additional setup after loading the view.
    }
    
    func handleHome(){
    
        let controller = ViewController()
        
        let nc = UINavigationController(rootViewController: controller)
        
        present(nc, animated: true, completion: nil)
        
    
    
    }
    
    func setupComponents(){
    
        spreadsheetView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        spreadsheetView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        spreadsheetView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let height = (data[0].count + 2) * (heightOfRow + 3)
        print(height)
        
        spreadsheetView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return data.count + 1
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return data[0].count + 1
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if column == 0 {
            return 80
        }
        return 130
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        if row == 0 {
            return CGFloat(heightOfRow)
        }
        return CGFloat(heightOfRow)
    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        if indexPath.column == 0 && indexPath.row == 0 {
            return nil
        }
        
        if indexPath.column == 0 && indexPath.row > 0 {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HourCell.self), for: indexPath) as! HourCell
            cell.label.text = elementos[indexPath.row-1]
            cell.gridlines.top = .solid(width: 1, color: .white)
            cell.gridlines.bottom = .solid(width: 1, color: .white)
            return cell
        } else if indexPath.column > 0 && indexPath.row == 0 {
        
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: ChannelCell.self), for: indexPath) as! ChannelCell
            cell.label.text = "Cycle \(indexPath.column)"
            cell.gridlines.top = .solid(width: 1, color: .black)
            cell.gridlines.bottom = .solid(width: 1, color: .black)
            cell.gridlines.left = .solid(width: 1 / UIScreen.main.scale, color: UIColor(white: 0.3, alpha: 1))
            cell.gridlines.right = cell.gridlines.left
            return cell
        } else {
            
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: SlotCell.self), for: indexPath) as! SlotCell
            
            cell.title = getTimeString(miliseconds: elementMiliseconds[indexPath.column-1][indexPath.row-1])
            
            cell.tableHighlight = getTimeString(miliseconds: data[indexPath.column-1][indexPath.row-1])
            
            return cell

        }

        return spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: BlankCell.self), for: indexPath)
    }
    
    /// Delegate
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: (row: \(indexPath.row), column: \(indexPath.column))")
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
    

  

}

