//
//  CollectionViewController.swift
//  Хочу помочь
//
//  Created by Булат on 14.04.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar()
        customNavBarTitle()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")

        // Do any additional setup after loading the view.
    }
    func customNavBar() {
//        UINavigationBar.appearance().backgroundColor = UIColor(red: 102/255, green: 146/255, blue: 54/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 102/255, green: 146/255, blue: 54/255, alpha: 1)    }
    func customNavBarTitle() {
        let label = UILabel()
        label.text = "Помочь"
        label.font = UIFont(name: "OfficinaSansExtraBoldSCC.otf", size: 10)
        label.textColor = .white
        navigationItem.titleView = label
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        // Configure the cell
        return cell
    }

    // MARK: UICollectionViewDelegate

}
