//
//  BaseCell.swift
//  LMS
//
//  Created by Jojo Destreza on 01/09/20.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

class BaseCell<T> : UICollectionViewCell {
    
    var data : T?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
    }
    
    
}
