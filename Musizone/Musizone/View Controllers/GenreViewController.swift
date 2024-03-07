//
//  GenreViewController.swift
//  Musizone
//
//  Created by Rohit Paul on 3/6/24.
//

import UIKit

class GenreViewController: UIViewController {

    @IBOutlet weak var genreScreenLabel: UILabel!
    @IBOutlet weak var genreIdTextField: UITextField!
    @IBOutlet weak var genreNameTextField: UITextField!
    
    var genres: [Genre] {
        get { DataMaster.shared.genres }
        set { DataMaster.shared.genres = newValue }
    }
    
    var songs: [Song] {
        get { DataMaster.shared.songs }
        set { DataMaster.shared.songs = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onAddGenreButtonClicked(_ sender: UIButton) {
        guard let genreIdString = genreIdTextField.text, let genreName = genreNameTextField.text,
              let id = Int(genreIdString), !genreName.isEmpty else {
            showAlert(title: "Error", message: "Please enter valid Genre ID and name.")
            return
        }
        
        // this is duplicate record check
        if genres.contains(where: { $0.id == id }) {
            showAlert(title: "Error", message: "Genre with the same ID already exists.")
            return
        }
        
        // this stores the data in genre array
        let newGenre = Genre(id: id, name: genreName)
        genres.append(newGenre)
        
        // clears out the text fields
        genreIdTextField.text = ""
        genreNameTextField.text = ""

        showAlert(title: "Success", message: "Genre added successfully.")
    }
    
    @IBAction func onUpdateGenreButtonClicked(_ sender: UIButton) {
        //  action popup to choose the artist to update
        let actionSheet = UIAlertController(title: "Choose Genre to Update", message: nil, preferredStyle: .actionSheet)
        
        // actions for each artist in the array
        for genre in genres {
            let action = UIAlertAction(title: genre.name, style: .default) { _ in
                // Show alert to input new name
                let alert = UIAlertController(title: "Enter New Name", message: nil, preferredStyle: .alert)
                alert.addTextField { textField in
                    textField.placeholder = "New Name"
                }
                
                // actions for updating or canceling
                let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
                    if let newName = alert.textFields?.first?.text {
                        if let index = self.genres.firstIndex(where: { $0.name == genre.name }) {
                            // Update the artist's name
                            self.genres[index].name = newName
                        }
                    }
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                alert.addAction(updateAction)
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true, completion: nil)
            }
            
            actionSheet.addAction(action)
        }
        
        // cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        // presents action sheet
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onDeleteGenreButtonClicked(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Choose Genre to Delete", message: nil, preferredStyle: .actionSheet)
        
        // action sheet with artists
        for genre in genres {
            let action = UIAlertAction(title: "\(genre.name)", style: .default) { _ in
                // checking if the genre is associated with any songs
                if self.isGenreAssociatedWithSongs(genreId: genre.id) {
                    // displaying an error popup asking the user to delete associated albums or songs first
                    self.showAlert(title: "Error", message: "Cannot delete genre with associated songs. Please delete the songs first.")
                } else {
                    // proceeds to delete the artist
                    if let index = self.genres.firstIndex(where: { $0.id == genre.id }) {
                        self.genres.remove(at: index)
                    }
                }
            }
            actionSheet.addAction(action)
        }

        // cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)

        self.present(actionSheet, animated: true, completion: nil)

    }
    
    // function to check if an genre is associated with any songs
    func isGenreAssociatedWithSongs(genreId: Int) -> Bool {
        return songs.contains(where: { $0.genreId == genreId })
    }
    
    @IBAction func onDisplayGenreButtonClicked(_ sender: UIButton) {
        let displayGenreVC = DisplayGenreViewController(nibName: "DisplayGenreView", bundle: nil)
        displayGenreVC.modalPresentationStyle = .fullScreen
        self.present(displayGenreVC, animated: true, completion: nil)
    }
    
    @IBAction func onCloseButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // alert function to display alerts
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
