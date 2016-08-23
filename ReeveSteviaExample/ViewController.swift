//
//  ViewController.swift
//  ReeveSteviaExample
//
//  Created by Reeve Yew on 23/08/2016.
//  Copyright © 2016 Reeve Yew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func loadView() { view = LoginView() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Here we want to reload the view after injection
        // this is only needed for live reload
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.view = LoginView()
        }
    }


}

