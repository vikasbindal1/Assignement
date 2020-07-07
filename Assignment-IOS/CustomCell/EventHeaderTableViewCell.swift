//
//  EventHeaderTableViewCell.swift
//  Assignment-IOS
//
//  Created by Vikas Gupta on 06/07/20.
//  Copyright © 2020 Vikas Gupta. All rights reserved.
//

import UIKit

class EventHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var btnPlusAction: UIButton!
    
    @IBOutlet weak var lblHeaderName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
