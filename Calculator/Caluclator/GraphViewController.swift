//
//  ViewController.swift
//  Test
//
//  Created by Sameh on 11/1/17.
//  Copyright © 2017 Sameh. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    
    @IBOutlet weak var graphView: GraphView! { didSet {updateUI()} }

    func updateUI() {
        //graphView?.scale = 50.0
        graphView?.color = UIColor.blue
    }

}

