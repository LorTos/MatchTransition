//
//  MatchTransitionDismissal.swift
//  MatchTransition
//
//  Created by Lorenzo Toscani De Col on 08/12/2018.
//

import UIKit

class MatchTransitionDismissal: NSObject, UIViewControllerAnimatedTransitioning {
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
        
        delegate.setFinalStateForObjects(in: fromView, direction: .dismissing)
        setupDismissalAnimation(containerView)
        fromView.removeFromSuperview()
        containerView.insertSubview(toView, at: 0)
        toView.alpha = 1
        
        dismissalAnimation(transitionContext)
    }
    
    // MARK: - Setup
    private func setupDismissalAnimation(_ containerView: UIView) {
        if let container = transitioningViews.first(where: { $0.isBaseContainer }) {
            container.frame = container.finalFrame
            container.backgroundColor = container.finalBackgroundColor

            transitioningViews.forEach({
                if !$0.isBaseContainer {
                    $0.frame = $0.finalFrame
                    $0.backgroundColor = $0.finalBackgroundColor
                    container.addSubview($0)
                }
            })

            transitioningImages.forEach { imageView in
                imageView.frame = imageView.finalFrame
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
                button.titleLabel?.font = button.finalFont
                button.backgroundColor = button.finalBackgroundColor
                container.addSubview(button)
            }

            containerView.addSubview(container)
        }
    }
    
    // MARK: - Animation
    private func dismissalAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        UIView.animate(withDuration: transitionDuration) {
            self.blurView.effect = nil
        }
        UIView.animate(withDuration: transitionDuration, delay: 0, usingSpringWithDamping: 0.95, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.transitioningViews.forEach({ view in
                view.frame = view.initialFrame
                view.backgroundColor = view.initialBackgroundColor
            })
            self.transitioningImages.forEach({ imageView in
                imageView.frame = imageView.initialFrame
            })
            self.transitioningLabels.forEach({ label in
                label.frame = label.initialFrame
                label.font = label.initialFont
                if let initialColor = label.initialTextColor {
                    label.textColor = initialColor
                }
            })
            self.transitioningButtons.forEach({ button in
                button.frame = button.initialFrame
                button.titleLabel?.font = button.initialFont
                button.titleLabel?.textColor = button.initialTextColor
                button.backgroundColor = button.initialBackgroundColor
            })
        }, completion: {_ in
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
