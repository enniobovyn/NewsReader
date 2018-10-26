//
//  CustomModalViewController.swift
//  News Reader
//
//  Created by Ennio Bovyn on 6/10/18.
//  Copyright © 2018 Ennio Bovyn. All rights reserved.
//

import UIKit

class CustomModalViewController: UIViewController {
    @IBOutlet weak var modalView: UIVisualEffectView!
    
    init() {
        super.init(nibName: "CustomModalViewController", bundle: nil)
        
        transitioningDelegate = self
        modalPresentationStyle = .custom
//        preferredContentSize = CGSize(width: 260, height: 220)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalView.layer.cornerRadius = 10
        modalView.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }

}

extension CustomModalViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator(operation: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator(operation: .dismiss)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}
