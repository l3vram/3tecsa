//
//  DetalleViewController.swift
//  3tecsa
//
//  Created by Marvel Alvarez on 8/23/17.
//  Copyright (c) 2017 Marvel Alvarez. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController,UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tabla: UITableView!
    
    
    
    @IBOutlet weak var Actiontable: UITableView!

    
    var objDatos : movil?
    
    var number:String = ""
    var name:String = ""
    var ci = ""
    var dir:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if objDatos != nil{
            
            name = objDatos!.name
            number = objDatos!.number
            ci = objDatos!.identification
            dir = objDatos!.getAddress()
            
          
        }
        tabla.delegate = self
        tabla.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }
   
    
//    @IBAction func Bllamar(sender: AnyObject) {
//    }
//    
//    
//    @IBAction func Bmensaje(sender: AnyObject) {
//    }
//    
//    
//    @IBAction func BaddContact(sender: AnyObject) {
//    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let tmpTableItem = tabla.dequeueReusableCellWithIdentifier("nom") as! NombreTableViewCell
        
        //let cell : UITableViewCell
        
        if indexPath.row  == 0 {
            
            let cell = tabla.dequeueReusableCellWithIdentifier("nom", forIndexPath: indexPath) as! NombreTableViewCell
            cell.nom.text = name
            return cell
        }else if indexPath.row  == 1 {
            let cell = tabla.dequeueReusableCellWithIdentifier("tel", forIndexPath: indexPath) as! TelTableViewCell
            cell.tel.text = number
            return cell
        }else if indexPath.row  == 2 {
            let cell = tabla.dequeueReusableCellWithIdentifier("fechan", forIndexPath: indexPath) as! FechaNTableViewCell
            cell.fechaN.text = ci
            return cell
        }else {
            let cell = tabla.dequeueReusableCellWithIdentifier("dir", forIndexPath: indexPath) as! DirTableViewCell
            cell.Dir.text = dir
            return cell
        }
        
        //        let backgroundView = UIView()
        //        backgroundView.backgroundColor = uicolorFromHex(0xB43339)
        //        cell.selectedBackgroundView = backgroundView
        //return cell
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
    
     return 60
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        // Get the new view controller using segue.destinationViewController.
    //        // Pass the selected object to the new view controller.
    //
    //        if segue.identifier == "detalle1"{
    //
    //            name = objDatos!.name
    //            println("coj \(name)")
    ////            let nombre = NTField.text ?? ""
    ////            let foto = imagenes.image
    ////
    ////            objDatos = Foto(nombre: nombre, foto: foto)
    //        }
    //
    //    }
    
    
}
