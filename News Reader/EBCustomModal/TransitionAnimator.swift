//
//  TransitionAnimator.swift
//  News Reader
//
//  Created by Ennio Bovyn on 6/10/18.
//  Copyright © 2018 Ennio Bovyn. All rights reserved.
//

import UIKit

class TransitionAnimator: NSObject {
    
    enum TransitionOperation {
        case present
        case dismiss
    }
    
    private let operation: TransitionOperation
    
    init(operation: TransitionOperation) {
        self.operation = operation
        super.init()
    }
}

extension TransitionAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        let fromVC = context.viewController(forKey: .from)!
        let toVC = context.viewController(forKey: .to)!
        let container = context.containerView

//        let frame = fromVC.view.frame
//        let rightFrame = CGRect(origin: CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y), size: frame.size)
//        let leftFrame = CGRect(origin: CGPoint(x: frame.origin.x - frame.width, y: frame.origin.y), size: frame.size)
        
        switch operation {
        case .present:
            toVC.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            container.addSubview(toVC.view)
            UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
                toVC.view.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { completed in
                context.completeTransition(completed)
            })
        case .dismiss:
            container.addSubview(toVC.view)
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn], animations: {
                fromVC.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                fromVC.view.alpha = 0.0
            }, completion: { _ in
                context.completeTransition(!context.transitionWasCancelled)
            })
        }
    }
    
    private func zoomTransition() {
        
    }
    
}
