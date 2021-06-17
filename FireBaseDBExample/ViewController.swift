//
//  ViewController.swift
//  FireBaseDBExample
//
//  Created by WonDongHyun on 2021/06/16.
//

import UIKit
import FirebaseDatabase


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refArtists: DatabaseReference!

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldGenre: UITextField!
    
    @IBOutlet weak var tblArtists: UITableView!
    
    @IBOutlet weak var labelMessage: UILabel!
    
    var artistsList = [ArtistModel]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistsList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let artist: ArtistModel
        
        artist = artistsList[indexPath.row]
        
        cell.lblName.text = artist.name
        cell.lblGenre.text = artist.genre
        
        return cell
    }
   
    
    
    @IBAction func buttonAddArtist(_ sender: Any) {
        addArtist()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        refArtists = Database.database().reference().child("artist")
        
        refArtists.observe(DataEventType.value, with: {(DataSnapshot) in
            if DataSnapshot.childrenCount > 0{
                self.artistsList.removeAll()
                
                for artists in DataSnapshot.children.allObjects as![DataSnapshot]{
                    let artistObject = artists.value as? [String:AnyObject]
                    let artistName = artistObject?["artistName"]
                    let artistGenre = artistObject?["artistGenre"]
                    let artistID = artistObject?["id"]
                    
                    let artist = ArtistModel(id: artistID as! String?, name: artistName as! String?, genre: artistGenre as! String?)
                    
                    self.artistsList.append(artist)
                }
                
                self.tblArtists.reloadData()
                
            }
            
            
        })
       
    }

    
    func addArtist(){
        let key = refArtists.childByAutoId().key
        
        let artists = ["id":key,
                       "artistName": textFieldName.text! as String,
                       "artistGenre": textFieldGenre.text! as String
        ]
        
        refArtists.child(key!).setValue(artists)
        
        labelMessage.text = "Artist Added"
        
    }

}

