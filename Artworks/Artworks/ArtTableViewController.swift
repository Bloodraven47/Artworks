//
//  ArtTableViewController.swift
//  Artworks
//
//  Created by Dheeraj Chittara on 11/07/19.
//  Copyright © 2019 Dheeraj Chittara. All rights reserved.
//

import UIKit

class ArtTableViewController: UITableViewController {

    //Properties:
    
    var arts=[Art]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load the sample data
        loadSampleArt()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArtTableViewCell", for: indexPath) as? ArtTableViewCell else{
            fatalError("The dequeued cell is not an instance of ArtTableViewCell.")
        }

        // Fetches the appropriate meal for the data source layout.
        let art = arts[indexPath.row]
        
        cell.nameLabel.text = art.name
        cell.photoImageView.image = art.photo
        cell.ratingControl.rating = art.rating

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    //MARK: Private Methods
    
    private func loadSampleArt(){
        let photo1 = UIImage(named: "Monalisa")
        let photo2 = UIImage(named: "ChillingMonalisa")
        let photo3 = UIImage(named: "JayMonalisa")
        let photo4 = UIImage(named: "Couple")
        let photo5 = UIImage(named: "ModernCouple")
        let photo6 = UIImage(named: "Death")
        let photo7 = UIImage(named: "Me")
        
        guard let Art1=Art(name: "Monalisa", photo: photo1, rating: 5) else{
            fatalError("Unable to Instantiate Art1")
        }
        guard let Art2=Art(name: "ChillingMonalisa", photo: photo2, rating: 3) else{
            fatalError("Unable to Instantiate Art2")
        }
        guard let Art3=Art(name: "JayMonalisa", photo: photo3, rating: 4) else{
            fatalError("Unable to Instantiate Art3")
        }
        guard let Art4=Art(name: "Couple", photo: photo4, rating: 3) else{
            fatalError("Unable to Instantiate Art4")
        }
        guard let Art5=Art(name: "ModernCouple", photo: photo5, rating: 4) else{
            fatalError("Unable to Instantiate Art5")
        }
        guard let Art6=Art(name: "Death", photo: photo6, rating: 2) else{
            fatalError("Unable to Instantiate Art6")
        }
        guard let Art7=Art(name: "Me", photo: photo7, rating: 5) else{
            fatalError("Unable to Instantiate Art7")
        }
        
        arts+=[Art1,Art2,Art3,Art4,Art5,Art6,Art7]
        
    }
}
