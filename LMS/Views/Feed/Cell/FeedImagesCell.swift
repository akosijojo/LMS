//
//  FeedImagesCell.swift
//  LMS
//
//  Created by Jojo Destreza on 1/21/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

struct FeedPollImagesData {
    var feedImg : [FeedImagesData]
    var feedPoll : [FeedPollData]
}

struct FeedFileAttachmentData {
    var type : Int
    var data : [FeedFileData]
}

struct FeedFileData {
    var name : String?
    var img : String?
    var url : String?
}

struct FeedImagesData {
    var img : String?
}

class FeedImagesCell : BaseCell<FeedFileData>,UIScrollViewDelegate {
    
    override var data: FeedFileData? {
        didSet{
            self.img.image = UIImage(named: data?.img ?? "Sample1")
            self.scrollView.setZoomScale(1, animated: false)
        }
    }
    
    var didTap : Bool = false
    
    var gestureRecognizer: UITapGestureRecognizer!
    
    lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.minimumZoomScale = 1.0
        scroll.maximumZoomScale = 4.0
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.bouncesZoom = false
        return scroll
    }()
    
    lazy var img : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.masksToBounds = true
        return img
    }()
    
    override func setupView() {
        setupGestureRecognizer()
        scrollView.delegate = self
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
            make.width.equalTo(self.frame.width)
            make.height.equalTo(self.frame.height)
        }
        
        scrollView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.centerX.equalTo(scrollView)
            make.width.equalTo(self.frame.width)
            make.height.equalTo(self.frame.height)
            make.bottom.equalTo(scrollView)
        }
        
    }
    
    func setupGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        gestureRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleDoubleTap() {
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: zoomRectForScale(scrollView.maximumZoomScale, center: gestureRecognizer.location(in: gestureRecognizer.view)), animated: true)
            didTap = true
        } else {
            didTap = false
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = img.frame.size.height / scale
        zoomRect.size.width = img.frame.size.width / scale
        let newCenter = convert(center, from: img)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.img
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if !didTap {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
}
