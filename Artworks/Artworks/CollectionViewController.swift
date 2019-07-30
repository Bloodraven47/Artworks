//
//  CollectionViewController.swift
//  Artworks
//
//  Created by Dheeraj Chittara on 29/07/19.
//  Copyright © 2019 Dheeraj Chittara. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseIdentifier = "cell"
    let test = ["1","2","3","4","5","6","7","8","9","10"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else{
            fatalError("The dequeued cell is not an instance of CollectionviewCell")
        }
        print("----This func was called")
        cell.backgroundColor = UIColor.cyan
        cell.textLabel.text = String(test[indexPath.row])
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.blue
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.cyan
    }
}
