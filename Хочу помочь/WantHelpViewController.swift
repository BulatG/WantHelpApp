//
//  WantHelpViewController.swift
//  Хочу помочь
//
//  Created by Булат on 14.04.2021.
//

import UIKit

class WantHelpViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var person: [HelpModel] = []
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        person.append(HelpModel(title: "Дети", image: UIImage(named: "invalidName")!))
        person.append(HelpModel(title: "Взрослые", image: UIImage(named: "invalidName-4")!))
        person.append(HelpModel(title: "Пожилые", image: UIImage(named: "invalidName-3")!))
        person.append(HelpModel(title: "Животные", image: UIImage(named: "invalidName-2")!))
        person.append(HelpModel(title: "Мероприятия", image: UIImage(named: "invalidName-1")!))
        descriptionLabel.font = UIFont(name: "SF UI Text Regular", size: 17)
        descriptionLabel.textColor = UIColor(red: 73/255, green: 74/255, blue: 74/255, alpha: 1)
        let width = (view.frame.width-27)/2
        print(width)
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout!.itemSize = CGSize(width: width, height: width)
    }
    override func viewWillAppear(_ animated: Bool) {
        customNavBar()
        customNavBarTitle()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return person.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCollectionViewCell
        let model = person[indexPath.row]
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
    //
    func customNavBar() {
//        UINavigationBar.appearance().backgroundColor = UIColor(red: 102/255, green: 146/255, blue: 54/255, alpha: 1)
       // navigationController?.navigationBar.barTintColor = UIColor(red: 102/255, green: 146/255, blue: 54/255, alpha: 1)
    }
    func customNavBarTitle() {
//        let label = UILabel()
//        label.text = "Помочь"
//        label.font = UIFont(name: "OfficinaSansExtraBoldSCC.otf", size: 20)
//        label.textColor = .white
//        navigationItem.titleView = label
    }
}
