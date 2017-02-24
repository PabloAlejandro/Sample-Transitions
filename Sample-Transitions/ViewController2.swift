//
//  ViewController2.swift
//  Sample-Transitions
//
//  Created by Pau on 20/02/2017.
//  Copyright © 2017 none. All rights reserved.
//

import UIKit
import Transitions

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let tabBarController = tabBarController as? TransitionTabBarController {
            let properties = TransitionProperties(duration: 0.5, modalPresentationStyle: .overFullScreen)
            let configuration = TransitionConfiguration.noninteractive(transitionProperties: properties)
            tabBarController.transitionConfiguration = configuration
        }
    }
    
    @IBAction func selectTabCustom(sender: AnyObject?) {
        if let tabBarController = tabBarController as? TransitionTabBarController {
            
            let animation = { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
                let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
                let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
                let containerView = transitionContext.containerView
                containerView.addSubview(toViewController.view)
                UIView.animate(withDuration: duration, animations: {
                    fromViewController.view.alpha = 0.0
                }, completion: { finished in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                    fromViewController.view.alpha = 1.0
                })
            }
            
            tabBarController.select(index: 2, withBlock: animation, sender: nil)
        }
    }

}
