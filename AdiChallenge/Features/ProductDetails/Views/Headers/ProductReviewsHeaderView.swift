//
//  ProductReviewsHeaderView.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 26/03/2021.
//

import UIKit

class ProductReviewsHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var addNewReview: UIButton!

    static let reuseIdentifier: String = String(describing: self)
    private var hasBeenUpdated: Bool = false
    let didPressAddNewReview = Binder<Void, Void>()
    
    override init(reuseIdentifier: String?) {
          super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func didPressAddNewReview(_ sender: UIButton) {
        didPressAddNewReview(())
    }
}
