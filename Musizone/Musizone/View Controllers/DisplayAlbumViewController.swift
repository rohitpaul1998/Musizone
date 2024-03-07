//
//  DisplayAlbumViewController.swift
//  Musizone
//
//  Created by Rohit Paul on 3/6/24.
//

import UIKit

class DisplayAlbumViewController: UIViewController {

    @IBOutlet weak var albumDetailsScreenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayAlbumDetails()

        // Do any additional setup after loading the view.
    }
    
    func displayAlbumDetails() {
        var yPosition: CGFloat = 200
        for album in DataMaster.shared.albums {
            let albumDetailsLabel = UILabel()
            albumDetailsLabel.textColor = .white
            albumDetailsLabel.numberOfLines = 0
            albumDetailsLabel.text = "Album ID: \(album.id) | Artist: \(album.artistId) Title: \(album.title)\n | Release Date: \(album.releaseDate)"

            albumDetailsLabel.frame = CGRect(x: 60, y: yPosition, width: view.frame.width - 40, height: 50)
            yPosition += 41

            view.addSubview(albumDetailsLabel)
        }
    }
    
    @IBAction func onCloseButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchAlbumButtonClicked(_ sender: UIButton) {
        let searchAlbumVC = SearchAlbumViewController(nibName: "SearchAlbumView", bundle: nil)
        searchAlbumVC.modalPresentationStyle = .fullScreen
        searchAlbumVC.allAlbums = DataMaster.shared.albums
        self.present(searchAlbumVC, animated: true, completion: nil)
    }
    
}
