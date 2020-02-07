//
//  FeedFileViewCell.swift
//  LMS
//
//  Created by Jojo Destreza on 2/6/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

protocol FeedFileViewCellAction : class {
    func filePreview(cell: FeedFileViewCell,data : FeedFileData?)
    func fileViewers(cell: FeedFileViewCell,data : FeedFileData?)
    func fileDownloads(cell: FeedFileViewCell,data : FeedFileData?)
}

class FeedFileViewCell : BaseCell<FeedFileData> {
    
    override var data: FeedFileData? {
        didSet {
            self.fileName.text = self.data?.name
            self.img.image = UIImage(named: self.data?.img ?? "doc")
        }
    }
    
    var delegate : FeedFileViewCellAction?
    
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
    
    lazy var fileName : UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.bold, size: 16)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.4
        lbl.text = "File Name"
       return lbl
    }()
    
    lazy var fileDesc : UILabel = {
        let lbl = UILabel()
         lbl.font = UIFont(name: Fonts.regular, size: 16)
         lbl.adjustsFontSizeToFitWidth = true
         lbl.minimumScaleFactor = 0.4
         lbl.text = "Description hahahah ahwdihaw dioahwoi dahwoidh aoiwdhoa iwdhoaihw doaiwhdioahw dioahwoi dhaowid"
        lbl.numberOfLines = 2
        return lbl
    }()
    
    lazy var button : UIButton = {
       let v = UIButton()
        v.titleLabel?.font = UIFont(name: Fonts.regular, size: 14)
        v.setTitle("Preview", for: .normal)
        v.setTitleColor(Config().colors.whiteBackground, for: .normal)
        v.backgroundColor = Config().colors.blueBgColor
        v.layer.borderWidth = 1
        v.layer.borderColor = Config().colors.lightBlueBgColor.cgColor
       return v
    }()
    
    lazy var downloads : UILabel = {
        let v = UILabel()
        v.font = UIFont(name: Fonts.bold, size: 10)
        v.text = "10+ Downloads"
        v.textColor = Config().colors.textColorLight
        v.textAlignment = .center
        return v
    }()
    
    lazy var viewers :  UILabel = {
        let v = UILabel()
        v.font = UIFont(name: Fonts.bold, size: 10)
        v.text = "10+ Viewers"
        v.textColor = Config().colors.textColorLight
        v.textAlignment = .center
        return v
    }()
    
    
    override func setupView() {
        addSubview(container)
        container.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.bottom.equalTo(self)
        }
        
        container.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.centerY.equalTo(container)
            make.leading.equalTo(container)
            make.width.height.equalTo(80)
        }
        
        container.addSubview(fileName)
        fileName.snp.makeConstraints { (make) in
            make.top.equalTo(container).offset(20)
            make.leading.equalTo(img.snp.trailing).offset(10)
            make.trailing.equalTo(self)
            make.height.equalTo(20)
        }
        
        container.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalTo(fileName.snp.bottom).offset(20)
            make.leading.equalTo(img.snp.trailing).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        button.layer.cornerRadius = 5
        let width = (self.frame.width - 40 - 200) / 2
        container.addSubview(downloads)
        downloads.snp.makeConstraints { (make) in
            make.top.equalTo(fileName.snp.bottom).offset(20)
            make.leading.equalTo(button.snp.trailing).offset(10)
            make.width.equalTo(width)
            make.height.equalTo(20)
        }
        
        container.addSubview(viewers)
        viewers.snp.makeConstraints { (make) in
            make.top.equalTo(fileName.snp.bottom).offset(20)
            make.leading.equalTo(downloads.snp.trailing).offset(10)
            make.width.equalTo(width)
           make.height.equalTo(20)
        }
        
//        container.addSubview(fileDesc)
//        fileDesc.snp.makeConstraints { (make) in
//            make.top.equalTo(fileName.snp.bottom)
//            make.leading.equalTo(img.snp.trailing).offset(10)
//            make.trailing.equalTo(container)
//            make.bottom.equalTo(container)
//        }
        
        let onClickFile = UITapGestureRecognizer(target: self, action: #selector(onClickFileAction))
        container.isUserInteractionEnabled = true
        container.addGestureRecognizer(onClickFile)
    }
    
    @objc func onClickFileAction() {
        self.delegate?.filePreview(cell: self, data: self.data)
    }
}
