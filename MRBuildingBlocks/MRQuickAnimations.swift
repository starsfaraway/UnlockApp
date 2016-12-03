//
//  MRQuickAnimations.swift
//  
//
//  Created by Matthew Riley on 11/18/16.
//  Copyright © 2016 MR. All rights reserved.
//

import UIKit

class MRQuickAnimations: NSObject {
    
    class func shakeHorizontalAnimation(view : UIView, completionHandler: @escaping ((Bool) -> ())) {
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, options: UIViewKeyframeAnimationOptions.layoutSubviews, animations: {
            let textFieldFrame = view.frame
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1, animations: {
                let leftFrame = CGRect(x:textFieldFrame.origin.x - 80, y:textFieldFrame.origin.y, width:textFieldFrame.size.width, height:textFieldFrame.size.height)
                view.frame = leftFrame
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.1, animations: {
                let rightFrame = CGRect(x:textFieldFrame.origin.x + 160, y:textFieldFrame.origin.y, width:textFieldFrame.size.width, height:textFieldFrame.size.height)
                view.frame = rightFrame
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1, animations: {
                view.frame = textFieldFrame
            })
            
        }, completion: { (true) in
            completionHandler(true)
        })
    }

}
