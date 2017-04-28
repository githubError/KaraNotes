//
//  CPFOverlayControllerAnimatedTransitioning.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/28.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFOverlayControllerAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    var startRect:CGRect = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else {
            fatalError("转场上下文获取失败")
        }
        
        let fromView = fromVC.view
        let toView = toVC.view
        let duration = transitionDuration(using: transitionContext)
        
        if toVC.isBeingPresented {
            containerView.addSubview(toView!)
            toView?.frame = startRect
            UIView.animate(withDuration: duration, animations: {
                toView?.frame = CGRect(x: 0, y: 0, width: CPFScreenW, height: CPFScreenH)
            }, completion: { (_) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        
        if fromVC.isBeingDismissed {
            UIView.animate(withDuration: duration, animations: { 
                fromView?.frame = self.startRect
            }, completion: { (_) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}
