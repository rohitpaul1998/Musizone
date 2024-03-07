//
//  SearchArtistViewController.swift
//  Musizone
//
//  Created by Rohit Paul on 3/5/24.
//

import UIKit

class SearchArtistViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var artistSearchBar: UISearchBar!
    @IBOutlet weak var searchResultTextView: UITextView!
    var allArtists: [Artist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    if let textFieldInsideSearchBar = artistSearchBar?.value(forKey: "searchField") as? UITextField {
                textFieldInsideSearchBar.textColor = .white
            }
        artistSearchBar.delegate = self
        searchResultTextView.isEditable = false

        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // Filter artists based on the entered text
            let filteredArtists = allArtists.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            
            // Modifies UITextView with artist details
            updateTextView(with: filteredArtists.first)
        }
    
    func updateTextView(with artist: Artist?) {
            if let artist = artist {
                // shows artist details in the UITextView
                let artistDetails = "\(artist.name)"
                searchResultTextView.text = artistDetails
            } else {
                // clears UITextView if no artist is found
                searchResultTextView.text = ""
            }
        }
    
    @IBAction func onCloseButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
