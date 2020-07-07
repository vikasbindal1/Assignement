//
//  OverviewTableViewCell.swift
//  Assignment-IOS
//
//  Created by Vikas Gupta on 06/07/20.
//  Copyright © 2020 Vikas Gupta. All rights reserved.
//

import UIKit
import MapKit

class OverviewTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTIme: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lbAGE: UILabel!
    
    @IBOutlet weak var viewMap: MKMapView!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblEventCountry: UILabel!
    @IBOutlet weak var lblEventAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
