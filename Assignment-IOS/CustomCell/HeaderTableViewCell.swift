//
//  HeaderTableViewCell.swift
//  Assignment-IOS
//
//  Created by Vikas Gupta on 06/07/20.
//  Copyright © 2020 Vikas Gupta. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var lblPaidEvent: UILabel!
    @IBOutlet weak var lblView: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var lblGroup: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
     @IBOutlet weak var lblType: UILabel!
     @IBOutlet weak var viewType: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblPaidEvent.layer.cornerRadius = 5
        lblPaidEvent.clipsToBounds = true
        viewType.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        viewType.layer.cornerRadius = 5
        viewType.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
