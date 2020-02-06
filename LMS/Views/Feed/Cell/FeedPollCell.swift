//
//  FeedPollCell.swift
//  LMS
//
//  Created by Jojo Destreza on 2/5/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit
struct FeedPollData {
    var pollId : Int
    var poll : String
    var pollVoters : CGFloat
}

class FeedPollCell : BaseCell<FeedPollData> {
    
    override var data: FeedPollData? {
        didSet{
            self.poll.text = self.data?.poll ?? ""
            self.progress.progress = Float(self.data?.pollVoters ?? 0)
        }
    }
    
    var didTap : Bool = false
    
    var gestureRecognizer: UITapGestureRecognizer!
    
    lazy var poll : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.regular, size: 16)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var progress : UIProgressView = {
        let v = UIProgressView()
        v.progressTintColor = Config().colors.blueBgColor
        v.trackTintColor = Config().colors.whiteBackground
        v.layer.masksToBounds = true
        v.layer.borderColor = Config().colors.lightGraybackground.cgColor
        v.layer.borderWidth = 1
        return v
    }()
    
    lazy var checkBox : UILabel = {
        let lbl = UILabel()
        lbl.layer.masksToBounds = true
        lbl.layer.borderColor = Config().colors.mediumGrayBackground.cgColor
        lbl.layer.borderWidth = 1
        lbl.backgroundColor = Config().colors.lightGraybackground
        return lbl
    }()
    
    
    override func setupView() {
        addSubview(progress)
        progress.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.leading.equalTo(self).offset(20)
           make.trailing.equalTo(self).offset(-20)
           make.height.equalTo(10)
        }

        progress.layer.cornerRadius = 5

        addSubview(poll)
        poll.snp.makeConstraints { (make) in
           make.top.equalTo(self).offset(10)
           make.leading.equalTo(self).offset(20)
           make.trailing.equalTo(self).offset(-20)
           make.bottom.equalTo(progress.snp.top).offset(-10)
        }
    }
    
 
}

protocol FeedPollVotingCellAction : class {
    func onClickVote(cell:FeedPollVotingCell,data: FeedPollData?)
}

class FeedPollVotingCell : BaseCell<FeedPollData> {
    
    override var data: FeedPollData? {
        didSet{
            self.poll.text = self.data?.poll ?? ""
            self.progress.progress = Float(self.data?.pollVoters ?? 0)
        }
    }
    
    var delegate : FeedPollVotingCellAction?
    
    var didTap : Bool = false
    
    var gestureRecognizer: UITapGestureRecognizer!
    
    lazy var poll : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.regular, size: 16)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var progress : UIProgressView = {
        let v = UIProgressView()
        v.progressTintColor = Config().colors.blueBgColor
        v.trackTintColor = Config().colors.whiteBackground
        v.layer.masksToBounds = true
        v.layer.borderColor = Config().colors.lightGraybackground.cgColor
        v.layer.borderWidth = 1
        return v
    }()
    
    lazy var checkBox : UILabel = {
        let lbl = UILabel()
        lbl.layer.masksToBounds = true
        lbl.layer.borderColor = Config().colors.mediumGrayBackground.cgColor
        lbl.layer.borderWidth = 1
        lbl.backgroundColor = Config().colors.lightGraybackground
        return lbl
    }()
    
    
    override func setupView() {
        progress.removeFromSuperview()
        addSubview(checkBox)
        checkBox.snp.makeConstraints { (make) in
           make.centerY.equalTo(self)
           make.trailing.equalTo(self).offset(-20)
           make.width.height.equalTo(20)
        }

        addSubview(poll)
        poll.snp.makeConstraints { (make) in
           make.top.equalTo(self).offset(10)
           make.leading.equalTo(self).offset(20)
           make.trailing.equalTo(checkBox.snp.leading).offset(-10)
           make.bottom.equalTo(self).offset(-10)
        }
        
        checkBox.layer.cornerRadius = 10
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickVoteAction))
        checkBox.isUserInteractionEnabled = true
        checkBox.addGestureRecognizer(tap)
           
    }
    
    @objc func onClickVoteAction() {
        self.delegate?.onClickVote(cell: self, data: self.data)
    }
    
}





