//
//  JsonDownload.swift
//  Nasa Rovers
//
//  Created by Yaman Boztepe on 3.03.2021.
//

import Foundation

protocol JsonDownload {
    var jsonDownloader: NasaAPIDownload { get }
}
