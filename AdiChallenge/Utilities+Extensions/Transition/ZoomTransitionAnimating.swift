//
//  ZoomTransitionAnimating.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 26/03/2021.
//

import UIKit

public protocol ZoomTransitionAnimating: class {
    var transitionSourceImageView: UIImageView { get }
    var transitionSourceBackgroundColor: UIColor? { get }
    var transitionDestinationImageViewFrame: CGRect { get }
}

@objc public protocol ZoomTransitionDelegate: class {
    @objc optional func zoomTransitionAnimator(animator: ZoomTransitionAnimator,
        didCompleteTransition didComplete: Bool,
        animatingSourceImageView imageView: UIImageView)
}
