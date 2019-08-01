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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----View did Load for collection view was called")
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("func 1 for collection view \(Shared.sharedInstance.artsList.count)")
        return Shared.sharedInstance.artsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else{
            fatalError("The dequeued cell is not an instance of CollectionviewCell")
        }
        print("----This func was called for collection view")
        
//        let art = Shared.sharedInstance.artsList[indexPath.row]
        
        
        self.fetchPhoto(row : indexPath.row, completion : { (image) in
            DispatchQueue.main.async {
                cell.bindModel(image: image)
            }
        })
        return cell
    }
    
    
    func fetchPhoto(row : Int, completion : @escaping (UIImage?)-> ()) {
        if Shared.sharedInstance.artsList[row].photo == nil{
            DispatchQueue.global().async {
                guard let photo = Shared.sharedInstance.artsList[row].photoData else{print("nhp");return}
                
                guard let url = URL(string: photo) else{print("nhp");return}
                let photoData:Data
                
                do{
                    photoData = try Data(contentsOf: url)
                }catch{print("nhp");return}
                
                let image = UIImage(data: photoData)
                Shared.sharedInstance.artsList[row].photo = image
                completion(image)
                print("Download URL Session ended")
                
            }
            
            
        }
        else{
            completion(Shared.sharedInstance.artsList[row].photo)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Selected cell no \(indexPath.row)")
        
        let selectedArt = Shared.sharedInstance.artsList[indexPath.row]
        let selectedPhoto = Shared.sharedInstance.artsList[indexPath.row].photo
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let showArtViewController = mainStoryBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else{
            fatalError("wrong ViewController instantiated")
        }
        print("--- showArtViewController \(showArtViewController) \(self.navigationController)")
        
        showArtViewController.art = selectedArt
        showArtViewController.receivedPhoto = selectedPhoto
        
        self.navigationController?.pushViewController(showArtViewController, animated: true)
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.backgroundColor = UIColor.cyan
//    }
}
