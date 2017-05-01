//
//  FirstPageViewController.swift
//  HelloWorld
//
//  Created by Caio Colaiacovo on 29/01/17.
//  Copyright © 2017 Caio Colaiacovo. All rights reserved.
//

import UIKit

class FirstPageViewController: UIViewController {
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //let toViewController = segue.destination as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        //toViewController.transitioningDelegate = self
    }
}
