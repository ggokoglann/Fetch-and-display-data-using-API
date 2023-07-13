//
//  CollectionViewCell.swift
//  Currencies_mvc
//
//  Created by Gökhan Gökoğlan on 3.07.2023.
//

import UIKit

class CurrencyCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
        
    func configure(with currency: Currency) {
            nameLabel.text = currency.name
            priceLabel.text = "₺ \(currency.price)"
            imageView.image = currency.image
        }
    }
