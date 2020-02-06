//
//  FeedActionView.swift
//  LMS
//
//  Created by Jojo Destreza on 1/21/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

struct FeedActionData {
    var likeCount : Int?
    var commentCount : Int?
    var isLiked : Bool?
}

protocol FeedActionViewDelegate : class {
    func likeButtonAction(view: FeedActionView)
    func commentButtonAction(view: FeedActionView)
}

class FeedActionView : UIView {
    lazy var likeButton : UIButton = {
        let v = UIButton()
        v.setTitleColor(Config().colors.textColorDark, for: .normal)
        v.titleLabel?.font = UIFont(name: Fonts.medium, size: 16)
        v.setTitle(" 100 Likes", for: .normal)
        v.setImage(UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        v.titleLabel?.adjustsFontSizeToFitWidth = true
        v.titleLabel?.minimumScaleFactor = 0.5
        v.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        v.tintColor = Config().colors.lightGraybackground
        return v
    }()
    
    lazy var commentButton : UIButton = {
        let v = UIButton()
        v.setTitleColor(Config().colors.textColorDark, for: .normal)
        v.titleLabel?.font = UIFont(name: Fonts.medium, size: 16)
        v.setTitle(" 200 Comments", for: .normal)
        v.setImage(UIImage(named: "comment")?.withRenderingMode(.alwaysTemplate), for: .normal)
        v.tintColor = Config().colors.blueBgColor
        v.titleLabel?.adjustsFontSizeToFitWidth = true
        v.titleLabel?.minimumScaleFactor = 0.5
        v.addTarget(self, action: #selector(commentButtonAction), for: .touchUpInside)
        return v
    }()
    
    var delegate : FeedActionViewDelegate?
    
    var data : FeedActionData?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(likeButton)
        likeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.leading.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.5)
            make.height.equalTo(self)
        }
        
        addSubview(commentButton)
        commentButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.leading.equalTo(likeButton.snp.trailing)
            make.width.equalTo(self).multipliedBy(0.5)
            make.height.equalTo(self)
        }
    }
    
    func onDataGet() {
        if let likeCount = data?.likeCount , let commentCount = data?.commentCount , let isLiked = data?.isLiked{
            let likeText = likeCount > 1 ? " \(likeCount) Likes" : " \(likeCount) Like"
            self.likeButton.setTitle(likeText, for: .normal)
            
            self.likeButton.tintColor = isLiked ? Config().colors.redBgColor : Config().colors.grayBackground
            
            let commentText = commentCount > 1 ? " \(commentCount) Comments" : " \(commentCount) Comment"
            self.commentButton.setTitle(commentText, for: .normal)
            
        }else {
            self.likeButton.setTitle(" Like", for: .normal)
            self.likeButton.tintColor = Config().colors.grayBackground
            self.commentButton.setTitle(" Comment", for: .normal)
        }
    }
    
    @objc func likeButtonAction() {
        self.delegate?.likeButtonAction(view: self)
    }
    
    @objc func commentButtonAction() {
        self.delegate?.commentButtonAction(view: self)
    }
    
    
}
