//
//  Custom ImageView.swift
//  LMS
//
//  Created by Jojo Destreza on 1/15/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

class ImageViewWithLabel : UIView {
    
    lazy var imageView : UIImageView = {
        let v = UIImageView()
        v.backgroundColor = Config().colors.textColorLight
        return v
    }()
    
    lazy var labelView : UILabel = {
        let v = UILabel()
        v.numberOfLines = 2
        v.textAlignment = .center
        v.font = UIFont(name: Fonts.bold, size: 18)
        v.textColor = Config().colors.textColorDark
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
            make.width.height.equalTo(80)
        }
        
        imageView.layer.cornerRadius = 40
        
        addSubview(labelView)
        labelView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-10)
        }
        
    }
}
