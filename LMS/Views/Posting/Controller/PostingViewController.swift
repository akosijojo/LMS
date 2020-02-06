//
//  PostingViewController.swift
//  LMS
//
//  Created by Jojo Destreza on 1/16/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

class PostingViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        view.backgroundColor = Config().colors.whiteBackground
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "arrow_left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = Config().colors.blueBgColor
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        let leftButton = UIBarButtonItem(customView: backButton)
        
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

