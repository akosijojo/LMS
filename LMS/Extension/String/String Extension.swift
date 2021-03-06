//
//  String Extension.swift
//  LMS
//
//  Created by Jojo Destreza on 1/21/20.
//  Copyright © 2020 Jojo Destreza. All rights reserved.
//

import UIKit

extension String {
    func checkLengthAndCalculateHeight(prefix: Int? = nil,width: CGFloat,font: UIFont) -> CGFloat {
        if self.count > 0 {
            var replaceText = self.replacingOccurrences(of: "i", with: "a")
            if let pref = prefix {
                if self.count >= pref {
                    let text = "\(replaceText)... Read more"
                    return String(describing: text.prefix(pref)).height(withConstrainedWidth: width, font: font) + 20
                }
            }
            
            let text = "\(replaceText) Read less"
            return text.height(withConstrainedWidth: width, font: font) + 20
        }
        
        return 0
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
}


