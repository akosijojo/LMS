//
//  ImagePreview.swift
//  LMS
//
//  Created by Jojo Destreza on 1/21/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

class ImagePreviewViewController : UIViewController {
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(Config().screenHeight - 200)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imagePrevCloseAction))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        
        
    }
    
    init(image: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        self.imageView.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func imagePrevCloseAction() {
        self.dismiss(animated: true) {
            self.imageView.image = nil
        }
    }
    
}
