//
//  TabBarController.swift
//  Nasa Rovers
//
//  Created by Yaman Boztepe on 2.03.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        setControllers()
    }
    
    fileprivate func setControllers() {
        
        setViewControllers(createControllers([CuriosityController(),OpportunityController(),SpiritController()],
                                            title: ["Curiosity","Opportunity","Spirit"]),
                                            animated: true)
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        tabBar.tintColor = .white
        tabBar.barTintColor = .black
        setTabBarIcons()
    }
    
    fileprivate func setTabBarIcons() {
        guard let items = tabBar.items else { return }
        
        for i in 0..<items.count {
            
            if items[i] == tabBar.selectedItem {
                items[i].image = UIImage(systemName: "largecircle.fill.circle")
            } else {
                items[i].image = UIImage(systemName: "circle")
            }
        }
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        setTabBarIcons()
    }
}
