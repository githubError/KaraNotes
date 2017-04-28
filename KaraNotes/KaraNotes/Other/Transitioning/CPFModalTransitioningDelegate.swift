//
//  CPFModalTransitioningDelegate.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/28.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFModalTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var startRect:CGRect = CGRect.zero
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let overlayControllerAnimatedTransitioning = CPFOverlayControllerAnimatedTransitioning()
        overlayControllerAnimatedTransitioning.startRect = startRect
        
        return overlayControllerAnimatedTransitioning
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let overlayControllerAnimatedTransitioning = CPFOverlayControllerAnimatedTransitioning()
        overlayControllerAnimatedTransitioning.startRect = startRect
        
        return overlayControllerAnimatedTransitioning
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return UIPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
