//
//  CollectionViewCell.swift
//  Artworks
//
//  Created by Dheeraj Chittara on 29/07/19.
//  Copyright © 2019 Dheeraj Chittara. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    func bindModel(image: UIImage?) {
        self.imageView.image = image
    }
    

}
