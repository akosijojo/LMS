//
//  MenuCell.swift
//  LMS
//
//  Created by Jojo Destreza on 1/9/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell {
    
    // MARK: - Properties
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.tintColor = Config().colors.textColorDark
        return iv
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Config().colors.textColorDark
        label.font = UIFont(name: Fonts.bold, size: 16)
        label.text = ""
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 12).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func animateView() {
        UIView.animate(withDuration: 1.0, animations: {
            self.iconImageView.tintColor = Config().colors.orangeBackground
            self.descriptionLabel.textColor = Config().colors.whiteBackground
            self.backgroundColor = Config().colors.textColorDark
        }) { (res) in
            if res {
                UIView.animate(withDuration: 2.0, animations: {
                    self.iconImageView.tintColor = Config().colors.textColorDark
                    self.descriptionLabel.textColor = Config().colors.textColorDark
                    self.backgroundColor = Config().colors.whiteBackground
                })
                self.animateView()
            }
        }
        
    }
    // MARK: - Handlers
    
}

