//
//  FeedCollectionData.swift
//  LMS
//
//  Created by Jojo Destreza on 2/4/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

class FeedCollectionData : UIView , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var section : Int = 0
        if (self.fileAttachmentData?.data.count ?? 0) > 0 {
            section += 1
        }
        if (self.pollData?.count ?? 0) > 0 {
            section += 1
        }
        return section
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            if (self.fileAttachmentData?.data.count ?? 0) > 0 {
                return 1
            }
        }
        return self.pollData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if (self.fileAttachmentData?.data.count ?? 0) > 0 {
                if self.fileAttachmentData?.type == 1 {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellImg, for: indexPath) as? FeedImagesCollectionCell else {
                        return UICollectionViewCell()
                    }
                    cell.data = self.fileAttachmentData?.data
                    return cell
                }else {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellFile, for: indexPath) as? FeedFileViewCell else {
                      return UICollectionViewCell()
                    }
                    cell.delegate = self
                    cell.data = self.fileAttachmentData?.data[0]
                    return cell
                }
            }
        }
        
        return pollSetUp(indexPath: indexPath)
    }
    
    func pollSetUp(indexPath : IndexPath) -> UICollectionViewCell {
// for voting
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellPoll, for: indexPath) as? FeedPollVotingCell else {
//            return UICollectionViewCell()
//        }
//        cell.data = self.pollData?[indexPath.item]
//        cell.delegate = self
//        return cell
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellPoll, for: indexPath) as? FeedPollCell else {
            return UICollectionViewCell()
        }
        cell.data = self.pollData?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            if (self.fileAttachmentData?.data.count ?? 0) > 0 {
                if self.fileAttachmentData?.type == 1 {
                    return CGSize(width: collectionView.frame.width , height: collectionView.frame.width)
                }else {
                    return CGSize(width: collectionView.frame.width , height: 100)
                }
            }
        }
        return CGSize(width: collectionView.frame.width , height: calculateHeightOfPoll(text : self.pollData?[indexPath.item].poll ?? "") + 30)
    }
    
    func calculateHeightOfPoll(text : String) -> CGFloat {
        return text.height(withConstrainedWidth: self.collectionView.frame.width - 40, font: UIFont(name: Fonts.regular, size: 16)!)
    }
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
//        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.backgroundColor = Config().colors.whiteBackground
        v.isPagingEnabled = true
        v.showsHorizontalScrollIndicator = false
        v.bounces = false
        return v
    }()
    
    var fileAttachmentData : FeedFileAttachmentData? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var pollData : [FeedPollData]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    let cellFile = "Cell File"
    let cellImg = "Cell Images"
    let cellPoll = "Cell Poll"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedFileViewCell.self, forCellWithReuseIdentifier: cellFile)
        collectionView.register(FeedImagesCollectionCell.self, forCellWithReuseIdentifier: cellImg)
        collectionView.register(FeedPollCell.self, forCellWithReuseIdentifier: cellPoll)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.height.equalTo(self)
        }
    }
    
}


extension FeedCollectionData : FeedFileViewCellAction {
    func filePreview(cell: FeedFileViewCell, data: FeedFileData?) {
        print("Previewing File")
    }
    
    func fileViewers(cell: FeedFileViewCell, data: FeedFileData?) {
        
    }
    
    func fileDownloads(cell: FeedFileViewCell, data: FeedFileData?) {
        
    }
}


extension FeedCollectionData : FeedPollVotingCellAction {
    func onClickVote(cell: FeedPollVotingCell, data: FeedPollData?) {
        cell.checkBox.backgroundColor = Config().colors.blueBgColor
        print("Click Voting")
    }
}

