//
//  RatingControl.swift
//  Artworks
//
//  Created by Dheeraj Chittara on 10/07/19.
//  Copyright © 2019 Dheeraj Chittara. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    //MARK: Properties
    private var ratingButtons=[UIButton]()
    
    var rating = 0{
        didSet{
            updateButtons()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet{
            setupButtons()
        }
    }
    
    @IBInspectable var starCount = 5{
        didSet{
            setupButtons()
        }
    }
    
    
    //MARK: Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    //MARK: Methods
    
    @objc func ratingButtonTapped(button: UIButton){
        
        guard let index=ratingButtons.firstIndex(of: button) else{
            fatalError("The button \(button) was not present in \(ratingButtons)")
        }
        
        let selectedRating = index+1
        
        if selectedRating == rating{
            rating = 0
        }
        else{
            rating = selectedRating
        }
    }
    
    func updateButtons(){
        for i in 0..<ratingButtons.count{
            if i<rating{
            ratingButtons[i].isSelected = true
            }
            else{
                ratingButtons[i].isSelected = false
            }
        }
        
    }
    
    
    private func setupButtons(){
        
        //clearing existing buttons
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        
        //Load button images
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        for _ in 0..<starCount{
            let button = UIButton()
            
            // set button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted,.selected])
            
            //set constraints
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            ratingButtons.append(button)
            
        }
        
        updateButtons()
        
        
    }
    
    
    
}
