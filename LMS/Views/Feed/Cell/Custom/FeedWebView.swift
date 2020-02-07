//
//  FeedWebView.swift
//  LMS
//
//  Created by Jojo Destreza on 2/6/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

protocol FeedWebViewAction: class {
    func onClickWebLink(view: FeedWebView, data : FeedWebLinkData?)
}
class FeedWebView : UIView {
    
    var delegate : FeedWebViewAction?
    
    var data: FeedWebLinkData? {
        didSet {
            self.name.text = self.data?.name
            self.img.image = UIImage(named: self.data?.img ?? "Sample3")
        }
    }
    
    lazy var container : UIView = {
        let v = UIView()
        v.layer.borderColor = Config().colors.lightGraybackground.cgColor
        v.layer.borderWidth = 1
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
    
    lazy var viewers :  UILabel = {
        let v = UILabel()
        v.font = UIFont(name: Fonts.bold, size: 10)
        v.text = "10+ Views"
        v.textColor = Config().colors.textColorLight
        v.textAlignment = .right
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(container)
        container.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        container.layer.cornerRadius = 10
        
        container.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.centerY.equalTo(container)
            make.leading.equalTo(container).offset(10)
            make.width.height.equalTo(100)
        }
        img.backgroundColor = Config().colors.lightGraybackground
        
        container.addSubview(name)
        name.snp.makeConstraints { (make) in
            make.top.equalTo(container).offset(20)
            make.leading.equalTo(img.snp.trailing).offset(10)
            make.trailing.equalTo(container).offset(-10)
            make.height.equalTo(20)
        }
        
        container.addSubview(desc)
        desc.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom)
            make.leading.equalTo(img.snp.trailing).offset(10)
            make.trailing.equalTo(container).offset(-10)
            make.bottom.equalTo(container).offset(-10)
        }
        
        container.addSubview(viewers)
        viewers.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalTo(100)
            make.trailing.equalTo(container).offset(-10)
            make.bottom.equalTo(container).offset(-5)
        }
        
        let onClickFile = UITapGestureRecognizer(target: self, action: #selector(onClickFileAction))
        container.isUserInteractionEnabled = true
        container.addGestureRecognizer(onClickFile)
    }
    
    @objc func onClickFileAction() {
        print("ON CLICK WEB LINK")
        self.delegate?.onClickWebLink(view: self, data: self.data)
    }
}
