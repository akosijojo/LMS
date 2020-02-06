//
//  ViewController .swift
//  LMS
//
//  Created by Jojo Destreza on 01/09/20.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hidesKeyboardOnTapArround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
         view.endEditing(true)
    }
    
    
}
