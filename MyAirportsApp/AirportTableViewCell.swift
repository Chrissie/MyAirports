//
//  AirportTableViewCell.swift
//  MyAirportsApp
//
//  Created by Christiaan Paans on 19/10/2018.
//  Copyright © 2018 Christiaan Paans. All rights reserved.
//

import UIKit

class AirportTableViewCell: UITableViewCell {

    @IBOutlet weak var airportNameLabel: UILabel!
    @IBOutlet weak var airportIcaoLabel: UILabel!
    
    @IBOutlet weak var airportViewCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
