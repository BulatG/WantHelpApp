//
//  CharityEventsViewController.swift
//  Хочупомочь
//
//  Created by Булат on 23.04.2021.
//

import UIKit

class CharityEventsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    var jsonEventFunc = Servise().takeFileEvents()
    var jsonEvent : [Event] = []
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
        for index in 0..<jsonEventFunc.count {
            jsonEvent.append(Event(id: jsonEventFunc[index].id, title: jsonEventFunc[index].title,
                                   description: jsonEventFunc[index].description, footer: jsonEventFunc[index].footer,
                                   fundName: jsonEventFunc[index].fundName, adress:jsonEventFunc[index].adress, phone: jsonEventFunc[index].phone,
                                   description2: jsonEventFunc[index].description2, mainImage: jsonEventFunc[index].mainImage,
                                   image2: jsonEventFunc[index].image2, image3: jsonEventFunc[index].image3))
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
        jsonEvent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kidsCell", for: indexPath) as? CollectionViewCell
        DispatchQueue.main.async { [self] in
            showSpinner()
            cell?.image.image = UIImage(named: jsonEvent[indexPath.row].mainImage)
            let model = jsonEvent[indexPath.row]
            removeSpinner()
            cell!.confgiure(with: model)
            cell?.tag = indexPath.row
        }
        return cell!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }
        
        switch segueIdentifier {
        case SegueIdentifier.myPost.rawValue:
            if let collectionViewCell = sender as? UICollectionViewCell {
                DispatchQueue.main.async { [self] in
                    showSpinner()
                    let index = collectionViewCell.tag
                    let postModel = jsonEvent[index]
                    let destController = segue.destination as! DetailEventViewController
                    destController.post = postModel
                    destController.onEditPostHandler = { [weak self] model in
                        guard let self = self else { return }
                        self.jsonEvent[index] = model
                        self.collectionView.reloadData()
                    }
                    removeSpinner()
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
