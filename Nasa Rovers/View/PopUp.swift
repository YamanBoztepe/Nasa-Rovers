//
//  PopUp.swift
//  Nasa Rovers
//
//  Created by Yaman Boztepe on 4.03.2021.
//

import UIKit

class PopUp: UIView {
    
    fileprivate let imgView: UIImageView = {
        let img = UIImageView()
        img.image?.withRenderingMode(.alwaysOriginal)
        return img
    }()
        
    fileprivate let lblDate = CustomLabel(text: "", textColor: .white, textAlignment: .center)
    fileprivate let lblRoverName = CustomLabel(text: "Rover Name: ", textColor: .white, textAlignment: .left)
    fileprivate let lblCameraName = CustomLabel(text: "Camera Name: ", textColor: .white, textAlignment: .left)
    fileprivate let lblStatus = CustomLabel(text: "Rover Status: ", textColor: .white, textAlignment: .left)
    fileprivate let lblLanding = CustomLabel(text: "Landing Date: ", textColor: .white, textAlignment: .left)
    fileprivate let lblLaunch = CustomLabel(text: "Launch Date: ", textColor: .white, textAlignment: .left)
    
    fileprivate let textStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        backgroundColor = .darkGray
        layer.cornerRadius = frame.width/15
        clipsToBounds = true
        
        [lblStatus,lblLaunch,lblLanding,lblRoverName,lblCameraName].forEach(textStackView.addArrangedSubview(_:))
        [imgView,lblDate,textStackView].forEach(addSubview(_:))
        
        _ = imgView.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10),size: .init(width: 0, height: frame.height/2))
        _ = lblDate.anchor(top: imgView.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10),size: .init(width: 0, height: frame.height/12))
        _ = textStackView.anchor(top: lblDate.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 10, right: 10))
        
    }
    
    func setData(data: NasaAPIList, image: UIImage) {
        
        lblDate.text = data.earthDate
        lblStatus.text! += data.status
        lblLaunch.text! += data.launchDate
        lblLanding.text! += data.landingDate
        lblRoverName.text! += data.roverName
        lblCameraName.text! += data.cameraName
        imgView.image = image
    }
}
