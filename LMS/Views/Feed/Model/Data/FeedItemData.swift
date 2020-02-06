//
//  FeedItemData.swift
//  LMS
//
//  Created by Jojo Destreza on 1/16/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

struct FeedItemData {
    var name : String? = ""
    var img : String? = ""
    var post : String? = ""
    var postAttachment : FeedFileAttachmentData
    var pollData : [FeedPollData] = []
    var postLink : String? = ""
    var postVideo : String? = ""
    var datePost : CGFloat? = 0
    var comments : Int? = 0
    var likes : Int? = 0
    
    init(name : String? = "",img: String? = "", post : String? = "", postAttachment : FeedFileAttachmentData,poll: [FeedPollData] = [], postLink : String? = "", postVideo : String? = "", datePost : CGFloat? = 0, comments : Int? = 0, likes : Int? = 0) {
        
        self.name = name
        self.img = img
        self.post = post
        self.postAttachment = postAttachment
        self.pollData = poll
        self.postLink = postLink
        self.postVideo = postVideo
        self.datePost = datePost
        self.comments = comments
        self.likes = likes
    }
    
    
}
