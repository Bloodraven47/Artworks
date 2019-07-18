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
    var number=0
    let session = URLSession(configuration: .default)
    
    let jsonURLstring = "https://apiv2.gaana.com/home/trending/songs/v1?trending_section=1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        gatherData()
        gatherDataOneByOne()
        print("It got out")
        print(arts.count)
        
        //Load the sample data
//        loadSampleArt()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        print("func 1")
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("func 2")
        return arts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("func 3")
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "xyz", for: indexPath) as? ArtTableViewCell else{
            fatalError("The dequeued cell is not an instance of ArtTableViewCell.")
        }

        // Fetches the appropriate meal for the data source layout.
        let art = arts[indexPath.row]
        
        cell.nameLabel.text = art.name
//        sleep(1)
        
//        if art.photo == nil{
//            DispatchQueue.global().async {
//                print("trying to fetch photo")
//
//                guard let photoURL = URL(string: art.photoData!) else{print("nhp");return}
//                let photoData: Data
//                do{
//                    photoData = try Data(contentsOf: photoURL)
//
//                }catch{print("nhp");return}
//
//                let image = UIImage(data: photoData)
//                self.arts[indexPath.row].addphoto(image)
//                print("Photo has been fetched")
//
//                DispatchQueue.main.async {
//
//                    cell.photoImageView.image = art.photo
//                }
//            }
//
//        }
        
        
        cell.ratingControl.rating = art.rating
        cell.photoImageView.image = art.photo
        
        number+=1
        print("\nreturning cell no. \(number)\n")
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
    
    
    
    
   func gatherData(){
    
//        let jsonURLstring = "https://apiv2.gaana.com/home/trending/songs/v1?trending_section=1"
    
    guard let url = URL(string: jsonURLstring) else{print("Impossible #1");return}
        session.dataTask(with: url) { (data, response, err) in
            
            print("session started")
            guard let data=data else{print("nhp");return}
            print("Checkpoint no 2")
            do{
                print("Checkpoint no 3")
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else{print("nhp");return}
                guard let songInfo = json["entities"] as? [[String:Any]] else{print("nhp");return}
                print("Checkpoint no 4")
                for song in songInfo{
                    guard let name = song["name"] as? String else{print("nhp");return}
                    guard let photo = song["atw"] as? String else{print("nhp");return}
                    
                    let photoUrl = URL(string: photo)
                    let data = try? Data(contentsOf: photoUrl!)
                    
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        guard let Art1 = Art(name: name, photo: image, rating: Int.random(in: 1..<6), photoData: photo) else{
                            print("nhp");return
                        }
                        self.arts += [Art1]
                    }
                    print("Checkpoint no 5")
                    
                }
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
                print("Checkpoint no 6")
                
            }catch {
                print("nhp");return
            }
            print(self.arts.count)
            print("Session ended")
            
        }.resume()
        print("did this happen")
    }
    
    private func gatherDataOneByOne(){
        
        let jsonURLString = "https://apiv2.gaana.com/home/trending/songs/v1?trending_section=1"
        
        guard let url = URL(string: jsonURLString) else{print("Tumse nhp");return}
        
        
        session.dataTask(with: url) { (data, response, Err) in
            print("URL Session started")
            guard let data = data else{print("nhp");return}
            //Declaring json outside do while, so that I don't have to write complete code in that do while scope itself
            let json: [String:Any]
            
            
            //do while to instantiate json object
            do{
                json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
            }catch{
                print("nhp");return
            }
            
            // Getting the relevant array of dictionaries
            guard let songInfo = json["entities"] as? [[String:Any]] else{print("nhp");return}
            
            
            //Populating the table with names and ratings only first
            for song in songInfo{
                guard let name = song["name"] as? String else{print("nhp");return}
                guard var photo = song["atw"] as? String else{print("nhp");return}
                guard let Art1 = Art(name: name, photo: nil, rating: Int.random(in: 1..<6),photoData: photo) else{print("nhp");return}
                
                self.arts+=[Art1]
            }
            print(self.arts[10].name,self.arts[10].rating,self.arts[10].photo,self.arts[10].photoData)
            
            //Reloading entire tableview to show the names and ratings
            DispatchQueue.main.async{
                self.tableView.reloadData()
                print("whole view was reloaded")
                
            }
            
//            //Now downloading the photos
//            for (index,song) in songInfo.enumerated(){
//                guard let photo = song["atw"] as? String else{print("nhp");return}
//
//                guard let url = URL(string: photo) else{print("nhp");return}
//                let photoData:Data
//
//                do{
//                    photoData = try Data(contentsOf: url)
//                }catch{print("nhp");return}
//
//                let image = UIImage(data: photoData)
//                self.arts[index].addphoto(image)
//                DispatchQueue.main.async{
//                self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
//                }
//                print("doing the step")
//            }
            
            print("URL Session ended")
        }.resume()
        
        
        
        session.dataTask(with: url) { (data, response, Err) in
            print("Download URL Session started")
            guard let data = data else{print("tumse nhp");return}
            //Declaring json outside do while, so that I don't have to write complete code in that do while scope itself
            let json: [String:Any]
            
            //do while to instantiate json object
            do{
                json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
            }catch{
                print("nhp");return
            }
            
            // Getting the relevant array of dictionaries
            guard let songInfo = json["entities"] as? [[String:Any]] else{print("tumse nhp");return}
            
            
            
            //Now downloading the photos
            for (index,song) in songInfo.enumerated(){
                guard let photo = song["atw"] as? String else{print("nhp");return}
                
                guard let url = URL(string: photo) else{print("nhp");return}
                let photoData:Data
                
                do{
                    photoData = try Data(contentsOf: url)
                }catch{print("nhp");return}
                
                let image = UIImage(data: photoData)
                self.arts[index].addphoto(image)
                DispatchQueue.main.async{
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                print("doing the step")
            }
            
            print("Download URL Session ended")
            }.resume()
        
        
    }
    
    
    
    private func loadSampleArt(){
        
            let photo1 = UIImage(named: "Monalisa")
            let photo2 = UIImage(named: "ChillingMonalisa")
            let photo3 = UIImage(named: "JayMonalisa")
            let photo4 = UIImage(named: "Couple")
            let photo5 = UIImage(named: "ModernCouple")
            let photo6 = UIImage(named: "Death")
            let photo7 = UIImage(named: "Me")
        
            
        guard let Art1=Art(name: "Monalisa", photo: photo1, rating: 5, photoData: nil) else{
                print("nhp");return
            }
        guard let Art2=Art(name: "ChillingMonalisa", photo: photo2, rating: 3, photoData: nil) else{
                print("nhp");return
            }
        guard let Art3=Art(name: "JayMonalisa", photo: photo3, rating: 4, photoData: nil) else{
                print("nhp");return
            }
        guard let Art4=Art(name: "Couple", photo: photo4, rating: 3, photoData: nil) else{
                print("nhp");return
            }
        guard let Art5=Art(name: "ModernCouple", photo: photo5, rating: 4, photoData: nil) else{
                print("nhp");return
            }
        guard let Art6=Art(name: "Death", photo: photo6, rating: 2, photoData: nil) else{
                print("nhp");return
            }
        guard let Art7=Art(name: "Me", photo: photo7, rating: 5, photoData: nil) else{
                print("nhp");return
            }
            
            arts+=[Art1,Art2,Art3,Art4,Art5,Art6,Art7]
    }
}
