//
//  DetailEventViewController.swift
//  Хочупомочь
//
//  Created by Булат on 24.04.2021.
//

import UIKit

typealias EditPostHandler = (Event) -> Void

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
    @IBOutlet weak var firstFooterButton: UIButton!
    @IBOutlet weak var second: UIButton!
    @IBOutlet weak var third: UIButton!
    @IBOutlet weak var forth: UIButton!
    
    
    var post:Event!
    var onEditPostHandler: EditPostHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconShare"), style: .done, target: self, action: nil)
        titleFromCharityVC.text = post?.title
        footerFromCharityVC.text = post?.footer
        //mainImage.image = post?.image
        descriptionFromCharityVC.text = post?.description2
        fundName.text = post?.fundName
        adress.text = post?.adress
        phone.text = post?.phone
        
        titleFromCharityVC.lineBreakMode = .byWordWrapping
        titleFromCharityVC.numberOfLines = 0
        titleFromCharityVC.font = UIFont(name: "OfficinaSansExtraBoldSCC", size: 21)
        titleFromCharityVC.textColor = UIColor(displayP3Red: 98/255, green: 127/255, blue: 143/255, alpha: 1)
        phone.lineBreakMode = .byWordWrapping
        phone.numberOfLines = 0
        
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
        
        let service = Servise()
        service.takeFileCategory()
        service.takeFileEvents()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        self.navigationItem.title = post?.title
        
        let width = (view.frame.width)/4
        firstFooterButton.frame.size.width = width
        second.frame.size.width = width
        third.frame.size.width = width
        forth.frame.size.width = width
    }
}


