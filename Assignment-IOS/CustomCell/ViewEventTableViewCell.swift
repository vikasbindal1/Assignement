//
//  ViewEventTableViewCell.swift
//  Assignment-IOS
//
//  Created by Vikas Gupta on 06/07/20.
//  Copyright © 2020 Vikas Gupta. All rights reserved.
//

import UIKit

class ViewEventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
         eventCollectionView.register(UINib(nibName: "ViewEventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ViewEventCollectionViewCell1")
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
