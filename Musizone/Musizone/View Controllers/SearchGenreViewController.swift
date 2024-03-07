//
//  SearchGenreViewController.swift
//  Musizone
//
//  Created by Rohit Paul on 3/6/24.
//

import UIKit

class SearchGenreViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var genreSearchBar: UISearchBar!
    @IBOutlet weak var searchResultTextView: UITextView!
    var allGenres: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let textFieldInsideSearchBar = genreSearchBar?.value(forKey: "searchField") as? UITextField {
                    textFieldInsideSearchBar.textColor = .white
                }
            genreSearchBar.delegate = self
            searchResultTextView.isEditable = false

        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // queries artists based on the entered text
        let filteredGenres = allGenres.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        // modifies UITextView with artist details
        updateTextView(with: filteredGenres.first)
    }
    
    func updateTextView(with genre: Genre?) {
        if let genre = genre {
            let genreDetails = "\(genre.name)"
            searchResultTextView.text = genreDetails
        } else {
            searchResultTextView.text = ""
        }
    }
    
    @IBAction func onCloseButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
