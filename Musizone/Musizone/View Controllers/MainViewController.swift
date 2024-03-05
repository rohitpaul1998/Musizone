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
    
}
