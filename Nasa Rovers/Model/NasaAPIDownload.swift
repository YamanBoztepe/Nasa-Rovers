//
//  NasaAPIDownload.swift
//  Nasa Rovers
//
//  Created by Yaman Boztepe on 3.03.2021.
//

import Foundation
import Alamofire

class NasaAPIDownload {
    
    private var baseURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/"
    private let key = "0vd6RB5Dv4hIWACaSSmAFzMqF0FuUOgoKKhcAPa0"
    private var rover: Rovers
    
    init(rover: Rovers) {
        self.rover = rover
    }
    
    typealias NasaResponse = ([NasaAPIModel]?, NasaError?) -> Void
    
    func getData(inPage: Int, completionHandler completion: @escaping NasaResponse) {
        
        baseURL += self.rover.rawValue + "/photos?sol=1000&page=\(String(inPage))&api_key=\(self.key)"
        
        AF.request(baseURL).response { (response) in
            guard let data = response.data else { completion(nil,NasaError.invalidURL); return}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let results = try decoder.decode(Response.self, from: data)
                completion(results.photos,nil)
                
            } catch {
                print("Error Decoding = \(error.localizedDescription)")
                completion(nil,NasaError.JSONParsingError)
            }
        }
    }
}


enum Rovers: String {
    case Curiosity = "curiosity"
    case Opportunity = "opportunity"
    case Spirit = "spirit"
}

enum NasaError: LocalizedError {
    
    case invalidURL
    case JSONParsingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL is not invalid"
        case .JSONParsingError:
            return "Error in json parsing"
        }
    }
}
