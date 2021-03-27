//
//  HomeProductTableViewCell.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit

class HomeProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: AdiImageView!

    var productInfo: ProductPresentationModel! {
        didSet {
            productDescLabel.text = productInfo.description
            productNameLabel.text = productInfo.name
            productPriceLabel.text = productInfo.price
            productImageView.loadImageUsingUrlString(urlString: productInfo.image, placeHolderImage: UIImage(named: "ic-placeholder"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
