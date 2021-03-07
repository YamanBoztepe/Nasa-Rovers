//
//  OpportunityController.swift
//  Nasa Rovers
//
//  Created by Yaman Boztepe on 2.03.2021.
//

import UIKit

class OpportunityController: CuriosityController {

    override var jsonDownloader: NasaAPIDownload {
        return NasaAPIDownload(rover: .Opportunity)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBar.lblText.text = "Opportunity"
    }
    
    
}
