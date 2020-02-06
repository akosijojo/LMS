//
//  FeedWebLinkCell.swift
//  LMS
//
//  Created by Jojo Destreza on 2/6/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

struct FeedWebLinkData {
   var name : String?
   var desc : String?
   var img : String?
   var url : String?
}

class FeedWebLinkCell : BaseCell<FeedWebLinkData> {
    override var data: FeedWebLinkData? {
        didSet {
            self.name.text = self.data?.name
        }
    }
    
    lazy var container : UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var img : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.masksToBounds = true
        return img
    }()
    
    lazy var name : UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.bold, size: 16)
        lbl.text = "Web Name"
        lbl.textColor = Config().colors.blueBgColor
       return lbl
    }()
    
    lazy var desc : UILabel = {
        let lbl = UILabel()
         lbl.font = UIFont(name: Fonts.regular, size: 16)
         lbl.text = "Description hahahah ahwdihaw dioahwoi dahwoidh aoiwdhoa iwdhoaihw doaiwhdioahw dioahwoi dhaowid"
        lbl.numberOfLines = 2
        return lbl
    }()
    
    
    override func setupView() {
        addSubview(container)
        container.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(-10)
        }
        
        container.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.centerY.equalTo(container)
            make.leading.equalTo(container)
            make.width.height.equalTo(100)
        }
        
        container.addSubview(name)
        name.snp.makeConstraints { (make) in
            make.top.equalTo(container).offset(10)
            make.leading.equalTo(img.snp.trailing).offset(10)
            make.trailing.equalTo(self)
            make.height.equalTo(20)
        }
        
        container.addSubview(desc)
        desc.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom)
            make.leading.equalTo(img.snp.trailing).offset(10)
            make.trailing.equalTo(container)
            make.bottom.equalTo(container)
        }
        
//        let onClickFile = UITapGestureRecognizer(target: self, action: #selector(onClickFileAction))
//        container.isUserInteractionEnabled = true
//        container.addGestureRecognizer(onClickFile)
    }
    
}
