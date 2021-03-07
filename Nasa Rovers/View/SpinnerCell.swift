//
//  SpinnerCell.swift
//  Nasa Rovers
//
//  Created by Yaman Boztepe on 5.03.2021.
//

import UIKit

class SpinnerCell: UICollectionViewCell {
    
    static let IDENTIFIER = "SpinnerCell"
    let spinner = UIActivityIndicatorView()
    
    fileprivate let lblText = CustomLabel(text: "Please Swipe Up", textColor: .white, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    func startSpinner() {
        
        lblText.isHidden = true
        addSubview(spinner)
        spinner.center = contentView.center
        spinner.startAnimating()
    }
    
    func stopSpinner(showMessage: Bool) {
        
        lblText.isHidden = false
        if showMessage {
            lblText.text = "There are no more photos"
        } else {
            lblText.text = "Please Swipe Up"
        }
        spinner.removeFromSuperview()
    }
    


    fileprivate func setLayout() {
        
        isUserInteractionEnabled = false
        addSubview(lblText)
        
        
        lblText.frame = bounds
        
        spinner.style = .large
        spinner.hidesWhenStopped = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
