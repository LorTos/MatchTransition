//
//  MatchTransition.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 11/10/2018.
//

import UIKit

protocol MatchTransitionDelegate: class {
    func setFinalState(forObjectsInView view: UIView)
}

class MatchTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var transitionDuration: Double = 0.5
    var isPresenting = true
    
    weak var delegate: MatchTransitionDelegate!
    
    // Vibrancy View
    private var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    // Objects to move around to create transition
    private var transitioningImages: [TransitioningImageView] = []
    private var transitioningViews: [TransitioningView] = []
    private var transitioningLabels: [TransitioningLabel] = []
    private var transitioningButtons: [TransitioningButton] = []
    
    func setTransitioningObjects(views: [TransitioningView], imageViews: [TransitioningImageView], labels: [TransitioningLabel], buttons: [TransitioningButton]) {
        transitioningViews = views
        transitioningImages = imageViews
        transitioningLabels = labels
        transitioningButtons = buttons
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        // Initial and final view
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        let initialView = isPresenting ? fromView : transitionContext.view(forKey: .to)!
        let detailsView = isPresenting ? toView : transitionContext.view(forKey: .from)!
        
        if isPresenting {
            detailsView.alpha = 0
            containerView.addSubview(detailsView)
            
            // Set final states for detailsView views
            delegate.setFinalState(forObjectsInView: detailsView)
            
            // Setup presentation for isPresenting
            setupPresentingAnimation(containerView)
            
            // Start presentingAnimation
            presentingAnimation(transitionContext, detailsView, fromView: fromView, toView: toView, containerView: containerView)
        } else {
            // Setup presentation for dismissal
            setupDismissalAnimation(containerView)
            detailsView.removeFromSuperview()
            containerView.addSubview(initialView)
            containerView.sendSubviewToBack(initialView)
            initialView.alpha = 1
            // Start dismissalAnimation
            dismissalAnimation(transitionContext)
        }
    }
    
    // MARK: - Presenting Animation
    private func setupPresentingAnimation(_ containerView: UIView) {
        blurView.effect = nil
        containerView.addSubview(blurView)
        if let container = transitioningViews.first(where: { $0.isBaseContainer }) {
            container.frame = container.initialFrame
            container.backgroundColor = container.initialBackgroundColor
            if container.initialCornerRadius != 0 || container.finalCornerRadius != 0  {
                roundCorners(of: container, from: isPresenting ? container.initialCornerRadius : container.finalCornerRadius, to: !isPresenting ? container.initialCornerRadius : container.finalCornerRadius)
            }
            
            transitioningViews.filter({ !$0.isBaseContainer }).forEach { view in
                view.frame = view.initialFrame
                view.backgroundColor = view.initialBackgroundColor
                if view.initialCornerRadius != 0 || view.finalCornerRadius != 0 {
                    roundCorners(of: view, from: isPresenting ? view.initialCornerRadius : view.finalCornerRadius, to: !isPresenting ? view.initialCornerRadius : view.finalCornerRadius)
                }
                container.addSubview(view)
            }
            
            transitioningImages.forEach { imageView in
                imageView.frame = imageView.initialFrame
                if imageView.initialCornerRadius != 0 || imageView.finalCornerRadius != 0 {
                    roundCorners(of: imageView, from: isPresenting ? imageView.initialCornerRadius : imageView.finalCornerRadius, to: !isPresenting ? imageView.initialCornerRadius : imageView.finalCornerRadius)
                }
                container.addSubview(imageView)
            }
            
            
            transitioningLabels.forEach { label in
                label.frame = label.initialFrame
                label.font = label.initialFont
                label.textColor = label.initialTextColor
                container.addSubview(label)
            }
            
            transitioningButtons.forEach { button in
                button.frame = button.initialFrame
                button.titleLabel?.textColor = button.initialTextColor
                button.titleLabel?.font = button.initialTextFont
                button.backgroundColor = button.initialBackgroundColor
                if button.initialCornerRadius != 0 || button.finalCornerRadius != 0 {
                    roundCorners(of: button, from: isPresenting ? button.initialCornerRadius : button.finalCornerRadius, to: !isPresenting ? button.initialCornerRadius : button.finalCornerRadius)
                }
                container.addSubview(button)
            }
            
            containerView.addSubview(container)
        }
    }
    private func presentingAnimation(_ transitionContext: UIViewControllerContextTransitioning, _ detailsView: UIView, fromView: UIView, toView: UIView, containerView: UIView) {
        UIView.animate(withDuration: 0.1) {
            self.blurView.effect = UIBlurEffect(style: .light)
        }
        
        containerView.bringSubviewToFront(toView)
        UIView.animate(withDuration: 0.2, delay: transitionDuration, options: .curveEaseInOut, animations: {
            detailsView.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: transitionDuration, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.transitioningViews.forEach({ view in
                view.frame = view.finalFrame
                view.backgroundColor = view.finalBackgroundColor
            })
            self.transitioningImages.forEach({ imageView in
                imageView.frame = imageView.finalFrame
            })
            self.transitioningLabels.forEach({ label in
                label.frame = label.finalFrame
                label.font = label.finalFont
                if let finalColor = label.finalTextColor {
                    label.textColor = finalColor
                }
            })
            self.transitioningButtons.forEach({ button in
                button.frame = button.finalFrame
                button.titleLabel?.font = button.finalTextFont
                button.titleLabel?.textColor = button.finalTextColor
                button.backgroundColor = button.finalBackgroundColor
            })
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionContext.containerView.subviews.forEach({ $0.removeFromSuperview() })
        }
    }
    
    // MARK: - Dismissal Animation
    private func setupDismissalAnimation(_ containerView: UIView) {
        blurView.effect = UIBlurEffect(style: .light)
        if let container = transitioningViews.first(where: { $0.isBaseContainer }) {
            container.frame = container.finalFrame
            container.backgroundColor = container.finalBackgroundColor
            if container.initialCornerRadius != 0 || container.finalCornerRadius != 0  {
                roundCorners(of: container, from: isPresenting ? container.initialCornerRadius : container.finalCornerRadius, to: !isPresenting ? container.initialCornerRadius : container.finalCornerRadius)
            }
            
            transitioningViews.filter({ !$0.isBaseContainer }).forEach { view in
                view.frame = view.finalFrame
                view.backgroundColor = view.finalBackgroundColor
                if view.initialCornerRadius != 0 || view.finalCornerRadius != 0 {
                    roundCorners(of: view, from: isPresenting ? view.initialCornerRadius : view.finalCornerRadius, to: !isPresenting ? view.initialCornerRadius : view.finalCornerRadius)
                }
                container.addSubview(view)
            }
            
            transitioningImages.forEach { imageView in
                imageView.frame = imageView.finalFrame
                if imageView.initialCornerRadius != 0 || imageView.finalCornerRadius != 0 {
                    roundCorners(of: imageView, from: isPresenting ? imageView.initialCornerRadius : imageView.finalCornerRadius, to: !isPresenting ? imageView.initialCornerRadius : imageView.finalCornerRadius)
                }
                container.addSubview(imageView)
            }
            
            transitioningLabels.forEach { label in
                label.frame = label.finalFrame
                label.font = label.finalFont
                label.textColor = label.finalTextColor
                container.addSubview(label)
            }
            
            transitioningButtons.forEach { button in
                button.frame = button.finalFrame
                button.titleLabel?.textColor = button.finalTextColor
                button.titleLabel?.font = button.finalTextFont
                button.backgroundColor = button.finalBackgroundColor
                if button.initialCornerRadius != 0 || button.finalCornerRadius != 0 {
                    roundCorners(of: button, from: isPresenting ? button.initialCornerRadius : button.finalCornerRadius, to: !isPresenting ? button.initialCornerRadius : button.finalCornerRadius)
                }
                container.addSubview(button)
            }
            
            containerView.addSubview(container)
        }
    }
    private func dismissalAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        UIView.animate(withDuration: transitionDuration) {
            self.blurView.effect = nil
        }
        UIView.animate(withDuration: 0.25, delay: transitionDuration, options: .curveEaseInOut, animations: {
            self.transitioningViews.forEach({ $0.alpha = 0 })
            self.transitioningImages.forEach({ $0.alpha = 0 })
            self.transitioningLabels.forEach({ $0.alpha = 0 })
            self.transitioningButtons.forEach({ $0.alpha = 0 })
        })
        UIView.animate(withDuration: transitionDuration, delay: 0, usingSpringWithDamping: 0.95, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.transitioningViews.forEach({ view in
                view.frame = view.initialFrame
                view.backgroundColor = view.initialBackgroundColor
            })
            self.transitioningImages.forEach({ imageView in
                imageView.frame = imageView.initialFrame
            })
            self.transitioningLabels.forEach({ label in
                guard let initialFrame = label.initialFrame else {return}
                label.frame = initialFrame
                label.font = label.initialFont
                if let initialColor = label.initialTextColor {
                    label.textColor = initialColor
                }
            })
            self.transitioningButtons.forEach({ button in
                button.frame = button.initialFrame
                button.titleLabel?.font = button.initialTextFont
                button.titleLabel?.textColor = button.initialTextColor
                button.backgroundColor = button.initialBackgroundColor
            })
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
            self.transitioningViews = []
            self.transitioningImages = []
            self.transitioningLabels = []
            self.transitioningButtons = []
            
            transitionContext.containerView.subviews.forEach({ $0.removeFromSuperview() })
        }
    }
    
    // MARK: - RoundCorners
    private func roundCorners(of view: UIView, from initialCornerRadius: CGFloat, to finalCornerRadius: CGFloat) {
        let roundCorners = CABasicAnimation(keyPath: "cornerRadius")
        roundCorners.fromValue = initialCornerRadius
        roundCorners.toValue = finalCornerRadius
        roundCorners.duration = transitionDuration - 0.15
        
        view.layer.add(roundCorners, forKey: nil)
    }
}
