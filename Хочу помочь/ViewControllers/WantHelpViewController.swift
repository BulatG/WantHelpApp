//
//  WantHelpViewController.swift
//  Хочу помочь
//
//  Created by Булат on 14.04.2021.
//

import UIKit

class WantHelpViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var person: [HelpModel] = []
    var category = Servise().takeFileCategory()
    var categoryModel : [Category] = []
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        descriptionLabel.font = UIFont(name: "SF UI Text Regular", size: 17)
        descriptionLabel.textColor = UIColor(red: 73/255, green: 74/255, blue: 74/255, alpha: 1)
        let width = (view.frame.width-27)/2
        print(width)
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout!.itemSize = CGSize(width: width, height: width)
        self.tabBarController?.tabBar.isHidden = false
        for index in 0..<category.masName.count {
            categoryModel.append(Category(id: 1, name: category.masName[index], image: category.masImage[index]))
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.masName.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCollectionViewCell
        
        let model = categoryModel[indexPath.row]
        cell?.invalidImage.image = UIImage(named: categoryModel[indexPath.row].image)
        cell?.invalidTitle?.text = categoryModel[indexPath.row].name
        cell!.configure(with: model)
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
     }

     func collectionView(_ collectionView: UICollectionView, layout
                 collectionViewLayout: UICollectionViewLayout,
                                 minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 10
     }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200.0, height: 200)
        }
}
