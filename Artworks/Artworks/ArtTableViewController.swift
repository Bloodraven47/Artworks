//
//  ArtTableViewController.swift
//  Artworks
//
//  Created by Dheeraj Chittara on 11/07/19.
//  Copyright © 2019 Dheeraj Chittara. All rights reserved.
//

import UIKit
import os.log

class ArtTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    //MARK:- IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- Properties:
//    var photoDataDict = [Int:String?]()
//    var photoDict = [Int:UIImage?]()
    var number=0
    let session = URLSession(configuration: .default)
    
    let jsonURLString = "https://apiv2.gaana.com/home/trending/songs/v1?trending_section=1"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        gatherDataOneByOne()
        
    }
    
    fileprivate func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        print("func 1")
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("func 2 \(Shared.sharedInstance.artsList.count)")
        return Shared.sharedInstance.artsList.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("func 3")
        print("--- cell for row called at \(indexPath.row)")
        
        tableView.register(UINib(nibName: "ArtTableViewCell", bundle: nil), forCellReuseIdentifier: "ArtCell")
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArtCell", for: indexPath) as? ArtTableViewCell else{
            //return UITableViewCell()
            fatalError("The dequeued cell is not an instance of ArtTableViewCell.")
        }
        
        // Fetches the appropriate art for the data source layout.
        let art = Shared.sharedInstance.artsList[indexPath.row]
        
        //        //Assigns the values to cell
        //        cell.nameLabel.text = art.name
        //        cell.ratingControl.rating = art.rating
        
        
        //        fetchAndAssignPhoto(row: indexPath.row, cell: cell)
        cell.bindModel(ArtObject: art)
        self.fetchPhoto(row : indexPath.row, completion : { (image) in
            DispatchQueue.main.async {
                cell.bindImage(image: image)
            }
        })
        //Debug comments
        number+=1
        print("--- returning cell no. \(number)\n")
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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

    
    // MARK: - Navigation

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        super.prepare(for: segue, sender: sender)
//
//
//        guard let selectedCell = sender as? ArtTableViewCell else{
//            fatalError("sender is not ArtTableViewCell")
//        }
//
//        guard let indexPath = tableView.indexPath(for: selectedCell) else{
//            fatalError("Something wrong with selected cell")
//        }
//
//        let selectedArt = arts[indexPath.row]
//        let selectedPhoto = photoDict[indexPath.row] as? UIImage
//
//        guard let showArtViewController = segue.destination as? ViewController else{
//            fatalError("wrong destination of segue")
//        }
//
//        showArtViewController.art = selectedArt
//        showArtViewController.receivedPhoto = selectedPhoto
//    }
    

    
    //MARK: Private Methods
    
    
    private func gatherDataOneByOne(){
        
        print("Started gathering data")
        
        guard let url = URL(string: jsonURLString) else{print("Tumse nhp");return}
        
        //URL session for getting song name and photoURL of every song
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
            for (_,song) in songInfo.enumerated(){
                guard let name = song["name"] as? String else{print("nhp");return}
                guard let photoData = song["atw"] as? String else{print("nhp");return}
                guard let Art1 = Art(name: name,photo: nil, rating: Int.random(in: 1..<6),photoData: photoData ) else{print("nhp");return}
                Shared.sharedInstance.artsList += [Art1]
//                DispatchQueue.main.async {
//                    print("The index is \(index) and count is \(self.arts.count) ")
//                    self.tableView.beginUpdates()
//                    self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
//                    self.tableView.endUpdates()
//                }
            }
            
            
            //Reloading entire tableview to show the names and ratings
            DispatchQueue.main.async{
                self.tableView.reloadData()
                print("--- whole view was reloaded")

            }
        
            
            print("URL Session ended")
        }.resume()
        
    }
    
//    func fetchAndAssignPhoto(row:Int, cell: ArtTableViewCell){
//        print("--- cell image fetch called at \(row)")
//        if self.photoDict[row] == nil{
//            DispatchQueue.global().async {
//                print("--- cell image fetch at \(row)")
//                print("Download URL Session started")
//
//                guard let photo = self.photoDataDict[row] as? String else{print("nhp");return}
//
//                guard let url = URL(string: photo) else{print("nhp");return}
//                let photoData:Data
//
//                do{
//                    photoData = try Data(contentsOf: url)
//                }catch{print("nhp");return}
//
//                let image = UIImage(data: photoData)
//                self.photoDict[row] = image
//                //DispatchQueue.main.async{
//                    print("--- cell image set at \(row)")
//                    cell.photoImageView.image = self.photoDict[row] as? UIImage
//                //}
//                print("doing the step")
//
//                print("Download URL Session ended")
//
//            }
//        }
//        else{
//            cell.photoImageView.image = self.photoDict[row] as? UIImage
//        }
//    }
}
