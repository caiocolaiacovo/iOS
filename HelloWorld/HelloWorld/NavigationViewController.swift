//
//  NavigationViewController.swift
//  HelloWorld
//
//  Created by Caio Colaiacovo on 12/02/17.
//  Copyright © 2017 Caio Colaiacovo. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    lazy var firstPageViewController: FirstPageViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        let viewController = storyboard.instantiateViewController(withIdentifier: "FirstPageViewController") as! FirstPageViewController

        

        return viewController
    }()
    
    lazy var secondPageViewController: SecondPageViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "SecondPageViewController") as! SecondPageViewController
        
        
        
        return viewController
    }()

    lazy var thridPageViewController: ThridPageViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "ThridPageViewController") as! ThridPageViewController
        
        
        
        return viewController
    }()
    
    private var numberOfMenus: Int!
    private var currentPosition = 1
    private var pages: [UIViewController]!
    
    private let rightPageNotification = Notification.Name("rightPage")
    private let leftPageNotification = Notification.Name("leftPage")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pages = [firstPageViewController, secondPageViewController, thridPageViewController] as [UIViewController]
        
        setViewControllers([pages[0]], animated: true)
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(NavigationViewController.methodOfReceivedNotification(notification:)), name: rightPageNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NavigationViewController.methodOfReceivedNotification(notification:)), name: leftPageNotification, object: nil)
        
        numberOfMenus = 3
    }
    
    func methodOfReceivedNotification(notification: Notification) {
        switch notification.name {
        case rightPageNotification:
            if currentPosition < numberOfMenus {
                pushViewController(pages[currentPosition], animated: true)
                
                currentPosition += 1
            }
        case leftPageNotification:
            if currentPosition > 1 {
                popViewController(animated: true)
                
                currentPosition -= 1
            }
        default: break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
