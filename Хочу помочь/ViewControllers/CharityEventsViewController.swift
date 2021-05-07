//
//  CharityEventsViewController.swift
//  Хочупомочь
//
//  Created by Булат on 23.04.2021.
//

import UIKit

class CharityEventsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
        
    @IBOutlet weak var collectionView: UICollectionView!
    var event: [CharityEventsModel] = []
    var jsonEventFunc = Servise().takeFileEvents()
    var jsonEvent : [Event] = []
    
    @IBOutlet weak var currentButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        event.append(CharityEventsModel(image: UIImage(named: "kidImage1")!, title: "Спонсоры отремонтируют школу-интернат", description: "Дубовская школа-интернат для детей с ограниченными возможностями здоровья стала первой в области …", footerText: "Осталось 13 дней (21.09 – 20.10)"))
//        event.append(CharityEventsModel(image: UIImage(named: "kidImage2")!, title: "Конкурс по вокальному пению в детском доме №6", description: "Дубовская школа-интернат для детей с ограниченными возможностями здоровья стала первой в области …", footerText: "Октябрь 20, 2016"))
//        event.append(CharityEventsModel(image: UIImage(named: "kidImage2")!, title: "Конкурс по вокальному пению в детском доме №6", description: "Дубовская школа-интернат для детей с ограниченными возможностями здоровья стала первой в области …", footerText: "Октябрь 20, 2016"))
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.tabBarController?.tabBar.isHidden = false
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        
        completedButton.layer.borderColor = CGColor(red: 102/255, green: 166/255, blue: 54/255, alpha: 1)
        
        for index in 0..<jsonEventFunc.count {
            jsonEvent.append(Event(id: jsonEventFunc[index].id, title: jsonEventFunc[index].title, description: jsonEventFunc[index].description, footer: jsonEventFunc[index].footer, fundName: jsonEventFunc[index].fundName, adress:jsonEventFunc[index].adress, phone: jsonEventFunc[index].phone, description2: jsonEventFunc[index].description2))
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        jsonEvent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kidsCell", for: indexPath) as? CollectionViewCell
        let model = jsonEvent[indexPath.row]
        cell!.confgiure(with: model)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
        performSegue(withIdentifier: "detailidentifier", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }

        switch segueIdentifier {
        case SegueIdentifier.myPost.rawValue:
            if let index = sender as? Int {
                let postModel = jsonEvent[index]
                let destController = segue.destination as! DetailEventViewController
                destController.post = postModel
                destController.onEditPostHandler = { [weak self] model in
                    guard let self = self else { return }
                    self.jsonEvent[index] = model
                    self.collectionView.reloadData()
                }
            }
        default:
            return
        }
    }
}

private extension CharityEventsViewController {
    enum SegueIdentifier: String {
        case myPost = "detailidentifier"
    }
}

extension CharityEventsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-16, height: 413)
    }
}
