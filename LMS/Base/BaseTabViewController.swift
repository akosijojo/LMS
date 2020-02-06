//
//  BaseTabViewController.swift
//  LMS
//
//  Created by Jojo Destreza on 1/16/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit
import KYDrawerController

class BaseTabViewController : UIViewController {
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.backgroundColor = Config().colors.lightGraybackground
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Config().colors.whiteBackground
        setUpOnViewDidLoad()
    }
    
    func setUpOnViewDidLoad() {
        
    }
    override func viewDidLayoutSubviews() {
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        let leftBar =  UIBarButtonItem(image: UIImage(named: "menu_bar")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(showMenu))
        leftBar.tintColor = Config().colors.blueBgColor
        
        self.tabBarController?.navigationItem.leftBarButtonItem = leftBar
        
    }
    
    func setUpTitleImage() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        let logo = UIImage(named: "app_screen_oalmslogo") //?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image:logo)
        
        container.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.center.equalTo(container)
            make.width.height.equalTo(30)
        }
        
        self.tabBarController?.navigationItem.titleView = imageView
    }
    
    
    func setUpTitleText(title: String) {
        self.tabBarController?.navigationItem.titleView = nil
        self.tabBarController?.navigationItem.title = title
    }
    
    
    @objc func showMenu() {
        if let drawerController = UIApplication.shared.keyWindow?.rootViewController as? KYDrawerController {
            drawerController.view.endEditing(true)
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
    func setUpView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    
}
