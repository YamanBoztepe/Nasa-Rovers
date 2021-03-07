//
//  Extensions+UIView.swift
//  Nasa Rovers
//
//  Created by Yaman Boztepe on 2.03.2021.
//

import UIKit

class CustomLabel: UILabel {
    
    init(text: String, textColor: UIColor, textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct AnchorConstraint {
    
    var top: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    var leading: NSLayoutConstraint?
    var trailing: NSLayoutConstraint?
    var height: NSLayoutConstraint?
    var width: NSLayoutConstraint?
}

extension UIView {
    
    func anchor( top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchorConstraint {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchorConstraint = AnchorConstraint()
        
        if let top = top {
            anchorConstraint.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let bottom = bottom {
            anchorConstraint.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let leading = leading {
            anchorConstraint.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let trailing = trailing {
            anchorConstraint.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchorConstraint.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchorConstraint.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchorConstraint.top, anchorConstraint.bottom, anchorConstraint.leading, anchorConstraint.trailing, anchorConstraint.height, anchorConstraint.width].forEach { $0?.isActive = true }
        
        return anchorConstraint
    }
    
    func positionInCenterSuperView(size: CGSize = .zero, centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func animateIn(_ popUp: PopUp) {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(blurPressed))
        blurView.addGestureRecognizer(gesture)
        
        self.addSubview(blurView)
        self.bringSubviewToFront(popUp)
        blurView.frame = self.bounds
        [blurView,popUp].forEach { $0.alpha = 0 }
        
        UIView.animate(withDuration: 0.5) {
            blurView.alpha = 1
            popUp.alpha = 1
        }
        
    }
    
    @objc fileprivate func blurPressed() {
        
        for subview in self.subviews {
            if (subview.isKind(of: UIVisualEffectView.self)) || (subview.isKind(of: PopUp.self)) {
                subview.removeFromSuperview()
            }
        }
    }
}

