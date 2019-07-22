//
//  Art.swift
//  Artworks
//
//  Created by Dheeraj Chittara on 11/07/19.
//  Copyright © 2019 Dheeraj Chittara. All rights reserved.
//

import UIKit

class Art{
    
    //MARK: Properties
    
    var name:String
    var photo: UIImage?
    var rating:Int
    var photoData: String?
    
    //Initialization:
    
    init?(name:String , photo:UIImage? , rating:Int, photoData:String? ){
        
        guard !name.isEmpty else{
            return nil
        }
        
        if (rating<=0) || (rating>5){
            return nil
        }
        
        self.name=name
        self.photo=photo
        self.rating=rating
        self.photoData=photoData
        
    }
    
    init?(name:String, rating:Int){
        
        guard !name.isEmpty else{
            return nil
        }
        
        if (rating<=0) || (rating>5){
            return nil
        }
        
        self.name=name
        self.rating=rating
        
    }
    
    
}
