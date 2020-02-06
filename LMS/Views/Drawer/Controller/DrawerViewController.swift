//
//  DrawerViewController.swift
//  LMS
//
//  Created by Jojo Destreza on 1/9/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

class MenuController: UIViewController {
    let reuseIdentifer = "MenuId"
    // MARK: - Properties
    
    var tableView: UITableView = {
        let v = UITableView()
        return v
    }()
    //    var delegate: HomeControllerDelegate?
    
    // MARK: - Init
    
    lazy var profileView : ImageViewWithLabel = {
        let v = ImageViewWithLabel()
        v.imageView.image = UIImage(named: "profile")
        v.labelView.text = "Mojow Profile"
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Config().colors.whiteBackground
        configureTableView()
    }
    
    // MARK: - Handlers
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIdentifer)
        tableView.backgroundColor = Config().colors.whiteBackground
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        
        view.addSubview(profileView)
        profileView.snp.makeConstraints { (make) in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(20)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(120)
        }
        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(profileView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! MenuOptionCell
        
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.descriptionLabel.text = menuOption?.description
        cell.iconImageView.image = menuOption?.image
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
//        let cell = tableView.cellForRow(at: indexPath) as! MenuOptionCell
//        cell.descriptionLabel.textColor = Config().colors.textColorDark
//        cell.iconImageView.tintColor = Config().colors.textColorDark
//        cell.backgroundColor = Config().colors.whiteBackground
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        
        let cell = tableView.cellForRow(at: indexPath) as! MenuOptionCell
        cell.animateView()
        
        let app = AppCoordinator(window: UIApplication.shared.keyWindow ?? UIWindow())
        if cell.descriptionLabel.text == "Settings" {
            app.showLogin()
        }
//        UIView.animate(withDuration: 1.0, animations: {
//            cell.iconImageView.tintColor = Config().colors.orangeBackground
//            cell.descriptionLabel.textColor = Config().colors.whiteBackground
//            cell.backgroundColor = Config().colors.textColorDark
//        }) { (res) in
//            if res {
//                UIView.animate(withDuration: 1.0, animations: {
//                    cell.iconImageView.tintColor = Config().colors.textColorDark
//                    cell.descriptionLabel.textColor = Config().colors.textColorDark
//                    cell.backgroundColor = Config().colors.whiteBackground
//                })
//            }
//        }
//
        //        delegate?.handleMenuToggle(forMenuOption: menuOption)
    }
    
    
}



