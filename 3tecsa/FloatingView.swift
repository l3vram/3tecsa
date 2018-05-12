//
//  FloatingView.swift
//  3tecsa
//
//  Created by Marvel Alvarez on 5/25/17.
//  Copyright (c) 2017 Marvel Alvarez. All rights reserved.
//

import UIKit

class FloatingView: UIButton{

    //var x = CGPoint.
    
    var lastLocation:CGPoint = CGPointMake(254, 202)
    
     required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //self.center = lastLocation
        
        
        
        var panRecognizer = UIPanGestureRecognizer(target:self, action:"detectPan:")
        self.gestureRecognizers = [panRecognizer]
        
               
    }

    
    
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        var translation  = recognizer.translationInView(self.superview!)
        self.center = CGPointMake(lastLocation.x + translation.x,  lastLocation.y + translation.y)
        //lastLocation = self.center
    
        
    }
    
     override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // Promote the touched view
        self.superview?.bringSubviewToFront(self)
        
        // Remember original location
        lastLocation = self.center
       
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
