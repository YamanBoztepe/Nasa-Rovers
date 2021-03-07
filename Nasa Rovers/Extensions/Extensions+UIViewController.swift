//
//  Extensions+UIViewController.swift
//  Nasa Rovers
//
//  Created by Yaman Boztepe on 7.03.2021.
//

import UIKit

extension UIViewController {
    
    func createControllers(_ classType: [UIViewController], title: [String]) -> [UIViewController] {
        
        if classType.count == title.count {
            
            for i in 0..<classType.count {
                classType[i].title = title[i]
            }
        }
        return classType
    }
}
