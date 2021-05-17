//
//  WantHelpViewController.swift
//  Хочу помочь
//
//  Created by Булат on 14.04.2021.
//

import UIKit

class WantHelpViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var person: [HelpModel] = []
    //let lock = NSLock()
    //var category = Servise().takeFileCategory(completion: {_ in })
    //var categoryModel : [Category] = []
    var categories: [Category]?
    var indicator = UIActivityIndicatorView(style: .large)
    
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
        
        self.view.addSubview(indicator)
        indicator.hidesWhenStopped = true
        indicator.center = self.view.center
        indicator.startAnimating()
        
        //            for index in 0..<category.masName.count {
        //                categoryModel.append(Category(id: 1, name: category.masName[index], image: category.masImage[index]))
        //            }
        Servise().takeFileCategory { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let result):
                self.categories = result
                self.collectionView.reloadData()
                self.indicator.stopAnimating()
            case .failure: break
            }
            
        }
    }
    
    
    
    func showSpinner() {
        self.view.addSubview(indicator)
        indicator.hidesWhenStopped = true
        indicator.center = self.view.center
        indicator.startAnimating()
    }
    func removeSpinner(){
        indicator.removeFromSuperview()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCollectionViewCell
        //showSpinner()
        
//        for index in 0..<category.masName.count {
//            categoryModel.append(Category(id: 1, name: category.masName[index], image: category.masImage[index]))
//        }
        
        //Servise().takeFileCategory(completion: {_ in })
//        let model = categoryModel[indexPath.row]
//        cell?.invalidImage.image = UIImage(named: categoryModel[indexPath.row].image)
//        cell?.invalidTitle?.text = categoryModel[indexPath.row].name
//        cell!.configure(with: model)
        
        if let model = categories?[indexPath.row] {
//            cell?.invalidImage.image = UIImage(named: model.image)
//            cell?.invalidTitle.text = model.name
            cell?.configure(with: model)
        }
        //removeSpinner()
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
