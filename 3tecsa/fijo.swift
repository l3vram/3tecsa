//
//  fijo.swift
//  3tecsa
//
//  Created by Marvel Alvarez on 1/13/17.
//  Copyright (c) 2017 Marvel Alvarez. All rights reserved.
//

import UIKit


class fijo {
    
    var number:String = ""
    var name:String = ""
    var address:String = ""
    
    
    init(number:String,name:String,address:String){
        self.number = number
        self.name = name
        self.address = address
        
        
    }
    
    func getNumber()->String{
    return number
    
    }
    func getName()->String{
        return name
        
    }
    func getAddress()->String{
        return address
        
    }
   }
