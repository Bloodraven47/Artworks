//
//  ArtTableViewCell.swift
//  Artworks
//
//  Created by Dheeraj Chittara on 10/07/19.
//  Copyright © 2019 Dheeraj Chittara. All rights reserved.
//

import UIKit

class ArtTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindModel(ArtObject: Art) {
        self.nameLabel.text = ArtObject.name
        self.ratingControl.rating = ArtObject.rating
    }
    
    func bindImage(image: UIImage?){
        self.photoImageView.image = image
    }

}
