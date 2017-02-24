//
//  CustomTransitions.swift
//  Garage
//
//  Created by Pau on 05/01/2017.
//  Copyright © 2017 Depop. All rights reserved.
//

import Foundation
import UIKit
import Transitions

enum TransitionType {
    case fadeIn, fadeOut
    case fromBottom, fromTop, fromLeft, fromRight
    case toBottom, toTop, toLeft, toRight
    case from(frame: CGRect, toFrame: CGRect, view: UIView), to(frame: CGRect, fromFrame: CGRect, view: UIView)
    case animatedIn(center: CGPoint, animatedView: UIView, realView: UIView), animatedOut(center: CGPoint, animatedView: UIView, realView: UIView)
    case noneIn, noneOut
}

func customTransition(for transitionType: TransitionType) -> TransitionBlock {
    switch transitionType {
    // MARK: Fade style
    case .fadeIn:
        return fadeIn()
    case .fadeOut:
        return fadeOut()
    // MARK: Slide style
    case .fromBottom:
        return fromBottom()
    case .fromTop:
        return fromTop()
    case .fromLeft:
        return fromLeft()
    case .fromRight:
        return fromRight()
    case .toBottom:
        return toBottom()
    case .toTop:
        return toTop()
    case .toLeft:
        return toLeft()
    case .toRight:
        return toRight()
    // MARK: Custom frame
    case .from(let frame, let toFrame, let view):
        return from(frame: frame, toFrame: toFrame, view: view)
    case .to(let frame, let fromFrame, let view):
        return to(frame: frame, fromFrame: fromFrame, view: view)
    // MARK: Animated view
    case .animatedIn(let center, let animatedView, let realView):
        return animatedIn(center: center, animatedView: animatedView, realView: realView)
    case .animatedOut(let center, let animatedView, let realView):
        return animatedOut(center: center, animatedView: animatedView, realView: realView)
    // MARK: Not animated
    case .noneIn:
        return noneIn()
    case .noneOut:
        return noneOut()
    }
}

// MARK: Fade style
private func fadeIn() -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.alpha = 1
        }, completion: { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

private func fadeOut() -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let containerView = transitionContext.containerView
        containerView.addSubview(fromViewController.view)
        UIView.animate(withDuration: duration, animations: {
            fromViewController.view.alpha = 0
        }, completion: { finished in
            if !transitionContext.transitionWasCancelled {
                fromViewController.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}


// MARK: Slide style
private func fromBottom() -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        containerView.addSubview(toViewController.view)
        toViewController.view.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: bounds.height)
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.frame = finalFrameForVC
        }, completion: { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

private func fromTop() -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
//        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
//        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toViewController.view)
        toViewController.view.frame = CGRect(x: 0, y: -bounds.height, width: bounds.width, height: bounds.height)
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.frame = finalFrameForVC
        }, completion: { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

private func fromLeft() -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        containerView.addSubview(toViewController.view)
        toViewController.view.frame = CGRect(x: -bounds.width, y: 0, width: bounds.width, height: bounds.height)
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.frame = finalFrameForVC
        }, completion: { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

private func fromRight() -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        containerView.addSubview(toViewController.view)
        toViewController.view.frame = CGRect(x: bounds.width, y: 0, width: bounds.width, height: bounds.height)
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.frame = finalFrameForVC
        }, completion: { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

private func toBottom() -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        let bounds = UIScreen.main.bounds
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = CGRect(x: 0, y: bounds.height, width: bounds.width, height: bounds.height)
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.frame = finalFrameForVC
        }, completion: { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

private func toTop() -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        let bounds = UIScreen.main.bounds
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = CGRect(x: 0, y: -bounds.height, width: bounds.width, height: bounds.height)
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.frame = finalFrameForVC
        }, completion: { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

private func toLeft() -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        let bounds = UIScreen.main.bounds
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = CGRect(x: -bounds.width, y: 0, width: bounds.width, height: bounds.height)
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.frame = finalFrameForVC
        }, completion: { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

private func toRight() -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        let bounds = UIScreen.main.bounds
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
//        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = CGRect(x: bounds.width, y: 0, width: bounds.width, height: bounds.height)
//        let containerView = transitionContext.containerView
//        containerView.addSubview(toViewController.view)
//        containerView.addSubview(fromViewController.view)
        UIView.animate(withDuration: duration, animations: {
            fromViewController.view.frame = finalFrameForVC
        }, completion: { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

// MARK: Custom frame
private func from(frame: CGRect, toFrame: CGRect, view: UIView) -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        
        guard let snapShot = view.snapshotView(afterScreenUpdates: false) else {
            transitionContext.completeTransition(true)
            return
        }
        
        snapShot.frame = frame
        transitionContext.containerView.addSubview(snapShot)
        
        toViewController.view.alpha = 0
        view.alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
            snapShot.frame = toFrame
            toViewController.view.alpha = 1
        }, completion: { finished in
            if !transitionContext.transitionWasCancelled {
                snapShot.removeFromSuperview()
            }
            view.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

private func to(frame: CGRect, fromFrame: CGRect, view: UIView) -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let containerView = transitionContext.containerView
        containerView.addSubview(fromViewController.view)
        
        guard let snapShot = view.snapshotView(afterScreenUpdates: false) else {
            transitionContext.completeTransition(true)
            return
        }
        
        snapShot.frame = fromFrame
        transitionContext.containerView.addSubview(snapShot)
        
        view.alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
            fromViewController.view.alpha = 0
            snapShot.frame = frame
        }, completion: { finished in
            if !transitionContext.transitionWasCancelled {
                snapShot.removeFromSuperview()
                fromViewController.view.removeFromSuperview()
            }
            view.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

// MARK: Animated view

private func animatedIn(center: CGPoint, animatedView: UIView, realView: UIView)  -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        transitionContext.containerView.addSubview(animatedView)
        
        toViewController.view.alpha = 0
        realView.alpha = 0
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions.allowUserInteraction, animations: { 
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1, animations: {
                toViewController.view.alpha = 1
            })
            
        }, completion: { (completed) in
            
            UIView.animate(withDuration: duration / 2, animations: {
                
                var transform = animatedView.transform
                transform.b = 0;
                transform.c = 0;
                animatedView.transform = transitionContext.transitionWasCancelled ? CGAffineTransform.identity : transform
                
                animatedView.center = transitionContext.transitionWasCancelled ? center : animatedView.center
                
            }, completion: { _ in
                realView.alpha = 1
                animatedView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        })
    }
}

private func animatedOut(center: CGPoint, animatedView: UIView, realView: UIView)  -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let containerView = transitionContext.containerView
        containerView.addSubview(fromViewController.view)
        transitionContext.containerView.addSubview(animatedView)
        
        animatedView.transform = CGAffineTransform.identity
        animatedView.center = fromViewController.view.center
        
        realView.alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
            fromViewController.view.alpha = 0
            animatedView.center = center
        }, completion: { _ in
            
            if !transitionContext.transitionWasCancelled {
                fromViewController.view.removeFromSuperview()
            }
            
            realView.alpha = 1
            animatedView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
        })
    }
}

// MARK: Not animated
private func noneIn() -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
}

private func noneOut() -> TransitionBlock {
    return { (transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) in
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let containerView = transitionContext.containerView
        containerView.addSubview(fromViewController.view)
        if !transitionContext.transitionWasCancelled {
            fromViewController.view.removeFromSuperview()
        }
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
}
