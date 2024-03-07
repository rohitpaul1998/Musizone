//
//  DataMaster.swift
//  Musizone
//
//  Created by Rohit Paul on 3/6/24.
//

import Foundation

class DataMaster {
    static let shared = DataMaster()
    var artists: [Artist] = []
    var albums: [Album] = []
    var songs: [Song] = []
    var genres: [Genre] = []
}
