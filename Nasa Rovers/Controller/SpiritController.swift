//
//  SpiritController.swift
//  Nasa Rovers
//
//  Created by Yaman Boztepe on 2.03.2021.
//

import UIKit

class SpiritController: CuriosityController {
    
    override var jsonDownloader: NasaAPIDownload {
        return NasaAPIDownload(rover: .Spirit)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBar.lblText.text = "Spirit"
    }
    
}
