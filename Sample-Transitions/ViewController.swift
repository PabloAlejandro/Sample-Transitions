//
//  ViewController.swift
//  Transitions
//
//  Created by Pau on 17/02/2017.
//  Copyright © 2017 nona. All rights reserved.
//

import UIKit
import Transitions

private let viewTransitionIdentifier: String = "viewTransitionIdentifier"
private let navigationTransitionIdentifier: String = "navigationTransitionIdentifier"

class ViewController: TransitionViewController {
    
    override var navigationController: TransitionNavigationController? {
        return super.navigationController as? TransitionNavigationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let properties = TransitionProperties(duration: 0.5, modalPresentationStyle: .overFullScreen)
        let configuration = TransitionConfiguration.noninteractive(transitionProperties: properties)
        self.transitionConfiguration = configuration
        self.navigationController?.transitionConfiguration = configuration
    }
    
    // MARK: View controller
    
    @IBAction func presentNative(sender: AnyObject?) {
        let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "viewTransitionIdentifier") as! ViewController
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func presentCustom(sender: AnyObject?) {
        let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "viewTransitionIdentifier") as! ViewController
        present(viewController, presentBlock: customTransition(for: .fromTop))
    }
    
    @IBAction func dismissNative(sender: AnyObject?) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissCustom(sender: AnyObject?) {
        dismiss(dismissBlock: customTransition(for: .toRight))
    }
    
    // MARK: Navigation controller
    
    @IBAction func pushNative(sender: AnyObject?) {
        let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "navigationTransitionIdentifier") as! ViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func pushCustom(sender: AnyObject?) {
        let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "navigationTransitionIdentifier") as! ViewController
        
        let pushBlock = { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            let containerView = transitionContext.containerView
            toViewController.view.alpha = 0.0
            containerView.addSubview(toViewController.view)
            UIView.animate(withDuration: duration, animations: {
                toViewController.view.alpha = 1.0
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        
        navigationController?.pushViewController(viewController, withBlock: pushBlock)
    }
    
    @IBAction func popNative(sender: AnyObject?) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func popCustom(sender: AnyObject?) {
        let popBlock = { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            let containerView = transitionContext.containerView
            containerView.addSubview(toViewController.view)
            containerView.addSubview(fromViewController.view)
            UIView.animate(withDuration: duration, animations: {
                fromViewController.view.alpha = 0.0
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        
        let _ = navigationController?.popViewController(withBlock: popBlock)
    }
}

