//
//  CustomCell.swift
//  Nasa Rovers
//
//  Created by Yaman Boztepe on 3.03.2021.
//

import UIKit
import Alamofire
import AlamofireImage

class CustomCell: UICollectionViewCell {
    
    static let IDENTIFIER = "CustomCell"
    let imgSrc = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }

    fileprivate func setLayout() {
        
        addSubview(imgSrc)
        _ = imgSrc.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor,padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
        imgSrc.backgroundColor = .darkGray
        imgSrc.isUserInteractionEnabled = true
        
    }
    
    func setImage(url: URL) {
        AF.request(url).responseImage { (response) in
            if case .success(let img) = response.result {
                self.imgSrc.image = img
            }
        }
    }
}
