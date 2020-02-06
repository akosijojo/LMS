//
//  FeedViewController.swift
//  LMS
//
//  Created by Jojo Destreza on 1/9/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit
import KYDrawerController

class FeedViewController : BaseTabViewController {
    
    var data : [FeedItemData] = [] {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var expandedViewsIndex : [Int] = []
    
    let feedCell : String = "FEED CELL"
    override func setUpOnViewDidLoad() {
        collectionView.register(FeedItemCell.self, forCellWithReuseIdentifier: feedCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        setUpListener()
    }
    
    func setUpListener() {
        let poll = [FeedPollData(pollId: 1, poll: "Kinukulayan ang isipan \nPabalik sa nakaraan\nWag mo ng balikan \nPatuloy ka lang massasaktan \nHindi nagkulang kakaisip \nSa isang magandang larawan \nPaulit-ulit na binabangit \nNg pangalang nakasanayan", pollVoters: 0.3),FeedPollData(pollId: 2, poll: "Tayo ay pinagtagpo \nNgunit hindi tinadhana \nSadyang mapaglaro itong mundo ... ", pollVoters: 0.1),FeedPollData(pollId: 3, poll: "Kinalimutan kahit nahihirapan \nPara sa sariling kapakanan \nKinalimutan kahit nahihirapan \nMga oras na hindi na mababalikan", pollVoters: 0.6),FeedPollData(pollId: 4, poll: "Pinagtagpo... \nNgunit hindi tinadhana \nPuso natin ay hindi ... \nSa isa't isa", pollVoters: 0)]

        var images  = [FeedFileData(img: "Sample0",url: nil),FeedFileData(img: "Sample1",url: nil),FeedFileData(img: "Sample2",url: nil),FeedFileData(img: "Sample3",url: nil)]
        
        self.data = [FeedItemData(name: "Mojow Jow jow",img: "Sample0", post: "HEy Wassup \n , its ur boi \n Mojow aihwdiah idhaio hdioahow\n idhaowh iodahwio hadoiwhdai whdoai dhoiaho i awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnd oainwdoin aowdnoian donaowindo anwoidn oandwoin ", postAttachment: FeedFileAttachmentData(type: 1, data: [images.randomElement()!]),poll: poll, postLink: FeedWebLinkData(name: "Web Link Name", desc: "Ito ang paglalarawan ukol sa nasasaad na inpormasyon", img: "Sample3", url: ""), postVideo: nil, datePost: nil, comments: nil, likes: nil), FeedItemData(name: "Mojow",img: "Sample2", post: "HEy Wassup , its ur boi Mojow aihwdiah idhaio hdioahow idhaowh iodahwio hadoiwhdai whdoai dhoiaho 123123i \n awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnd oainwdoin aowdnoian donaowindo anwoidn oandwoin awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnd oainwdoin aowdnoian donaowindo anwoidn oandwoin awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnd oainwdoin aowdnoian donaowindo anwoidn oandwoin awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnin awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnd oainwdoin aowdnoian donaowindo anwoidn oandwoin awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnd oainwdoin aowdnoian donaowindo anwoidn oandwoin awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnd oainwdoin aowdnoian donaowindo anwoidn oandwoin ",postAttachment: FeedFileAttachmentData(type: 1, data: images),poll: [], postLink: nil, postVideo: nil, datePost: nil, comments: nil, likes: nil), FeedItemData(name: "Mojow",img: "Sample2", post: "HEy Wassup , its ur boi Mojow aihwdiah idhaio hdioahow idhaowh iodahwio hadoiwhdai whdoai dhoiaho 123123i \n awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnd oainwdoin aowdnoian donaowindo anwoidn oandwoin awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnd oainwdoin aowdnoian donaowindo anwoidn oandwoin awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnd oainwdoin aowdnoian donaowindo anwoidn oandwoin awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnin awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnd oainwdoin aowdnoian donaowindo anwoidn oandwoin awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnd oainwdoin aowdnoian donaowindo anwoidn oandwoin awihdiawhoi aowidnoiaw ndaionoia nwdoinaowi ndoaiwnd oainwdoin aowdnoian donaowindo anwoidn oandwoin ",postAttachment: FeedFileAttachmentData(type: 0, data: [FeedFileData(name: "WASSUP WASSUP",img: "Sample0",url: nil)]),poll: [], postLink: nil, postVideo: nil, datePost: nil, comments: nil, likes: nil), FeedItemData(name: "Mojow",img: "Sample3", post: " ahiwdioahwio dhaoiwh doiahwoid haowidhoi adwiha iowdhioah ioahdoha owdhoia doiahwo hdoiahwoha owidhoaiwhdoiahwoihd oiahwdoha ohdioaho awd8gawidu gaiuwgdiua gwdiuga iu \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nawdhawiud giuawdiu gauiwdguiga iuwdgiaugwi udgaugdui agiudwg iuagdwiug aiugdiag diuagwiu dgaiuwg duiagwidu gaiuwgd iaugwdiug idwgai gdiawgiu gaiwdug aigwdiuag iudgaiuwg diagdiugaiwdhaiwouoiiufuyytdfguiho awdg abo",postAttachment: FeedFileAttachmentData(type: 1, data: images.reversed()),poll: poll, postLink: nil, postVideo: nil, datePost: nil, comments: nil, likes: nil)]
//        [FeedImagesData(img: "Sample2"),FeedImagesData(img: "Sample3"),FeedImagesData(img: "Sample1"),FeedImagesData(img: "Sample0")]
    }
    
    override func setUpNavigationBar() {
        setUpTitleImage()
        //        self.tabBarController?.navigationItem.title = "Home"
        let leftBar =  UIBarButtonItem(image: UIImage(named: "menu_bar")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(showMenu))
        leftBar.tintColor = Config().colors.blueBgColor
        
        self.tabBarController?.navigationItem.leftBarButtonItem = leftBar
        
        let rightBar =  UIBarButtonItem(image: UIImage(named: "post")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(post))
        leftBar.tintColor = Config().colors.blueBgColor
        
        self.tabBarController?.navigationItem.rightBarButtonItem = rightBar
    }
    
    @objc func post() {
        let controller = PostingViewController()
        //        controller.modalTransitionStyle = .crossDissolve
        //        controller.modalPresentationStyle = .overCurrentContext
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func showSoloFeed(data: FeedItemData) {
        
        let controller = FeedSoloViewController()
        controller.data = [data]
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}


extension FeedViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedCell, for: indexPath) as? FeedItemCell else {
            return UICollectionViewCell()
        }
        
        self.setUpPostTextInCell(item: indexPath.item, cell: cell)
        
        cell.hideShowImageView(dataFile: self.data[indexPath.item].postAttachment, dataPoll: self.data[indexPath.item].pollData, isShowWebPreview: self.data[indexPath.item].postLink != nil ? true : false)
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let expanded : Bool = self.expandedViewsIndex.contains(indexPath.item)
        
        // 80 userview
        // 40 actionView
        
        var defaultHeight : CGFloat = 120
        // check if having web attachment url
        defaultHeight += self.data[indexPath.item].postLink != nil ? 130 : 0
        // check if having images or file
        defaultHeight +=  self.data[indexPath.item].postAttachment.type == 1 ? (self.data[indexPath.item].postAttachment.data.count > 0 ? self.collectionView.frame.width : 0) : 100
        
        defaultHeight += calculateHeightOfPoll(data: self.data[indexPath.item].pollData)
        
        defaultHeight += (self.data[indexPath.item].pollData.count) > 0 ? calculatePostDesc(text: "The description of poll") : 0
        
        
        // check if expanded post or not
        if let text = data[indexPath.item].post {
            let height : CGFloat = text.checkLengthAndCalculateHeight(prefix: expanded ? nil : 200 ,width: self.collectionView.frame.width - 40, font: UIFont(name: Fonts.regular, size: 16)!)
                defaultHeight = defaultHeight + height
        }
        
        print("CELL HEIGHT : \(defaultHeight)")
        return CGSize(width: collectionView.frame.width, height: defaultHeight)
    }
    
    func calculatePostDesc(text: String) -> CGFloat {
        return text.height(withConstrainedWidth: self.collectionView.frame.width - 40, font: UIFont(name: Fonts.regular, size: 16)!) + 10
    }
    
    func calculateHeightOfPoll(data : [FeedPollData]) -> CGFloat {
        var height : CGFloat = 0
        for x in data {
            height += x.poll.height(withConstrainedWidth: self.collectionView.frame.width - 40, font: UIFont(name: Fonts.regular, size: 16)!) + 30
        }
        return height //+ 10 // 10 space bottom
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DID SELECT")
        self.showSoloFeed(data: self.data[indexPath.item])
    }
    
}


extension FeedViewController : FeedItemCellAction {
    // profile Preview
    func profilePrevAction(cell: FeedItemCell, index: Int?) {
        let controller = ImagePreviewViewController(image: cell.userView.imgView.image)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(controller, animated: true, completion: nil)
    }
    
    // like comment Action
    func likeButtonAction(cell: FeedItemCell, index: Int?,view: FeedActionView) {
        print(" Liked POST")
        if let likeCount = view.data?.likeCount ,let commentCount = view.data?.commentCount,let isLiked = view.data?.isLiked {
            if isLiked {
                view.data = FeedActionData(likeCount: likeCount - 1, commentCount: commentCount, isLiked: false)
                view.onDataGet()
            }else {
                view.data = FeedActionData(likeCount: likeCount + 1, commentCount: commentCount, isLiked: true)
                view.onDataGet()
            }
        }
    }
    
    func commentButtonAction(cell: FeedItemCell, index: Int?,view: FeedActionView) {
        print(" Commenting POST")
        if let likeCount = view.data?.likeCount ,let commentCount = view.data?.commentCount,let isLiked = view.data?.isLiked {
            view.data = FeedActionData(likeCount: likeCount , commentCount: commentCount + 1, isLiked: isLiked)
            view.onDataGet()
        }
    }
    
    // option Action
    func optionAction(cell: FeedItemCell, index: Int?) {
        let alert = UIAlertController(title: "", message: "Options", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { (action) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // post text Cell Setup
    func setUpPostTextInCell(item: Int, cell: FeedItemCell) {
        
        cell.delegate = self
        cell.index = item
        cell.data = data[item]
        
        cell.width = self.collectionView.frame.width - 40
        if let text = data[item].post {
            if self.expandedViewsIndex.contains(item) {
                let height : CGFloat = text.checkLengthAndCalculateHeight(width: self.collectionView.frame.width - 40, font: UIFont(name: Fonts.regular, size: 16)!)
                cell.hideShowMore(show: true, height: height)
            }else {
                let height : CGFloat = text.checkLengthAndCalculateHeight(prefix: 200,width: self.collectionView.frame.width - 40, font: UIFont(name: Fonts.regular, size: 16)!)
                cell.hideShowMore(show: false, height: height)
            }
        }
    }
    
    func viewMoreLess(cell: FeedItemCell, index: Int?) {
        if let item = index {
            let index = self.expandedViewsIndex.index(where: { (result) -> Bool in
                return result == item
            })
            
            if index != nil {
                if let cell = self.collectionView.cellForItem(at: IndexPath(item: item, section:
                    0)) as? FeedItemCell {
                    
                    if let text = data[item].post {
                        let height : CGFloat = text.checkLengthAndCalculateHeight(prefix: 200, width: self.collectionView.frame.width - 40, font: UIFont(name: Fonts.regular, size: 16)!)
                        cell.hideShowMore(show:  false, height: height)
                    }
    
                }
                self.expandedViewsIndex.remove(at: index!)
                
            }else {
                if let cell = self.collectionView.cellForItem(at: IndexPath(item: item, section:
                    0)) as? FeedItemCell {
                    
                    if let text = data[item].post {
                        let height : CGFloat = text.checkLengthAndCalculateHeight(width: self.collectionView.frame.width - 40, font: UIFont(name: Fonts.regular, size: 16)!)
                        
                        cell.hideShowMore(show:  true, height: height)
                    }
                    
                }
                self.expandedViewsIndex.append(item)
            }
            
            
            self.collectionView.performBatchUpdates({
                //            cell.hideShowMore(show: true)
                print("RELOADING")
                self.collectionView.reloadData()
            }, completion: nil)
        }
    }
    
    
}
