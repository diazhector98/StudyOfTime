//
//  StationCell.swift
//  TiempoDeEstudio
//
//  Created by Hector Díaz Aceves on 28/10/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit

class StationCell: UITableViewCell {

    let stationLabel: UILabel = {
    
        let label = UILabel()
        label.text = "Type station name"
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(stationLabel)
        
        stationLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        stationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stationLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        stationLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.90).isActive = true
        
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
