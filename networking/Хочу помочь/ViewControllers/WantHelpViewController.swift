//
//  WantHelpViewController.swift
//  Хочу помочь
//
//  Created by Булат on 14.04.2021.
//

import UIKit
import CoreData

class WantHelpViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var categoriesData : [Category] = []
    var categoriesCoreData : [CategoryEntity] = []
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
        
        CoreDataManager().cleanCoreDataEvents()
        CoreDataManager().cleanCoreDataCategories()
        
        NetworkManager().parseJSONCategoryFromURL() { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let result):
                self.categoriesData = result
                CoreDataManager.shared.setCategoriesToStorage(result) { [weak self] result in
                    guard let self = self else {
                        return
                    }
                    switch result {
                    case .success(let result):
                        DispatchQueue.main.async {
                            self.categoriesCoreData = result
                            self.collectionView.reloadData()
                            self.indicator.stopAnimating()
                        }
                    case .failure: break
                    }
                }
            case .failure:
                self.alertNetworkErrorMessage()
                CoreDataManager().readingCategoryToBundle() { [weak self] result in
                    guard let self = self else {
                        return
                    }
                    switch result {
                    case .success(let result):
                        self.categoriesData = result
                    case .failure: break
                    }
                }
                
                CoreDataManager().transformCategoryToObject() { [weak self] result in
                    guard let self = self else {
                        return
                    }
                    switch result {
                    case .success(let result):
                        self.categoriesCoreData = result
                        self.collectionView.reloadData()
                        self.indicator.stopAnimating()
                    case .failure: break
                    }
                }
            }
        }
        Alamofire.shared.dowonloadDataFromFirebase()
    }
    
    func alertNetworkErrorMessage() {
        let alert = UIAlertController(title: "Ошибка",
                                      message: "Соединение с сетью было потеряно, данные загруэжены из файла",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        
        self.present(alert, animated: true)
        
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
        return categoriesCoreData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCollectionViewCell
        let model = categoriesCoreData[indexPath.row]
        cell?.configureWithCoreData(with: model)        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200.0, height: 200)
    }
}
