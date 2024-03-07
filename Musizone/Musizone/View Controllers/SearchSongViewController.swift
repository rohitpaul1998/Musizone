//
//  SearchSongViewController.swift
//  Musizone
//
//  Created by Rohit Paul on 3/6/24.
//

import UIKit

class SearchSongViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var songSearchBar: UISearchBar!
    @IBOutlet weak var songSearchResultsTextView: UITextView!
    var allSongs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let textFieldInsideSearchBar = songSearchBar?.value(forKey: "searchField") as? UITextField {
                    textFieldInsideSearchBar.textColor = .white
                }
            songSearchBar.delegate = self
            songSearchResultsTextView.isEditable = false

        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filteredSongs = allSongs.filter { $0.title.lowercased().contains(searchText.lowercased()) }

        updateTextView(with: filteredSongs.first)
    }
    
    func updateTextView(with song: Song?) {
        if let song = song {
            let songDetails = "\(song.title)"
            songSearchResultsTextView.text = songDetails
        } else {
            songSearchResultsTextView.text = ""
        }
    }
    
    @IBAction func onCloseButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
