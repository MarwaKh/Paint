//
//  PaintView.swift
//  Paint
//
//  Created by My Computer on 2017-07-07.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit

class PaintView: UIView {

    override func awakeFromNib() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 6.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
    }

}
