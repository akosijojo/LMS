//
//  App Coordinator.swift
//  LMS
//
//  Created by Jojo Destreza on 01/09/20.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit
import KYDrawerController

class AppCoordinator {
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        let mainViewController   = CustomTabBarController()
        let drawerViewController = MenuController()
        let drawerController     =  KYDrawerController(drawerDirection: KYDrawerController.DrawerDirection.left, drawerWidth: 250)
        let navigationController = UINavigationController(
            rootViewController: mainViewController
        )
        navigationController.navigationBar.barTintColor = Config().colors.whiteBackground
        navigationController.navigationBar.tintColor  = Config().colors.blueBgColor
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: Fonts.bold, size: 20),NSAttributedString.Key.foregroundColor : Config().colors.textColorDark]
        
        drawerController.mainViewController = navigationController
        drawerController.drawerViewController = drawerViewController
        
        window.rootViewController = drawerController
        
//        if let user = UserDefaults.standard.value(forKey: localArray.userAccount) {
//            print("SAVE USERS DATA : \(user)")
//            let navigationController = UINavigationController(
//                rootViewController: CustomTabBarController()
//            )
//            navigationController.navigationBar.barTintColor = Config().colors.blueBgColor
//            navigationController.navigationBar.tintColor  = Config().colors.blackBgColor
//            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Config().colors.whiteBackground]
//
//            self.window.rootViewController = navigationController
//        }else {
//            showLogin()
//        }
     
    }
    
    func showLogin() {
        let controller = LoginViewController()
        controller.viewModel = LoginViewModel()
        controller.viewModel?.model = LoginModel()
        let navigationController = UINavigationController(
            rootViewController:controller
        )
        navigationController.navigationBar.barTintColor = Config().colors.whiteBackground
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        self.window.rootViewController = navigationController
    }
    
}
