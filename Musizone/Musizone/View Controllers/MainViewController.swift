//
//  MainViewController.swift
//  Musizone
//
//  Created by Rohit Paul on 3/4/24.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var appNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onArtistManagerButtonClicked(_ sender: UIButton) {
        
        let artistManagerVC = ArtistViewController(nibName: "ArtistScreenView", bundle: nil)
        artistManagerVC.modalPresentationStyle = .fullScreen
        //        artistManagerVC.modalTransitionStyle = .
        self.present(artistManagerVC, animated: true, completion: nil)
        
    }
    
    @IBAction func onGenreManagerButtonClicked(_ sender: UIButton) {
        
        let genreManagerVC = GenreViewController(nibName: "GenreScreenView", bundle: nil)
        genreManagerVC.modalPresentationStyle = .fullScreen
        self.present(genreManagerVC, animated: true, completion: nil)
        
    }
    
    @IBAction func onAlbumManagerButtonClicked(_ sender: UIButton) {
        
        let albumManagerVC = AlbumViewController(nibName: "AlbumScreenView", bundle: nil)
        albumManagerVC.modalPresentationStyle = .fullScreen
        self.present(albumManagerVC, animated: true, completion: nil)
        
    }
    
    @IBAction func onSongManagerButtonClicked(_ sender: UIButton) {
        
        let songManagerVC = SongViewController(nibName: "SongScreenView", bundle: nil)
        songManagerVC.modalPresentationStyle = .fullScreen
        self.present(songManagerVC, animated: true, completion: nil)
        
    }
    
    
}
