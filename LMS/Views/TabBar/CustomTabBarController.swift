//
//  CustomTabBarController.swift
//  LMS
//
//  Created by Jojo Destreza on 1/15/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

class CustomTabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = FeedViewController()
//        let v1 = UINavigationController(rootViewController: vc1)
        let tb1:UITabBarItem = UITabBarItem(title: " ", image: UIImage(named: "home")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "home_filled")?.withRenderingMode(.alwaysTemplate))
        vc1.tabBarItem = tb1
//        v1.interactivePopGestureRecognizer?.isEnabled = true
        vc1.tabBarItem.title = ""
        
        let vc2 = ChatViewController()
//        let v2 = UINavigationController(rootViewController: vc2)
        let tb2:UITabBarItem = UITabBarItem(title: " ", image: UIImage(named: "like")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "like_filled")?.withRenderingMode(.alwaysTemplate))
        vc2.tabBarItem = tb2
//        v2.interactivePopGestureRecognizer?.isEnabled = true
        vc2.tabBarItem.title = ""
        
        let vc3 = NotificationViewController()
//        let v3 = UINavigationController(rootViewController: vc3)
        let tb3:UITabBarItem = UITabBarItem(title: " ", image: UIImage(named: "star")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "star_filled")?.withRenderingMode(.alwaysTemplate))
        vc3.tabBarItem = tb3
//        v3.interactivePopGestureRecognizer?.isEnabled = true
        vc3.tabBarItem.title = ""
        
        viewControllers = [vc1,vc2,vc3]
        tabBar.barTintColor = Config().colors.whiteBackground
        tabBar.tintColor = Config().colors.blueBgColor
        
        
    }
    
}
