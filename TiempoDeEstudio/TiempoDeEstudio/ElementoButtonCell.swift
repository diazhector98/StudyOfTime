//
//  ElementoButtonCell.swift
//  TiempoDeEstudio
//
//  Created by Hector Díaz Aceves on 20/08/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit

class ElementoButtonCell: UICollectionViewCell {
    
    
    var buttonFunc: (() -> (Void))!
    
    
    lazy var button: UIButton = {
    
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1).cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        

        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitle("Element", for: .normal)
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        return button
    
    }()
    
    func handleButtonTap(){
    
        buttonFunc()
    }
    
    func setFunction(_ function: @escaping() -> Void){
    
        self.buttonFunc = function
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95).isActive = true
        button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.95).isActive = true
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
