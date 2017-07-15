//
//  Alert.swift
//  Paint
//
//  Created by My Computer on 2017-07-15.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit

class Alert {
    
    //Create the alert
    func showAlert(title: String, message: String, fromVC: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(yesAction)
      
        fromVC.present(alert, animated: true, completion: nil)
    }
}
