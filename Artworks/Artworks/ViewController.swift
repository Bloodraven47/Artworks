//
//  ViewController.swift
//  Artworks
//
//  Created by Dheeraj Chittara on 10/07/19.
//  Copyright © 2019 Dheeraj Chittara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var art: Art?
    
    var receivedPhoto : UIImage?
    @IBOutlet weak var artName: UILabel!
    
    @IBOutlet weak var artPhoto: UIImageView!
    
    @IBOutlet weak var artRating: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("--- vc loaded")
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapImage(_:)))
        tapRecognizer.numberOfTapsRequired = 1

        self.artPhoto.isUserInteractionEnabled = true
        self.artPhoto.addGestureRecognizer(tapRecognizer)
        
        if let art = art{
            
            artName.text = art.name
            artRating.rating = art.rating
        }
        
        if let receivedPhoto = receivedPhoto{
            artPhoto.image = receivedPhoto
            
        }
        
    }
    
    @objc func handleTapImage(_ sender : UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 1, animations: {
            self.artPhoto.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { (true) in
            self.artPhoto.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
    }

    
    
    
    
    
    
}

