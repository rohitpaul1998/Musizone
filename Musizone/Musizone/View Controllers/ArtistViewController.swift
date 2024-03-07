//
//  ArtistViewController.swift
//  Musizone
//
//  Created by Rohit Paul on 3/4/24.
//

import UIKit

class ArtistViewController: UIViewController {
    
    // referencing models and creating arrays for data persistence
    var artists: [Artist] {
        get { DataMaster.shared.artists }
        set { DataMaster.shared.artists = newValue }
    }
    
    var albums: [Album] {
        get { DataMaster.shared.albums }
        set { DataMaster.shared.albums = newValue }
    }
    

    @IBOutlet weak var artistIDTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCloseArtistScreenButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // implementing the add functionality for artist creation
    @IBAction func onAddArtistButtonClicked(_ sender: UIButton) {
        guard let idString = artistIDTextField.text,
              let name = artistNameTextField.text,
              let id = Int(idString), !name.isEmpty else {
            showAlert(title: "Error", message: "Please enter valid artist ID and name.")
            return
        }
        
        // this is duplicate record check
        if artists.contains(where: { $0.id == id }) {
            showAlert(title: "Error", message: "Artist with the same ID already exists.")
            return
        }
        
        // this stores the data in artist array
        let newArtist = Artist(id: id, name: name)
        artists.append(newArtist)
        
        // clears out the text fields
        artistIDTextField.text = ""
        artistNameTextField.text = ""

        showAlert(title: "Success", message: "Artist added successfully.")
    }
    
    
    // implementing the update functionality for artist updation
    @IBAction func onUpdateArtistButtonClicked(_ sender: UIButton) {
        //  action popup to choose the artist to update
        let actionSheet = UIAlertController(title: "Choose Artist to Update", message: nil, preferredStyle: .actionSheet)
        
        // actions for each artist in the array
        for artist in artists {
            let action = UIAlertAction(title: artist.name, style: .default) { _ in
                // Show alert to input new name
                let alert = UIAlertController(title: "Enter New Name", message: nil, preferredStyle: .alert)
                alert.addTextField { textField in
                    textField.placeholder = "New Name"
                }
                
                // actions for updating or canceling
                let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
                    if let newName = alert.textFields?.first?.text {
                        if let index = self.artists.firstIndex(where: { $0.name == artist.name }) {
                            // Update the artist's name
                            self.artists[index].name = newName
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
        
        // Present the action sheet
        self.present(actionSheet, animated: true, completion: nil)
            
    }
    
    
    // implementing the delete functionality for artist deletion
    @IBAction func onDeleteArtistButtonClicked(_ sender: UIButton) {
        // action popup to choose the artist to delete
        let actionSheet = UIAlertController(title: "Choose Artist to Delete", message: nil, preferredStyle: .actionSheet)
        
        // action sheet with artists
        for artist in artists {
            let action = UIAlertAction(title: "\(artist.name)", style: .default) { _ in
                // checking if the artist is associated with any albums
                if self.isArtistAssociatedWithAlbums(artistId: artist.id) {
                    // displaying an error popup asking the user to delete associated albums or songs first
                    self.showAlert(title: "Error", message: "Cannot delete artist with associated albums. Please delete the albums first.")
                } else {
                    // proceeds to delete the artist
                    if let index = self.artists.firstIndex(where: { $0.id == artist.id }) {
                        self.artists.remove(at: index)
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
    
    //  function to check if an artist is associated with any albums
    func isArtistAssociatedWithAlbums(artistId: Int) -> Bool {
        return albums.contains(where: { $0.artistId == artistId })
    }
    
    // alert function to display alerts
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // displays the view for current artists on data
    
    @IBAction func onDisplayArtistButtonClicked(_ sender: UIButton) {
        let displayArtistVC = DisplayArtistViewController(nibName: "DisplayArtistView", bundle: nil)
        displayArtistVC.modalPresentationStyle = .fullScreen
        self.present(displayArtistVC, animated: true, completion: nil)
    }
    
}
