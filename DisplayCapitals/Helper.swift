//
//  Helper.swift
//  DisplayCapitals
//
//  Created by Imran shaik on 18/04/25.
//

import UIKit

class Helper {
    static func showAlert(title: String, message: String, from viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        
        viewController.present(alert, animated: true, completion: nil)
    }
}
