//
//  PictureCell.swift
//  Paint
//
//  Created by My Computer on 2017-07-19.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit

class PictureCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureView: UIImageView!
    var picture: Picture! {
        didSet {
            updateCell()
        }
        
    }

    
    private func updateCell() {
        
        if let encodedData = picture.encodeB64 {
        pictureView.image = UIImage(data: picture.decodeBase64(encodedData: encodedData))
        }
    }

}
