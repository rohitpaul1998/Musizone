//
//  AlbumViewController.swift
//  Musizone
//
//  Created by Rohit Paul on 3/6/24.
//

import UIKit

class AlbumViewController: UIViewController {
    
    @IBOutlet weak var albumScreenLabel: UILabel!
    @IBOutlet weak var albumIdTextField: UITextField!
    @IBOutlet weak var albumTitleTextField: UITextField!
    @IBOutlet weak var albumReleaseDateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addAlbumButtonClicked(_ sender: UIButton) {
        guard let idString = albumIdTextField?.text, let id = Int(idString),
                  let title = albumTitleTextField?.text, !title.isEmpty,
                  let releaseDate = albumReleaseDateTextField?.text, !releaseDate.isEmpty else {
                showAlert(title: "Error", message: "Please enter valid ID, title, and release date.")
                return
            }
            
            //  if an album with the same ID already exists
            if DataMaster.shared.albums.contains(where: { $0.id == id }) {
                showAlert(title: "Error", message: "Album with ID \(id) already exists.")
                return
            }

            let actionSheet = UIAlertController(title: "Choose Artist", message: nil, preferredStyle: .actionSheet)
            for artist in DataMaster.shared.artists {
                let action = UIAlertAction(title: artist.name, style: .default) { _ in
                    // creates and adds the new album
                    let newAlbum = Album(id: id, artistId: artist.id, title: title, releaseDate: releaseDate)
                    DataMaster.shared.albums.append(newAlbum) // started with self.
                    // success alert
                    self.showAlert(title: "Success", message: "Album added successfully.")
                    // clears the text fields
                    self.albumIdTextField?.text = ""
                    self.albumTitleTextField?.text = ""
                    self.albumReleaseDateTextField?.text = ""
                }
                actionSheet.addAction(action)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            actionSheet.addAction(cancelAction)
            self.present(actionSheet, animated: true, completion: nil)
            
    }
    
    @IBAction func updateAlbumButtonClicked(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Choose Album to Update", message: nil, preferredStyle: .actionSheet)

            // actions for each album in the shared data
        for album in DataMaster.shared.albums {
            let action = UIAlertAction(title: album.title, style: .default) { _ in
                self.showUpdateAlert(for: album)
            }
            actionSheet.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }
    
    func showUpdateAlert(for album: Album) {
        let alert = UIAlertController(title: "Enter Details to Update ", message: nil, preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "New Title"
        }

        alert.addTextField { textField in
            textField.placeholder = "New Release Date"
        }

        let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
            guard let newTitle = alert.textFields?[0].text, !newTitle.isEmpty,
                  let newReleaseDate = alert.textFields?[1].text, !newReleaseDate.isEmpty else {
                // error handling if in update alert fields are left empty
                let errorAlert = UIAlertController(title: "Error", message: "Please enter both title and release date.", preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                
                return
            }

            // modify selected album with new details
            if let index = DataMaster.shared.albums.firstIndex(where: { $0.id == album.id }) {
                DataMaster.shared.albums[index].title = newTitle
                DataMaster.shared.albums[index].releaseDate = newReleaseDate

                //  success alert
                let successAlert = UIAlertController(title: "Success", message: "Album details updated successfully.", preferredStyle: .alert)
                successAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(successAlert, animated: true, completion: nil)
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(updateAction)

        present(alert, animated: true, completion: nil)
    }

    
    @IBAction func deleteAlbumButtonClicked(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Choose Album to Delete", message: nil, preferredStyle: .actionSheet)
            
        // actions for each album in the array
        for album in DataMaster.shared.albums {
            let action = UIAlertAction(title: album.title, style: .default) { _ in
                // checks if album has song association
                if self.isAlbumAssociatedWithSongs(albumId: album.id) {
                    // error popup asking the user to delete associated songs first
                    self.showAlert(title: "Error", message: "Cannot delete album with associated songs. Please delete the songs first.")
                } else {
                    // proceeds to deletion
                    if let index = DataMaster.shared.albums.firstIndex(where: { $0.id == album.id }) {
                        DataMaster.shared.albums.remove(at: index)
                        //  success alert
                        self.showAlert(title: "Success", message: "Album deleted successfully.")
                    }
                }
            }
            actionSheet.addAction(action)
        }
        
        // cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        // action sheet
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // function to check if the selected album has a song association
    func isAlbumAssociatedWithSongs(albumId: Int) -> Bool {
        return DataMaster.shared.songs.contains(where: { $0.albumId == albumId })
    }
    
    @IBAction func displayAlbumButtonClicked(_ sender: UIButton) {
        let displayAlbumVC = DisplayAlbumViewController(nibName: "DisplayAlbumView", bundle: nil)
        displayAlbumVC.modalPresentationStyle = .fullScreen
        self.present(displayAlbumVC, animated: true, completion: nil)
    }
    
    @IBAction func onClickCloseButton(_ sender: UIButton) {
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
