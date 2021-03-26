//
//  ProductDetailsHeaderView.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit

class ProductDetailsHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: AdiImageView!

    static let reuseIdentifier: String = String(describing: self)
    private var hasBeenUpdated: Bool = false

    override init(reuseIdentifier: String?) {
          super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
