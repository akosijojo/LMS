//
//  ChatViewController.swift
//  LMS
//
//  Created by Jojo Destreza on 1/9/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

class ChatViewController : BaseTabViewController {
   
    override func setUpNavigationBar() {
        setUpTitleText(title: "Messages")
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        
    }
}

