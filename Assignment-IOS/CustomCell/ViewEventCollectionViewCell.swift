
//
//  ViewEventCollectionViewCell.swift
//  Assignment-IOS
//
//  Created by Vikas Gupta on 06/07/20.
//  Copyright © 2020 Vikas Gupta. All rights reserved.
//

import UIKit

class ViewEventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgUser.layer.cornerRadius = imgUser.frame.width / 2
        imgUser.clipsToBounds = true
    }

}
