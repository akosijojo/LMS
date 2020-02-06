//
//  NotificationViewController.swift
//  LMS
//
//  Created by Jojo Destreza on 1/9/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

class NotificationViewController: BaseTabViewController {
    override func setUpNavigationBar() {
        setUpTitleText(title: "Notification")
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
}
