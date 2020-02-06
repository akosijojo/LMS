//
//  FeedItemCell.swift
//  LMS
//
//  Created by Jojo Destreza on 1/16/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

protocol FeedItemCellAction : class {
    func profilePrevAction(cell: FeedItemCell,index: Int?)
    func optionAction(cell: FeedItemCell,index: Int?)
    func viewMoreLess(cell: FeedItemCell,index: Int?)
    func likeButtonAction(cell: FeedItemCell,index: Int?,view: FeedActionView)
    func commentButtonAction(cell: FeedItemCell,index: Int?,view: FeedActionView)
}

class FeedItemCell : BaseCell<FeedItemData> , UITextViewDelegate , FeedActionViewDelegate {

    override var data: FeedItemData? {
        didSet{
            self.userView.label.text = "\(data?.name ?? "") "
            self.userView.desc.text = "January 17, 2020"
            print("IMAGES PROFILE : \(data?.img)")
            self.userView.imgView.image = UIImage(named: data?.img ?? "Sample0")
            self.pollAndImageView.fileAttachmentData = self.data?.postAttachment
            self.pollAndImageView.pollData = self.data?.pollData
            
            self.webAttachmentView.data = self.data?.postLink
           
            if let post =  data?.post {
                self.setUpPostText(post: post, extended: expanded)
                self.calculateTextHeight(text: post)
            }
    
        }
    }
    
    var expanded : Bool = false
    
    var width : CGFloat = 0
    var delegate : FeedItemCellAction?
    var index : Int? = nil
    
    lazy var userView : CustomImageLeftWithTitleAndDesc = {
        let v = CustomImageLeftWithTitleAndDesc()
        v.label.font = UIFont(name: Fonts.bold, size: 16)
        v.label.textColor = Config().colors.textColorDark
        v.desc.font = UIFont(name: Fonts.regular, size: 16)
        v.desc.textColor = Config().colors.textColorLight
        return v
    }()
    
    lazy var post : UITextView = {
        let v = UITextView()
        v.font = UIFont(name: Fonts.regular, size: 16)
        v.textColor = Config().colors.textColorDark
        v.isEditable = false
        v.isSelectable = true
//        v.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 10)
        v.isScrollEnabled = false
        return v
    }()
    
    lazy var webAttachmentView : FeedWebView = {
        let v = FeedWebView()
        return v
    }()
    
    lazy var pollAndImageView : FeedCollectionData = {
       let v = FeedCollectionData()
       return v
    }()
    
    lazy var postDesc : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Fonts.regular, size: 16)
        lbl.text = "The description of poll"
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.4
        lbl.textAlignment = .right
        lbl.textColor = Config().colors.redBgColor
        return lbl
    }()
    
    lazy var actionView : FeedActionView = {
        let v = FeedActionView()
//        v.text = "   100 Likes            10 Comment"
//        v.textColor = Config().colors.textColorDark
//        v.font = UIFont(name: Fonts.medium, size: 16)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.post.delegate = self
        self.actionView.delegate = self
        self.actionView.data  = FeedActionData(likeCount: 100, commentCount: 200,isLiked: false)
        self.actionView.onDataGet()
        
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        self.backgroundColor = Config().colors.whiteBackground
        addSubview(userView)
        userView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(80)
        }
        
        addSubview(post)
        post.snp.makeConstraints { (make) in
            make.top.equalTo(userView.snp.bottom).offset(0)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(0)
        }
        
        addSubview(webAttachmentView)
        webAttachmentView.snp.makeConstraints { (make) in
            make.top.equalTo(post.snp.bottom)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(120)
        }
               
        addSubview(pollAndImageView)
        pollAndImageView.snp.makeConstraints { (make) in
            make.top.equalTo(post.snp.bottom)
           make.leading.equalTo(self)
           make.trailing.equalTo(self)
           make.height.equalTo(0)
        }
        
        addSubview(postDesc)
        postDesc.snp.makeConstraints { (make) in
           make.top.equalTo(pollAndImageView.snp.bottom)
           make.leading.equalTo(self)
           make.trailing.equalTo(self)
           make.height.equalTo(0)
        }
//
        addSubview(actionView)
        actionView.snp.makeConstraints { (make) in
            make.top.equalTo(postDesc.snp.bottom)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(40)
        }
        
        setUpOptionAction()
        
        let imagePrev = UITapGestureRecognizer(target: self, action: #selector(imagePreview))
        userView.imgView.isUserInteractionEnabled = true
        userView.imgView.addGestureRecognizer(imagePrev)
    }
    
    func setUpOptionAction() {
        let optionTap = UITapGestureRecognizer(target: self, action: #selector(optionTapAction(_:)))
        userView.imgViewAction.isUserInteractionEnabled = true
        userView.imgViewAction.addGestureRecognizer(optionTap)
    }
    
    @objc func optionTapAction(_ sender: UIGestureRecognizer) {
        self.delegate?.optionAction(cell: self, index: index)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print("Clicking Read More / Read Less")
        self.delegate?.viewMoreLess(cell: self, index: index)
        return false
    }

    func likeButtonAction(view: FeedActionView) {
        self.delegate?.likeButtonAction(cell: self, index: index, view: view)
    }
    
    func commentButtonAction(view: FeedActionView) {
        self.delegate?.commentButtonAction(cell: self, index: index, view: view)
    }
    
    @objc func imagePreview() {
        self.delegate?.profilePrevAction(cell: self, index: index)
    }
    
}

// Image Collection and Poll Collection Action
extension FeedItemCell {
    func hideShowImageView(dataFile: FeedFileAttachmentData?,dataPoll : [FeedPollData] = [],isShowWebPreview : Bool) {
        if isShowWebPreview {
            webAttachmentView.isHidden = false
        }else {
            webAttachmentView.isHidden = true
        }
        
        if (dataFile?.data.count ?? 0) > 0 || dataPoll.count > 0  {
            var collectionHeight : CGFloat = 0
            collectionHeight = dataFile?.type == 1 ? ((dataFile?.data.count ?? 0) > 0 ? self.frame.width : 0) : 100
            collectionHeight += calculateHeightOfPoll(data: dataPoll)
            
            self.pollAndImageView.snp.remakeConstraints { (make) in
                if isShowWebPreview {
                    make.top.equalTo(webAttachmentView.snp.bottom).offset(isShowWebPreview ? 10 : 0)
                }else {
                    make.top.equalTo(post.snp.bottom)
                }
                make.leading.equalTo(self)
                make.trailing.equalTo(self)
                make.height.equalTo(collectionHeight)
            }
            
            if (self.data?.pollData.count ?? 0) > 0 {
                self.setUpDesc(text: "The description of poll")
            }else {
                self.setUpDesc(text: "")
            }
                       
        }else {
            self.pollAndImageView.snp.remakeConstraints { (make) in
                if isShowWebPreview {
                    make.top.equalTo(webAttachmentView.snp.bottom).offset(isShowWebPreview ? 10 : 0)
                }else {
                    make.top.equalTo(post.snp.bottom)
                }
                make.leading.equalTo(self)
                make.trailing.equalTo(self)
                make.height.equalTo(0)
            }
            self.setUpDesc(text: "")
        }
      
    }
    
    
    func calculateHeightOfPoll(data : [FeedPollData]) -> CGFloat {
        var height : CGFloat = 0
        for x in data {
            height += x.poll.height(withConstrainedWidth: self.frame.width - 40, font: UIFont(name: Fonts.regular, size: 16)!) + 30
        }
        return height 
    }
    
    func setUpDesc(text: String) {
        if text != "" {
            let height = text.height(withConstrainedWidth: self.frame.width - 40, font: UIFont(name: Fonts.regular, size: 16)!)
            self.postDesc.snp.remakeConstraints { (make) in
                make.top.equalTo(pollAndImageView.snp.bottom).offset(10)
                make.leading.equalTo(self).offset(20)
                make.trailing.equalTo(self).offset(-20)
                make.height.equalTo(height)
            }
        }else {
            self.postDesc.snp.remakeConstraints { (make) in
                  make.top.equalTo(pollAndImageView.snp.bottom)
                  make.leading.equalTo(self)
                  make.trailing.equalTo(self)
                  make.height.equalTo(0)
              }
        }
        
    }
    
}

// Post Text Action
extension FeedItemCell {
    func calculateTextHeight(text: String) {
        let height : CGFloat = text.checkLengthAndCalculateHeight(prefix: expanded ? nil : 200, width: width, font: UIFont(name: Fonts.regular, size: 16)!)
        
        self.post.snp.updateConstraints { (make) in
            make.height.equalTo(height != 0 ? height: height)
        }
    }
    
    func setUpPostText(post: String,extended: Bool) {
        let trimmedPost : String = extended ? post : (post.count < 200 ? post : String("\(post.prefix(200))..."))
        let text = NSMutableAttributedString(string: trimmedPost + " ")
        text.addAttribute(NSAttributedString.Key.font, value: UIFont(name: Fonts.regular, size: 16)!, range: NSMakeRange(0, text.length))
        text.addAttribute(NSAttributedString.Key.foregroundColor, value: Config().colors.textColorDark, range: NSMakeRange(0, text.length))
        
        if post.count >= 200 {
            let addedText = extended ? "Read less" : "Read more"
            let selectablePart = NSMutableAttributedString(string: addedText)
            selectablePart.addAttribute(NSAttributedString.Key.font, value: UIFont(name: Fonts.bold, size: 16)!, range: NSMakeRange(0, selectablePart.length))
            
            selectablePart.addAttribute(NSAttributedString.Key.foregroundColor, value: Config().colors.blueBgColor , range: NSMakeRange(0,selectablePart.length))
            
            selectablePart.addAttribute(NSAttributedString.Key.link, value: "more", range: NSMakeRange(0,selectablePart.length))
            text.append(selectablePart)
        }
        self.post.attributedText = text
    }
    
    func hideShowMore(show: Bool,height: CGFloat) {
        if let post = data?.post {
            self.setUpPostText(post: post, extended: show)
            UIView.animate(withDuration: 1.0) {
                self.post.snp.remakeConstraints { (make) in
                    make.top.equalTo(self.userView.snp.bottom).offset(0)
                    make.leading.equalTo(self).offset(20)
                    make.trailing.equalTo(self).offset(-20)
                    make.height.equalTo(height != 0 ? height : height)
                }
            }
            self.expanded = show
        }
    }
   
}

extension UITextView {
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
