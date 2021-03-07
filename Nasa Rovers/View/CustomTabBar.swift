//
//  CustomTabBar.swift
//  Nasa Rovers
//
//  Created by Yaman Boztepe on 2.03.2021.
//

import UIKit

class CustomTabBar: UIView {
    
    let btnCuriosity: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Curiosity", for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    let btnOpportunity: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Opportunity", for: .normal)
        btn.tintColor = .gray
        return btn
    }()
    
    let btnSpirit: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Spirit", for: .normal)
        btn.tintColor = .gray
        return btn
    }()
    
    let tabBarSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.alignment = .center
        return sv
    }()
    
    var buttons = [UIButton]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        buttons = [btnCuriosity,btnOpportunity,btnSpirit]
        backgroundColor = .black
        
        [btnCuriosity,btnOpportunity,btnSpirit].forEach { tabBarSV.addArrangedSubview($0) }
        addSubview(tabBarSV)
        
        _ = tabBarSV.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: frame.height/3, bottom: 0, right: frame.height/3))
        
        [btnCuriosity,btnOpportunity,btnSpirit].forEach { $0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)}
    }

    
    @objc fileprivate func buttonPressed(btn: UIButton) {
        
        for button in buttons {
            if btn == button {
                button.tintColor = .white
            } else {
                button.tintColor = .gray
            }
        }
    }
}
