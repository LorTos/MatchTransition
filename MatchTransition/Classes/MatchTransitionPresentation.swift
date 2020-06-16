//
//  MatchTransitionPresentation.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 08/12/2018.
//

import UIKit

class MatchTransitionPresentation: NSObject, UIViewControllerAnimatedTransitioning {
    private var transitionDuration: Double = 0.5
    
    weak var delegate: MatchTransitionDelegate!
    
    // Vibrancy View
    private var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    // MARK: - Transitioning Objects
    // Objects to move around to create transition
    private var transitioningImages: [MatchImageView] = []
    private var transitioningViews: [MatchView] = []
    private var transitioningLabels: [MatchLabel] = []
    private var transitioningButtons: [MatchButton] = []
    
    func setTransitioningObjects(views: [MatchView], imageViews: [MatchImageView], labels: [MatchLabel], buttons: [MatchButton]) {
        transitioningViews = views
        transitioningImages = imageViews
        transitioningLabels = labels
        transitioningButtons = buttons
    }
    
    //MARK: -
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard   let toView = transitionContext.view(forKey: .to),
                let fromView = transitionContext.view(forKey: .from) else
        {
            transitionContext.completeTransition(false)
            return
        }
        toView.alpha = 0
        containerView.addSubview(toView)

        delegate.setFinalStateForObjects(in: toView, direction: .presenting)
        setupPresentingAnimation(containerView)
        presentingAnimation(transitionContext, fromView: fromView, toView: toView)
    }
        
    // MARK: - Setup
    private func setupPresentingAnimation(_ containerView: UIView) {
        blurView.effect = nil
        containerView.addSubview(blurView)
        if let container = transitioningViews.first(where: { $0.isBaseContainer }) {
            container.frame = container.initialFrame
            container.backgroundColor = container.initialBackgroundColor
            
            transitioningViews.filter({ !$0.isBaseContainer }).forEach { view in
                view.frame = view.initialFrame
                view.backgroundColor = view.initialBackgroundColor
                container.addSubview(view)
            }
            
            transitioningImages.forEach { imageView in
                imageView.frame = imageView.initialFrame
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
                button.titleLabel?.font = button.initialFont
                button.backgroundColor = button.initialBackgroundColor
                container.addSubview(button)
            }
            
            containerView.addSubview(container)
        }
    }
    
    // Mark: - Animation
    private func presentingAnimation(_ transitionContext: UIViewControllerContextTransitioning, fromView: UIView, toView: UIView) {
        let containerView = transitionContext.containerView
        containerView.bringSubviewToFront(toView)
        
        UIView.animate(withDuration: 0.1) {
            self.blurView.effect = UIBlurEffect(style: .light)
        }
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
                button.titleLabel?.font = button.finalFont
                button.titleLabel?.textColor = button.finalTextColor
                button.backgroundColor = button.finalBackgroundColor
            })
        }, completion: nil)
        UIView.animate(withDuration: 0.2, delay: transitionDuration, options: .curveEaseInOut, animations: {
            toView.alpha = 1
        }, completion: { _ in
            self.transitioningViews.forEach({ $0.removeFromSuperview() })
            self.transitioningImages.forEach({ $0.removeFromSuperview() })
            self.transitioningButtons.forEach({ $0.removeFromSuperview() })
            self.transitioningLabels.forEach({ $0.removeFromSuperview() })
            self.blurView.removeFromSuperview()
            self.transitioningViews = []
            self.transitioningImages = []
            self.transitioningLabels = []
            self.transitioningButtons = []
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
