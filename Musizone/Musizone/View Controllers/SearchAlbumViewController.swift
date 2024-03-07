//
//  SearchAlbumViewController.swift
//  Musizone
//
//  Created by Rohit Paul on 3/6/24.
//

import UIKit

class SearchAlbumViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var albumSearchBar: UISearchBar!
    @IBOutlet weak var albumSearchResultsTextView: UITextView!
    
    var allAlbums: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let textFieldInsideSearchBar = albumSearchBar?.value(forKey: "searchField") as? UITextField {
                    textFieldInsideSearchBar.textColor = .white
                }
            albumSearchBar.delegate = self
            albumSearchResultsTextView.isEditable = false

        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        let filteredAlbums = allAlbums.filter { $0.title.lowercased().contains(searchText.lowercased()) }

        updateTextView(with: filteredAlbums.first)
    }
    
    func updateTextView(with album: Album?) {
        if let album = album {
            let albumDetails = "\(album.title)"
            albumSearchResultsTextView.text = albumDetails
        } else {
            albumSearchResultsTextView.text = ""
        }
    }
    
    @IBAction func onCloseButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
