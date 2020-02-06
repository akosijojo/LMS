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
            make.width.height.equalTo(80)
        }
        
        container.addSubview(fileName)
        fileName.snp.makeConstraints { (make) in
            make.top.equalTo(container).offset(10)
            make.leading.equalTo(img.snp.trailing).offset(10)
            make.trailing.equalTo(self)
            make.height.equalTo(20)
        }
        
        container.addSubview(fileDesc)
        fileDesc.snp.makeConstraints { (make) in
            make.top.equalTo(fileName.snp.bottom)
            make.leading.equalTo(img.snp.trailing).offset(10)
            make.trailing.equalTo(container)
            make.bottom.equalTo(container)
        }
        
        let onClickFile = UITapGestureRecognizer(target: self, action: #selector(onClickFileAction))
        container.isUserInteractionEnabled = true
        container.addGestureRecognizer(onClickFile)
    }
    
    @objc func onClickFileAction() {
        self.delegate?.filePreview(cell: self, data: self.data)
    }
}
