//
//  CustomTopBar.swift
//  Nasa Rovers
//
//  Created by Yaman Boztepe on 2.03.2021.
//

import UIKit

class CustomTopBar: UIView {
    
    let lblText = CustomLabel(text: "Curiosity", textColor: .lightGray, textAlignment: .center)
    
    let filterButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Filter", for: .normal)
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        backgroundColor = .black
        [lblText,filterButton].forEach { addSubview($0) }
        
        lblText.positionInCenterSuperView(centerX: centerXAnchor, centerY: centerYAnchor)
        filterButton.positionInCenterSuperView(centerX: nil, centerY: centerYAnchor)
        
        _ = filterButton.anchor(top: nil, bottom: nil, leading: nil, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: frame.height/5))
        
        lblText.font = UIFont.boldSystemFont(ofSize: frame.height/2)
    }
}
