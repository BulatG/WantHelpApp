//
//  CharityEventsViewController.swift
//  Хочупомочь
//
//  Created by Булат on 23.04.2021.
//

import UIKit

class CharityEventsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    var events : [Event] = []
    var eventsDataArray : [EventEntity] = []
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
        self.view.addSubview(indicator)
        indicator.hidesWhenStopped = true
        indicator.center = self.view.center
        indicator.startAnimating()
        
        NetworkManager().parseJSONEventFromURL() { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let result):
                self.events = result
                CoreDataManager.shared.setEventsToStorage(result) { [weak self] result in
                    guard let self = self else {
                        return
                    }
                    switch result {
                    case .success(let result):
                        DispatchQueue.main.async {
                            self.eventsDataArray = result
                            self.collectionView.reloadData()
                            self.indicator.stopAnimating()
                        }
                    case .failure: break
                    }
                }
            case .failure:
                CoreDataManager().readingEventsToBundle() { [weak self] result in
                    guard let self = self else {
                        return
                    }
                    switch result {
                    case .success(let result):
                        self.events = result
                    case .failure: break
                    }
                }
                
                CoreDataManager().transformEventEntityToObject() { [weak self] result in
                    guard let self = self else {
                        return
                    }
                    switch result {
                    case .success(let result):
                        self.eventsDataArray = result
                        self.collectionView.reloadData()
                        self.indicator.stopAnimating()
                    case .failure: break
                    }
                }
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
        eventsDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kidsCell", for: indexPath) as? CollectionViewCell
        let model = eventsDataArray[indexPath.row]
        cell?.confgiureWithCoreData(with: model)
        cell?.tag = indexPath.row
        return cell!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }
        
        switch segueIdentifier {
        case SegueIdentifier.myPost.rawValue:
            if let collectionViewCell = sender as? UICollectionViewCell {
                let index = collectionViewCell.tag
                let postmodel = eventsDataArray[index]
                let destController = segue.destination as! DetailEventViewController
                destController.post = postmodel
                destController.onEditPostHandler = { [weak self] model in
                    guard let self = self else { return }
                    self.eventsDataArray[index] = model
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                            UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-16, height: 413)
    }
}
