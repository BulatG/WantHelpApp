//
//  CharityEventsViewController.swift
//  Хочупомочь
//
//  Created by Булат on 23.04.2021.
//

import UIKit

class CharityEventsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    //var jsonEventFunc = Servise().takeFileEvents()
    //var jsonEvent : [Event] = []
    var events : [Event]?
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        //        for index in 0..<jsonEventFunc.count {
        //            jsonEvent.append(Event(id: jsonEventFunc[index].id, title: jsonEventFunc[index].title,
        //                                   description: jsonEventFunc[index].description, footer: jsonEventFunc[index].footer,
        //                                   fundName: jsonEventFunc[index].fundName, adress:jsonEventFunc[index].adress, phone: jsonEventFunc[index].phone,
        //                                   description2: jsonEventFunc[index].description2, mainImage: jsonEventFunc[index].mainImage,
        //                                   image2: jsonEventFunc[index].image2, image3: jsonEventFunc[index].image3))
        //        }
        self.view.addSubview(indicator)
        indicator.hidesWhenStopped = true
        indicator.center = self.view.center
        indicator.startAnimating()
        
        Servise().takeFileEvents { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let result):
                self.events = result
                self.collectionView.reloadData()
                self.indicator.stopAnimating()
                
            case .failure(_):break
            }
        }
    }
    
    func showSpinner() {
        indicator.center =  self.view.center
        indicator.startAnimating()
        self.view.addSubview(indicator)
    }
    func removeSpinner(){
        indicator.removeFromSuperview()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        events?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kidsCell", for: indexPath) as? CollectionViewCell
        //cell?.image.image = UIImage(named: jsonEvent[indexPath.row].mainImage)
        if let model = events?[indexPath.row]{
            cell!.confgiure(with: model)
        }
        
        cell?.tag = indexPath.row
        return cell!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }
        
        switch segueIdentifier {
        case SegueIdentifier.myPost.rawValue:
            if let collectionViewCell = sender as? UICollectionViewCell {
                let index = collectionViewCell.tag
                //let postModel = jsonEvent[index]
                let postmodel = events?[index]
                let destController = segue.destination as! DetailEventViewController
                destController.post = postmodel
                destController.onEditPostHandler = { [weak self] model in
                    guard let self = self else { return }
                    self.events?[index] = model
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
