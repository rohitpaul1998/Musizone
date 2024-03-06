//
//  DisplayGenreViewController.swift
//  Musizone
//
//  Created by Rohit Paul on 3/6/24.
//

import UIKit

class DisplayGenreViewController: UIViewController {

    @IBOutlet weak var genreDetailsScreenLabel: UILabel!
    
    var genres: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayGenreDetails()
        // Do any additional setup after loading the view.
    }
    
    func displayGenreDetails() {
        var yPosition: CGFloat = 200
        for genre in genres {
            let genreDetailsLabel = UILabel()
            genreDetailsLabel.textColor = .white
            genreDetailsLabel.numberOfLines = 0
            genreDetailsLabel.text = "Genre ID: \(genre.id) | Genre Name: \(genre.name)"
            
            // Set the frame for the label
            genreDetailsLabel.frame = CGRect(x: 60, y: yPosition, width: view.frame.width - 40, height: 50)
            yPosition += 20 // Adjust the vertical spacing between labels
            
            // Add the label to the view
            view.addSubview(genreDetailsLabel)
        }
    }
    
    @IBAction func onCloseButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchGenreButtonClicked(_ sender: UIButton) {
        let searchGenreVC = SearchGenreViewController(nibName: "SearchGenreView", bundle: nil)
        searchGenreVC.modalPresentationStyle = .fullScreen
        searchGenreVC.allGenres = genres
        self.present(searchGenreVC, animated: true, completion: nil)
    }
    
}
