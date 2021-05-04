//
//  DetailEventViewController.swift
//  Хочупомочь
//
//  Created by Булат on 24.04.2021.
//

import UIKit

typealias EditPostHandler = (CharityEventsModel) -> Void

class DetailEventViewController: UIViewController {
    
    @IBOutlet weak var titleFromCharityVC: UILabel!
    @IBOutlet weak var footerFromCharityVC: UILabel!
    @IBOutlet weak var fundName: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var questions: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var writeToUsButton: UIButton!
    @IBOutlet weak var descriptionFromCharityVC: UITextView!
    
    var post:CharityEventsModel!
    var onEditPostHandler: EditPostHandler!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        titleFromCharityVC.text = post?.title
        footerFromCharityVC.text = post?.footerText
        mainImage.image = post?.image
        descriptionFromCharityVC.text = post?.description
        
        titleFromCharityVC.lineBreakMode = .byWordWrapping
        titleFromCharityVC.numberOfLines = 0
        titleFromCharityVC.font = UIFont(name: "OfficinaSansExtraBoldSCC", size: 21)
        titleFromCharityVC.textColor = UIColor(displayP3Red: 98/255, green: 127/255, blue: 143/255, alpha: 1)
        
        let greenColor = UIColor(displayP3Red: 148/255, green: 153/255, blue: 138/255, alpha: 1)
        
        footerFromCharityVC.textColor = greenColor
        
        let font = UIFont(name: "SF UI Text Regular", size: 15)
        let blueColor = UIColor(displayP3Red: 73/255, green: 74/255, blue: 74/255, alpha: 1)
        adress.font = font
        phone.font = font
        adress.textColor = blueColor
        phone.textColor = blueColor
        fundName.textColor = blueColor
        questions.textColor = blueColor
        descriptionFromCharityVC.textColor = blueColor
    }
}


