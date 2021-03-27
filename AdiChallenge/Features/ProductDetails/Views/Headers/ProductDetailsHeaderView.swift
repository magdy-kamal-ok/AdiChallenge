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

    var productInfo: ProductPresentationModel! {
        didSet {
            productDescLabel.text = productInfo.description
            productNameLabel.text = productInfo.name
            productPriceLabel.text = productInfo.price
            productImageView.loadImageUsingUrlString(urlString: productInfo.image, placeHolderImage: UIImage(named: "ic-placeholder"))
        }
    }
    
    override init(reuseIdentifier: String?) {
          super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
