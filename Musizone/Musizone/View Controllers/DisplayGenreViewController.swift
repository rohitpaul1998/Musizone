//
//  DisplayGenreViewController.swift
//  Musizone
//
//  Created by Rohit Paul on 3/6/24.
//

import UIKit

class DisplayGenreViewController: UIViewController {

    @IBOutlet weak var genreDetailsScreenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayGenreDetails()
        // Do any additional setup after loading the view.
    }
    
    func displayGenreDetails() {
        var yPosition: CGFloat = 200
        for genre in DataMaster.shared.genres {
            let genreDetailsLabel = UILabel()
            genreDetailsLabel.textColor = .white
            genreDetailsLabel.numberOfLines = 0
            genreDetailsLabel.text = "Genre ID: \(genre.id) | Genre Name: \(genre.name)"
            
            genreDetailsLabel.frame = CGRect(x: 60, y: yPosition, width: view.frame.width - 40, height: 50)
            yPosition += 20 

            view.addSubview(genreDetailsLabel)
        }
    }
    
    @IBAction func onCloseButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchGenreButtonClicked(_ sender: UIButton) {
        let searchGenreVC = SearchGenreViewController(nibName: "SearchGenreView", bundle: nil)
        searchGenreVC.modalPresentationStyle = .fullScreen
        searchGenreVC.allGenres = DataMaster.shared.genres
        self.present(searchGenreVC, animated: true, completion: nil)
    }
    
}
