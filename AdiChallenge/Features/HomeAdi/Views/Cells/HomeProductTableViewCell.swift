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

    var homeProduct: HomeProductModel! {
        didSet {
            productDescLabel.text = homeProduct.description
            productNameLabel.text = homeProduct.name
            productPriceLabel.text = homeProduct.price
            productImageView.loadImageUsingUrlString(urlString: homeProduct.image, placeHolderImage: nil)

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
