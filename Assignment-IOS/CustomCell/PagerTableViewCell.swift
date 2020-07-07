//
//  PagerTableViewCell.swift
//  Assignment-IOS
//
//  Created by Vikas Gupta on 06/07/20.
//  Copyright © 2020 Vikas Gupta. All rights reserved.
//

import UIKit

class PagerTableViewCell: UITableViewCell{
    @IBOutlet weak var pagerCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pagerCollectionView.register(UINib(nibName: "PagerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PagerCollectionViewID")
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
