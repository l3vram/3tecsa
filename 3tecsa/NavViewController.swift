//
//  NavViewController.swift
//  3tecsa
//
//  Created by Marvel Alvarez on 6/22/17.
//  Copyright (c) 2017 Marvel Alvarez. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var imageView = UIImageView(frame: self.view.frame)
        var image = UIImage(named: "ok1")!
        
        imageView.image = image
        imageView.backgroundColor = UIColor.redColor()
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
     //    Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
