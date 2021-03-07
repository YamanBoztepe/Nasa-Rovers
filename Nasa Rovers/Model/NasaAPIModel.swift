//
//  NasaAPIModel.swift
//  Nasa Rovers
//
//  Created by Yaman Boztepe on 3.03.2021.
//

import Foundation


struct CameraDetails: Codable {
    let name: String
}

struct RoverDetails: Codable {
    let name: String
    let landingDate: String
    let launchDate: String
    let status: String
}

struct NasaAPIModel: Codable {
    let camera: CameraDetails
    let imgSrc: String
    let earthDate: String
    let rover: RoverDetails
}

struct Response: Codable {
    let photos: [NasaAPIModel]
}


struct NasaAPIList {
    
    let cameraName: String
    let roverName: String
    let landingDate: String
    let launchDate: String
    let status: String
    let imgSrc: URL
    let earthDate: String
    
    
    init(data: NasaAPIModel) {
        
        self.cameraName = data.camera.name
        self.roverName = data.rover.name
        self.landingDate = data.rover.landingDate
        self.launchDate = data.rover.launchDate
        self.status = data.rover.status
        self.earthDate = data.earthDate
        
        let imgUrl = URL(string: data.imgSrc)
        self.imgSrc = imgUrl!
        
    }
}
