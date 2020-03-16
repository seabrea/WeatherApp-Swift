//
//  CollectionViewController.swift
//  WeatherAppSwift
//
//  Created by He Bob on 2020/3/3.
//  Copyright © 2020 He Bob. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    let identifier = "cell"
    var collectionView: UICollectionView!
    var dataSource: [Forecast]?
    
    public class func create(with forecasts: [Forecast]) -> CollectionViewController {
        
        let viewController = CollectionViewController()
        viewController.dataSource = forecasts
        return viewController
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configView()
    }
    
    deinit {
        logDealloc(className: self.classForCoder)
    }
    
    func configView() {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: (DefineConst.WScreen - 30) / 2, height: (DefineConst.WScreen - 30) / 2)
        collectionViewLayout.minimumInteritemSpacing = 10
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemTeal
        collectionView.register(UINib(nibName: "CollectionViewControllerViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        
        view.addSubview(collectionView!)
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CollectionViewControllerViewCell
        
        guard let forecast = dataSource?[indexPath.row] else {
            return cell
        }
        cell.refreshCell(with: forecast, isToday: (indexPath.row == 1))
        return cell
    }
}
