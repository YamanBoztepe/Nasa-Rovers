//
//  NasaAPIDownloadTests.swift
//  Nasa RoversTests
//
//  Created by Yaman Boztepe on 7.03.2021.
//

import XCTest
import Alamofire
@testable import Nasa_Rovers

class NasaAPIDownloadTests: XCTestCase {

    let jsonDownloader = NasaAPIDownload(rover: .Curiosity)
    
    func test_get_data() {
        
        let e = expectation(description: "Alamofire")
        jsonDownloader.getData(inPage: 1) { (data, error) in
            
            if  error == nil {
                XCTAssertNotNil(data)
            } else {
                XCTAssertNil(data)
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    

}
