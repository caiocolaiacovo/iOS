//
//  MainViewController.swift
//  HelloWorld
//
//  Created by Caio Colaiacovo on 27/01/17.
//  Copyright © 2017 Caio Colaiacovo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Class attributes
    
    @IBOutlet weak var headerView: HeaderView!
    
    private let tapRecognizer = UITapGestureRecognizer()
    private let leftSwipeRecognizer = UISwipeGestureRecognizer()
    private let rightSwipeRecognizer = UISwipeGestureRecognizer()
    
    private var rightSide: CGFloat!
    private var leftSide: CGFloat!
    
    private let rightPageNotification = Notification.Name("rightPage")
    private let leftPageNotification = Notification.Name("leftPage")
    
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecognizers()
        
        rightSide = self.view.bounds.width / 2 + 50
        leftSide = self.view.bounds.width / 2 - 50
    }
    
    
    // MARK: - Gesture Recognizers and handler methods
    
    private func setupRecognizers() {
        tapRecognizer.addTarget(self, action: #selector(MainViewController.tappedView(touch: )))
        leftSwipeRecognizer.addTarget(self, action: #selector(MainViewController.respondToSwipeGesture(gesture:)))
        leftSwipeRecognizer.direction = .left
        rightSwipeRecognizer.addTarget(self, action: #selector(MainViewController.respondToSwipeGesture(gesture:)))
        rightSwipeRecognizer.direction = .right
        
        headerView.gestureRecognizers = [tapRecognizer]
        self.view.gestureRecognizers = [leftSwipeRecognizer, rightSwipeRecognizer]
        self.view.isUserInteractionEnabled = true
    }
    
    func tappedView(touch: UITapGestureRecognizer) {
        let coordinates = touch.location(in: self.headerView)
        
        if coordinates.x >= rightSide {
            NotificationCenter.default.post(name: rightPageNotification, object: nil)
        }
        else if coordinates.x <= leftSide {
            NotificationCenter.default.post(name: leftPageNotification, object: nil)
        }
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                NotificationCenter.default.post(name: rightPageNotification, object: nil); print("Swiped left")
            case UISwipeGestureRecognizerDirection.right:
                NotificationCenter.default.post(name: leftPageNotification, object: nil); print("Swiped right")
            default:
                print("default gesture")
                break
            }
        }
    }
    
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue for embed view")
    }
}
