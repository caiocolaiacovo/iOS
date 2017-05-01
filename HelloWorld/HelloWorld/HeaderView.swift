//
//  HeaderView.swift
//  HelloWorld
//
//  Created by Caio Colaiacovo on 24/01/17.
//  Copyright © 2017 Caio Colaiacovo. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var underlineView: UIView!
    
    private var numberOfMenus: Int!
    private var currentPosition = 1
    
    var centerConstraint: NSLayoutConstraint?
    var menuList: [String] = ["Menu 1", "Menu 2", "Menu 3"]
    
    // MARK: initialize methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UINib(nibName: "HeaderView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        
        underlineView.layer.cornerRadius = 2.0
        underlineView.clipsToBounds = true
        
        numberOfMenus = menuList.count
        
        setup()
        let rightPageNotification = Notification.Name("rightPage")
        let leftPageNotification = Notification.Name("leftPage")
        
        NotificationCenter.default.addObserver(self, selector: #selector(HeaderView.nextMenu), name: rightPageNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HeaderView.previousMenu), name: leftPageNotification, object: nil)
    }
    
    func setup() {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        //container.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.1)
        
        view.addSubview(container)
        
        let containerWidthConstraint = NSLayoutConstraint(item: container, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        containerWidthConstraint.isActive = true
        centerConstraint = NSLayoutConstraint(item: container, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: -50.0)
        centerConstraint?.isActive = true
        NSLayoutConstraint(item: container, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: container, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0.0).isActive = true
        
        //Store the previous menu view
        var previousMenu: UIView?
        
        for (index, menuText) in menuList.enumerated() {
            let menuLabel = UILabel()
            menuLabel.translatesAutoresizingMaskIntoConstraints = false
            menuLabel.text = menuText
            
            let menuView = UIView()
            menuView.translatesAutoresizingMaskIntoConstraints = false
            menuView.addSubview(menuLabel)
            
            NSLayoutConstraint(item: menuLabel, attribute: .centerX, relatedBy: .equal, toItem: menuView, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: menuLabel, attribute: .centerY, relatedBy: .equal, toItem: menuView, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
            
            container.addSubview(menuView)
            
            NSLayoutConstraint(item: menuView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100).isActive = true
            
            if index == 0 {
                //First menu, needs to be centralized in the container view
                NSLayoutConstraint(item: menuView, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
                NSLayoutConstraint(item: menuView, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
                NSLayoutConstraint(item: menuView, attribute: .height, relatedBy: .equal, toItem: container, attribute: .height, multiplier: 1.0, constant: 0.0).isActive = true
                
                //menuView.backgroundColor = .red
            }
            else {
                containerWidthConstraint.constant += 100
                
                //For the next menus, align side-by-side
                NSLayoutConstraint(item: menuView, attribute: .leading, relatedBy: .equal, toItem: previousMenu, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
                NSLayoutConstraint(item: menuView, attribute: .centerY, relatedBy: .equal, toItem: previousMenu, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
                NSLayoutConstraint(item: menuView, attribute: .height, relatedBy: .equal, toItem: previousMenu, attribute: .height, multiplier: 1.0, constant: 0.0).isActive = true
                
                //menuView.backgroundColor = .blue
            }
            
            previousMenu = menuView
        }
    }
    
    func previousMenu() {
        if currentPosition > 1 {
            currentPosition -= 1
            centerConstraint?.constant += 100
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.layoutIfNeeded()
                //self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func nextMenu() {
        if currentPosition < numberOfMenus {
            currentPosition += 1
            centerConstraint?.constant -= 100
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.layoutIfNeeded()
                //self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
