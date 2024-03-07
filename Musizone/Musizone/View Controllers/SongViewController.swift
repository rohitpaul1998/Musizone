//
//  SongViewController.swift
//  Musizone
//
//  Created by Rohit Paul on 3/6/24.
//

import UIKit

class SongViewController: UIViewController {

    @IBOutlet weak var songScreenLabel: UILabel!
    @IBOutlet weak var songIdTextField: UITextField!
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addSongButtonClicked(_ sender: UIButton) {
        guard let title = songTitleTextField?.text, !title.isEmpty,
                 let idString = songIdTextField?.text, let id = Int(idString),
                 let durationString = songDurationTextField?.text, let duration = Double(durationString) else {
               showAlert(title: "Error", message: "Please enter valid values for all fields.")
               return
           }
        
        // duplicate record check
            if DataMaster.shared.songs.contains(where: { $0.id == id }) {
                showAlert(title: "Error", message: "Song with ID \(id) already exists.")
                return
            }

           let newSong = Song(id: id, artistId: 0, albumId: 0, genreId: 0, title: title, duration: duration)
           chooseAlbumAndGenreForSong(newSong)
    }
    
    func chooseAlbumAndGenreForSong(_ song: Song) {
        let albumActionSheet = createActionSheet(title: "Choose Album", options: DataMaster.shared.albums) { selectedAlbum in
            self.chooseGenreForSong(song, selectedAlbum: selectedAlbum)
        }
        self.present(albumActionSheet, animated: true, completion: nil)
    }
    
    func chooseGenreForSong(_ song: Song, selectedAlbum: Album) {
        let genreActionSheet = createActionSheet(title: "Choose Genre", options: DataMaster.shared.genres) { selectedGenre in
            self.handleAlbumAndGenreSelectionForSong(song, selectedAlbum: selectedAlbum, selectedGenre: selectedGenre)
        }
        self.present(genreActionSheet, animated: true, completion: nil)
    }
    
    func handleAlbumAndGenreSelectionForSong(_ song: Song, selectedAlbum: Album, selectedGenre: Genre) {
        let updatedSong = Song(id: song.id, artistId: selectedAlbum.artistId, albumId: selectedAlbum.id, genreId: selectedGenre.id, title: song.title, duration: song.duration)

        DataMaster.shared.songs.append(updatedSong)

        showAlert(title: "Success", message: "Song added to album: \(selectedAlbum.title) with genre: \(selectedGenre.name)")

        songIdTextField?.text = ""
        songTitleTextField?.text = ""
        songDurationTextField?.text = ""
    }


    // method to create a generic action sheet
    func createActionSheet<T>(title: String, options: [T], handler: @escaping (T) -> Void) -> UIAlertController {
        let actionSheet = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)

        for option in options {
            if let name = (option as? Album)?.title ?? (option as? Genre)?.name {
                let action = UIAlertAction(title: name, style: .default) { _ in
                    handler(option)
                }
                actionSheet.addAction(action)
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)

        return actionSheet
    }
    
    
    @IBAction func updateSongButtonClicked(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Choose Song to Update", message: nil, preferredStyle: .actionSheet)

            for song in DataMaster.shared.songs {
                let action = UIAlertAction(title: song.title, style: .default) { _ in
                    self.showUpdateSongAlert(song: song)
                }
                actionSheet.addAction(action)
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            actionSheet.addAction(cancelAction)

            present(actionSheet, animated: true, completion: nil)
    }
    
    
    func showUpdateSongAlert(song: Song) {
        let alert = UIAlertController(title: "Update Song", message: nil, preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "New Title"
        }

        alert.addTextField { textField in
            textField.placeholder = "New Duration"
            textField.keyboardType = .numbersAndPunctuation
        }

        let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
            guard let newTitle = alert.textFields?[0].text,
                  let newDurationString = alert.textFields?[1].text,
                  let newDuration = Double(newDurationString) else {
                // Handle invalid input
                return
            }

            let updatedSong = Song(id: song.id, artistId: song.artistId, albumId: song.albumId, genreId: song.genreId, title: newTitle, duration: newDuration)

            if let index = DataMaster.shared.songs.firstIndex(where: { $0.id == song.id }) {
                DataMaster.shared.songs[index] = updatedSong
                self.showAlert(title: "Success", message: "Song updated successfully.")
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(updateAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteSongButtonClicked(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Choose Song to Delete", message: nil, preferredStyle: .actionSheet)

            for song in DataMaster.shared.songs {
                let action = UIAlertAction(title: song.title, style: .default) { _ in
                    // Proceed with the deletion
                    if let index = DataMaster.shared.songs.firstIndex(where: { $0.id == song.id }) {
                        DataMaster.shared.songs.remove(at: index)
                        self.showAlert(title: "Success", message: "Song deleted successfully.")
                    }
                }
                actionSheet.addAction(action)
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            actionSheet.addAction(cancelAction)

            present(actionSheet, animated: true, completion: nil)
    }
    
    
    @IBAction func displaySongButtonClicked(_ sender: UIButton) {
        let displaySongVC = DisplaySongViewController(nibName: "DisplaySongView", bundle: nil)
        displaySongVC.modalPresentationStyle = .fullScreen
        self.present(displaySongVC, animated: true, completion: nil)
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
