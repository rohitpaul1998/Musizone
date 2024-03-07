//
//  DisplaySongViewController.swift
//  Musizone
//
//  Created by Rohit Paul on 3/6/24.
//

import UIKit

class DisplaySongViewController: UIViewController {

    @IBOutlet weak var songDetailsScreenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displaySongDetails()
        // Do any additional setup after loading the view.
    }
    
    func displaySongDetails() {
        var yPosition: CGFloat = 200
                
        for song in DataMaster.shared.songs {
            let songDetailsLabel = UILabel()
            songDetailsLabel.textColor = .white
            songDetailsLabel.numberOfLines = 0
            songDetailsLabel.text = "Song ID: \(song.id), Artist ID: \(song.artistId)\nAlbum ID: \(song.albumId), Genre ID: \(song.genreId)\nTitle: \(song.title), Duration: \(song.duration)"
            
            // setting the frame for the label
            songDetailsLabel.frame = CGRect(x: 60, y: yPosition, width: view.frame.width - 40, height: 120)
            yPosition += 90

            view.addSubview(songDetailsLabel)
        }
    }
    
    @IBAction func onSearchSongButtonClicked(_ sender: UIButton) {
        let searchSongVC = SearchSongViewController(nibName: "SearchSongView", bundle: nil)
        searchSongVC.modalPresentationStyle = .fullScreen
        searchSongVC.allSongs = DataMaster.shared.songs
        self.present(searchSongVC, animated: true, completion: nil)
    }
    
    @IBAction func onCloseButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
