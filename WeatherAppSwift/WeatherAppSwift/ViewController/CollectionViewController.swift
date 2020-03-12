//
//  CollectionViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/3.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDealloc(className: self.classForCoder)
    }

    func configView() {
        
//        let collectionViewLayout = WaterFallLayout()
//        collectionViewLayout.miniLineSpacing = 20
//        collectionViewLayout.miniItemSpacing = 20
//        collectionViewLayout.edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 50, height: 50)
        collectionViewLayout.minimumInteritemSpacing = 50
        collectionViewLayout.minimumLineSpacing = 50
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        
        view.addSubview(collectionView!)
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, WaterFallLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .orange
        return cell
    }
    
    func waterFall(layout: WaterFallLayout, heightForCellAtIndexPath: IndexPath) -> Float {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(WebViewController(), animated: true)
    }
}
