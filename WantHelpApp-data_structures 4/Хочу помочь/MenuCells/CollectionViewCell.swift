//
//  CollectionViewCell.swift
//  Хочупомочь
//
//  Created by Булат on 23.04.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var footerLabel: UILabel!
    func confgiure(with kids: Event){
        //image.image = kids.image
        title.text = kids.title
        descriptionLabel.text = kids.description
        footerLabel.text = kids.footer
        title.font = UIFont(name: "OfficinaSansExtraBoldSCC", size: 21)
        title.textColor = UIColor(displayP3Red: 98/255, green: 127/255, blue: 143/255, alpha: 1)
        descriptionLabel.font = UIFont(name: "SF UI Text Regular", size: 15)
        descriptionLabel.textColor = UIColor(displayP3Red: 22/255, green: 59/255, blue: 79/255, alpha: 1)
    }
}
