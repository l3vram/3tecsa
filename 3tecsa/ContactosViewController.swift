//
//  ContactosViewController.swift
//  3tecsa
//
//  Created by Marvel Alvarez on 6/6/17.
//  Copyright (c) 2017 Marvel Alvarez. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI
import CoreTelephony
//import TelephonyUtilities



class ContactosViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    
    @IBOutlet weak var Tabla: UITableView!
    
    var error: Unmanaged<CFError>?
    
    var searchActive:Bool = false
    
    var data:[String] = []
    var filtered:[String] = []
    
    let Ni = CTTelephonyNetworkInfo()
    let c = CTCallCenter()
    let call1 = CTCall()
    
    let addressBook: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Tabla.delegate = self
        Tabla.dataSource = self
        SearchBar.delegate = self
        
       
        self.AuthMethod()
        println(Ni.subscriberCellularProvider.description)
        if let call1 = c.callEventHandler {
        let cc = c.currentCalls
        println(cc)
        //println()
            
        }
        //c.callEventHandler = call1
       // println(c.currentCalls.)
        
//        let callcenter = CTCallCenter()
//        println (callcenter.currentCalls)
    }
    
    func AuthMethod(){
        let authorizationStatus = ABAddressBookGetAuthorizationStatus()
        
        switch authorizationStatus {
        case .Denied, .Restricted:
            //1
            
            //println("Denied")
            displayCantAddContactAlert()
        case .Authorized:
            //2
            gettodo()
            println("Authorized")
        case .NotDetermined:
            //3
            println("Not Determined")
            promptForAddressBookRequestAccess()
        }
    
    }
    
    func gettodo(){
        
        
        var data1:String = ""
        let allContacts = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as Array
        var petContact: ABRecordRef?
        
        for record in allContacts {
            data1 = ""
            let currentContact: ABRecordRef = record
            //ABGroupCopyArrayOfAllMembersWithSortOrdering(addressBook, sortOrdering: addressBook.)
            let currentContactName = ABRecordCopyCompositeName(currentContact).takeRetainedValue() as String
            
            let numero: ABMultiValue = ABRecordCopyValue( record, kABPersonPhoneProperty).takeRetainedValue()
          
            for i in 0 ..< ABMultiValueGetCount(numero) {
              
                let value = ABMultiValueCopyValueAtIndex(numero,i).takeRetainedValue() as! String
                
                var cel = dameMovil(value)
                if(cel.hasPrefix("5")){
                    data1 = cel
                break
                }
                
            }
            println("Nombre: \(currentContactName)  numero: \(data1)")
            data.append(data1)
        }
    }
    
    func dameMovil(value: String)->String{
        var cel = value
        
        var caracteres:[String] = [" "," ","(",")","-","+53 ","+53","*99"]
        for c in caracteres{
            cel = cel.stringByReplacingOccurrencesOfString(c, withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch)
            
        }
        
        
        return cel
    }
    
    func promptForAddressBookRequestAccess() {
        var err: Unmanaged<CFError>? = nil
        
        ABAddressBookRequestAccessWithCompletion(addressBook) {
            (granted: Bool, error: CFError!) in
            dispatch_async(dispatch_get_main_queue()) {
                if !granted {
                    println("Just denied")
                } else {
                    println("Just authorized")
                }
            }
        }
    }
    
    func openSettings() {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func displayCantAddContactAlert() {
        let cantAddContactAlert = UIAlertController(title: "Autorización:",
            message: "Debe dar autorización a la aplicacion para acceder a sus contactos.",
            preferredStyle: .Alert)
        cantAddContactAlert.addAction(UIAlertAction(title: "Cambiar Configuración",
            style: .Default,
            handler: { action in
                self.openSettings()
        }))
        cantAddContactAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        presentViewController(cantAddContactAlert, animated: true, completion: nil)
    }
    
    //
    //     func refreshContacts(){
    //
    //        var err: Unmanaged<CFError>? = nil
    //       //let addressBook: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
    //
    //
    //        let status = ABAddressBookGetAuthorizationStatus()
    //        if status == .Denied || status == .Restricted {
    //            // user previously denied, to tell them to fix that in settings
    //            return
    //        }
    //
    //        // open it
    //
    //
    ////        if addressBook.is {
    ////            println(error?.takeRetainedValue())
    ////            return
    ////        }
    //
    //        // request permission to use it
    //
    //        ABAddressBookRequestAccessWithCompletion(addressBook) {
    //            granted, error in
    //
    //            if !granted {
    //                // warn the user that because they just denied permission, this functionality won't work
    //                // also let them know that they have to fix this in settings
    //                return
    //            }
    //
    //            if let people = ABAddressBookCopyArrayOfAllPeople(self.addressBook)?.takeRetainedValue() as? NSArray {
    //                for person in people{
    //                    if let name = ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue() as? String {
    //                        println(name)//persons name
    //                    }
    //                    let numbers:ABMultiValue = ABRecordCopyValue(
    //                        person, kABPersonPhoneProperty).takeRetainedValue()
    //                    for ix in 0 ..< ABMultiValueGetCount(numbers) {
    //                        let label = ABMultiValueCopyLabelAtIndex(numbers,ix).takeRetainedValue() as? String
    //                        let value = ABMultiValueCopyValueAtIndex(numbers,ix).takeRetainedValue() as? String
    //                        println("Phonenumber \(label) is \(value)")
    //                    }
    //                }
    //
    //            }
    //        }
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        SearchBar.resignFirstResponder()
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            println(range.location)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.Tabla.reloadData()
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellc") as! UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row];
        }
        
        return cell;
    }
    
    
   
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell: UITableViewCell
//        //Lista.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as!
////        _tecsaTableViewCell
////        let tempcell = listaMovil[indexPath.row]
////        cell.labNombre.text = tempcell.name
////        cell.labNumero.text = tempcell.number
////        
//        return cell
//    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    // Override to support conditional editing of the table view.
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string:"tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                
          //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:12345,,#2"]];
              
                //application.openURL(phoneCallURL);
            }
        }
    }
    
//    private func callNumber1(number: String) {
//        let dialString = "telprompt://" + number
//        if let escapedDialString = dialString.unicodeScalars.insert("*", atIndex:){
//            if let dial = NSURL(string: escapedDialString) {
//                UIApplication.shared.openURL(dialURL)
//            }
//        }
//    }
    // Override to support editing the table view.
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {
        // 1
        var freecall = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "*99" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            var num = ""
           
               num = self.data[indexPath.row]
               //println(num)
               var num1 = "*" + num
               println(num1)
               self.callNumber(num1)
            
//            var url:NSURL = NSURL(string: "tel://*9954376285")!
//            UIApplication.sharedApplication().openURL(url)
//
//            if let url = NSURL(string: "telprompt://*9954376285") where UIApplication.sharedApplication().canOpenURL(url) {
//                
//                UIApplication.sharedApplication().openURL(url)
//                //self.alert("tt", mensaje: num)
//            
//            
//            }
            
            //self.alert("tt", mensaje: "mesaje")
            
            // 2
//            let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
//            
//            let gratiscall = UIAlertAction(title: "Marcar Con *99", style: UIAlertActionStyle.Default, handler: println(" marco con 99"))
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
//            
//            shareMenu.addAction(gratiscall)
//            shareMenu.addAction(cancelAction)
//            
//            
//            self.presentViewController(shareMenu, animated: true, completion: nil)
        })
        freecall.backgroundColor = UIColor.greenColor()
        // 3
        var rateAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "X" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // 4
            let rateMenu = UIAlertController(title: nil, message: "Elimirar Contacto", preferredStyle: .ActionSheet)
            
            let appRateAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            rateMenu.addAction(appRateAction)
            rateMenu.addAction(cancelAction)
            
            
            self.presentViewController(rateMenu, animated: true, completion: nil)
        })
        // 5
        return [rateAction,freecall]
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func alert(titulo:String,mensaje:String){
        
        //verfica version ios
        
        var device : UIDevice = UIDevice.currentDevice();
        var systemVersion = device.systemVersion;
        
        var iosVerion = systemVersion.toInt()
        if(iosVerion < 8) {
            let alert = UIAlertView()
            alert.title = titulo
            alert.message = mensaje
            alert.addButtonWithTitle("OK")
            alert.show()
        }else{
            var alert : UIAlertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style:.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }

    
}