//
//  CollectionViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/3.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDealloc(className: self.classForCoder)
    }

    func configView() {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 100,height: 100)
        collectionViewLayout.minimumLineSpacing = 20
        collectionViewLayout.minimumInteritemSpacing = 20
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView!)
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .orange
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }

}
