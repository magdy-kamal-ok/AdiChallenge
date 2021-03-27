//
//  ReviewView.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 26/03/2021.
//

import UIKit
import Cosmos
class ReviewView: UIView {
    
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    private(set) var ratingValue: Int = 0
    private(set) var reviewText: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ReviewView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setupViews()
    }
    
    private func setupViews() {
        reviewTextView.layer.borderColor = UIColor.gray.cgColor
        reviewTextView.layer.borderWidth = 1
        reviewTextView.layer.cornerRadius = 5
        reviewTextView.layer.masksToBounds = true
        titleLabel.text = "add-new-review".localized
        reviewTextView.delegate = self
        ratingValue = Int(ceil(ratingView.rating))
        ratingView.didFinishTouchingCosmos = { [weak self] rating in
            guard let self = self else { return }
            self.ratingValue = Int(ceil(rating))
        }
    }
}

extension ReviewView: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        reviewText = textView.text
    }
}
