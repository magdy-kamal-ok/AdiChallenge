//
//  ProductReviewTableViewCell.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 26/03/2021.
//

import UIKit
import Cosmos

class ProductReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!

    var productReview: ProductReview! {
        didSet {
            reviewLabel.text = productReview.desc
            ratingView.rating = Double(productReview.rating)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        ratingView.settings.disablePanGestures = true
        ratingView.settings.updateOnTouch = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
