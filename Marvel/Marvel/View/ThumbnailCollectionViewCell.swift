//
//  ThumbnailCollectionViewCell.swift
//  Marvel
//
//  Created by Administrator on 25/06/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import UIKit

class ThumbnailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbnailImageView.isUserInteractionEnabled = false
    }

}
