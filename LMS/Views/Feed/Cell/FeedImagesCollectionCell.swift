//
//  FeedImagesCollectionCell.swift
//  LMS
//
//  Created by Jojo Destreza on 2/5/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

class FeedImagesCollectionCell : BaseCell<[FeedFileData]> ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellImg, for: indexPath) as? FeedImagesCell else {
            return UICollectionViewCell()
        }
        cell.data = self.data?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let index = collectionView.indexPathForItem(at: scrollView.contentOffset) {
            self.collectionView.scrollToItem(at: IndexPath(row: index.row, section: 0), at: .centeredHorizontally, animated: true)
            self.pager.currentPage = index.row
        }
    }
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.backgroundColor = Config().colors.whiteBackground
        v.isPagingEnabled = true
        v.showsHorizontalScrollIndicator = false
        v.bounces = false
        return v
    }()
    
    lazy var pager : UIPageControl = {
        let v = UIPageControl()
        v.pageIndicatorTintColor = Config().colors.lightGraybackground
        v.currentPageIndicatorTintColor = Config().colors.grayBackground
        v.hidesForSinglePage = true
//        v.numberOfPages = 10
        v.isUserInteractionEnabled = false
        return v
    }()
    
    override var data: [FeedFileData]? {
        didSet {
            self.pager.numberOfPages = self.data?.count ?? 0
            self.collectionView.reloadData()
        }
    }
    
    let cellImg = "Cell Images"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedImagesCell.self, forCellWithReuseIdentifier: cellImg)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.height.equalTo(self.frame.width)
        }
        
        addSubview(pager)
        pager.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(20)
        }
        collectionView.bringSubviewToFront(pager)
    }
    
}

