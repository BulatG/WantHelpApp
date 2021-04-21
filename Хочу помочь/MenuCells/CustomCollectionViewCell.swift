//
//  CustomCollectionViewCell.swift
//  Хочу помочь
//
//  Created by Булат on 15.04.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var invalidImage: UIImageView!
    @IBOutlet weak var invalidTitle: UILabel!
    func configure(with help: HelpModel) {
        invalidImage.image = help.image
        invalidTitle.text = help.title
        invalidTitle.font = UIFont(name: "OfficinaSansExtraBoldSCC", size: 17)
        invalidTitle.textColor = UIColor(red: 158/255, green: 191/255, blue: 80/255, alpha: 1)
    }
    func customLabel() {
    }
}
