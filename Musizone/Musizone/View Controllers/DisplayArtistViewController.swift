//
//  DisplayArtistViewController.swift
//  Musizone
//
//  Created by Rohit Paul on 3/5/24.
//

import UIKit

class DisplayArtistViewController: UIViewController {
    
    @IBOutlet weak var artistDetailsScreenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayArtistDetails()

        // Do any additional setup after loading the view.
    }
    
    func displayArtistDetails() {
        var yPosition: CGFloat = 200
        for artist in DataMaster.shared.artists {
            let artistDetailsLabel = UILabel()
            artistDetailsLabel.textColor = .white
            artistDetailsLabel.numberOfLines = 0
            artistDetailsLabel.text = "Artist ID: \(artist.id) | Artist Name: \(artist.name)"
            
            // sets the frame for the label
            artistDetailsLabel.frame = CGRect(x: 60, y: yPosition, width: view.frame.width - 40, height: 50)
            yPosition += 20 // adjust vertical space b/w labels
            
            // pushes label to the view
            view.addSubview(artistDetailsLabel)
        }
    }

    @IBAction func onCloseButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onSearchArtistButtonClicked(_ sender: UIButton) {
        let searchArtistVC = SearchArtistViewController()
        searchArtistVC.modalPresentationStyle = .fullScreen
        searchArtistVC.allArtists = DataMaster.shared.artists
        self.present(searchArtistVC, animated: true, completion: nil)
    }
    
    
}
