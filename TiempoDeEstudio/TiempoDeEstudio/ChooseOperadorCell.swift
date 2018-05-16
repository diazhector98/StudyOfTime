//
//  ChooseOperadorCell.swift
//  TiempoDeEstudio
//
//  Created by Hector Díaz Aceves on 15/08/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit

class ChooseOperadorCell: UITableViewCell {

    let nameTextField: UITextField = {
    
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    
    }()
    
    var buttonFunc: (()->(Void))!
    
    lazy var addButton: UIButton = {
    
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleAddButtonTapped), for: .touchUpInside)
        
        button.setTitle("Add", for: .normal)
        
        button.tintColor = UIColor(red:0.65, green:0.66, blue:1.00, alpha:1.0)
        
        return button
    
    
    
    }()
    
    func handleAddButtonTapped(){
    
        buttonFunc()
    
    }
    
    func setFunction(_ function: @escaping()-> Void){
    
        self.buttonFunc = function
    
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameTextField)
        addSubview(addButton)
        
        nameTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.70).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addButton.leftAnchor.constraint(equalTo: nameTextField.rightAnchor, constant: 10).isActive = true
        addButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.20).isActive = true
        addButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        
        
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
