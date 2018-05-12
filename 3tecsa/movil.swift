//
//  movil.swift
//  3tecsa
//
//  Created by Marvel Alvarez on 1/13/17.
//  Copyright (c) 2017 Marvel Alvarez. All rights reserved.
//

import UIKit


class movil {
    
    var number:String = ""
    var name:String = ""
    var identification = ""
    var address:String = ""
    
    
    init(number:String,name:String,identification:String,address:String){
        self.number = number
        self.name = name
        self.identification = identification
        self.address = address
       
        
    }
    
    func getNumber()->String{
        return number
        
    }
    func getName()->String{
        return name
        
    }
    func getIdentification()->String{
        return identification
        
    }
    func getAddress()->String{
        return address
        
    }
}
