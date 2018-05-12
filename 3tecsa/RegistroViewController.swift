//
//  ViewController.swift
//  3tecsa
//
//  Created by Marvel Alvarez on 12/21/16.
//  Copyright (c) 2016 Marvel Alvarez. All rights reserved.
//

import UIKit


class RegistroViewController: UIViewController , UISearchBarDelegate, UISearchControllerDelegate, UITableViewDelegate{
    
    
    
    @IBOutlet weak var label1: UILabel!
    
    
    @IBOutlet weak var label2: UILabel!
    
    
    @IBOutlet weak var error: UITextView!
    
    let transacLog = "/private/var/mobile/Library/CallHistoryTransactions/transaction.log"
    let callhistorydatabd = "/private/var/mobile/Library/CallHistoryDB/CallHistory.storedata"
    
    //var objT = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let filemgr = NSFileManager.defaultManager()
        let callhistorydatabd = "/private/var/mobile/Library/CallHistoryDB/CallHistory.storedata"
        
        let calldbexist = filemgr.fileExistsAtPath(callhistorydatabd)
        let transexist = filemgr.fileExistsAtPath(transacLog)
        if calldbexist && transexist && filemgr.isReadableFileAtPath(callhistorydatabd) && filemgr.isReadableFileAtPath(transacLog){
            
            
            label1.text = "lo veo y lo leo"
        }else{
            label1.text = "no"
        }
        
        //objT = loadDatos()!
        
        
        //error.text = objT[0].type
        
        //////  copy archive
        /*
        
        let fileManger = NSFileManager.defaultManager()
        var error : NSError?
        var doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! NSString
        let destinationPath = doumentDirectoryPath.stringByAppendingPathComponent("LocalDatabase1.sqlite")
        let sourcePath = NSBundle.mainBundle().pathForResource("LocalDatabase", ofType: "sqlite")
        fileManger.copyItemAtPath(sourcePath!, toPath: destinationPath, error: &error)
        
        
        
        
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let writePath = documents.stringByAppendingPathComponent("transaction.log")
        
        let array = NSArray(contentsOfFile: filePath)
        if let array = array {
        array.writeToFile(filePath, atomically: true)
        }
        
        let swiftArray = NSArray(contentsOfFile: filePath) as? [String]
        if let swiftArray = swiftArray {
        // now we can use Swift-native array methods
        find(swiftArray, "findable string")
        // cast back to NSArray to write
        (swiftArray as NSArray).writeToFile(filePath, atomically: true)
        }
        
        */
        
        
        
        
        
        
        
        
        //
        //        let filemgr = NSFileManager.defaultManager()
        //
        //        let calldb = filemgr.fileExistsAtPath("/private/var/wireless/Library/CallHistory/call_history.db")
        //        let dir = "/private/var/wireless/Library/CallHistory/call_history.db"
        //        error.text = filemgr.isReadableFileAtPath(dir).description
        //
        //        let database = FMDatabase(path: dir)
        //
        //        if !database.open() {
        //            error.text = "Unable to open database"
        //            return
        //        }
        //        if let rs = database.executeQuery("Select *  from call", withArgumentsInArray: nil) {
        //              while rs.next() {
        //            let address = rs.stringForColumn("address")
        //            let id = rs.stringForColumn("id")
        //
        //            label1.text = address + "address"
        //            label2.text = id + "id"
        //             }
        //        } else {
        //            error.text = "select failed: \(database.lastErrorMessage())"
        //        }
        //
        //        database.close()
        
        
        
        
        
        
        
        
        
        
        //
        //
//                let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
//                let path = documentsFolder.stringByAppendingPathComponent("etecsa.db")
        //
        //
        //
        //
        //
        //         let database = FMDatabase(path: path)
        //
        //        if !database.open() {
        //            error.text = "Unable to open database"
        //            return
        //        }
        //        if let rs = database.executeQuery("Select number,name  from movil where number like '%52405401'", withArgumentsInArray: nil) {
        //            while rs.next() {
        //                let num = rs.stringForColumn("number")
        //                let nom = rs.stringForColumn("name")
        //
        //                label1.text = nom
        //                label2.text = num
        //            }
        //        } else {
        //            error.text = "select failed: \(database.lastErrorMessage())"
        //        }
        //
        //        database.close()
        //println(path)
        
        
        /////**************
        //        let fileManager = NSFileManager.defaultManager();
        //       let dirnum = fileManager.enumeratorAtPath("/private/")
        //        var nextItem:NSString
        //
        //        while((dirnum?.nextObject()) != nil) {
        //            nextItem = dirnum?.nextObject() as! NSString
        //            if (nextItem.pathExtension == "db" || nextItem.pathExtension == "sqlitedb") {
        //                if (fileManager.isReadableFileAtPath(nextItem as String)) {
        //                    NSLog("%@", nextItem);
        //                }
        //            }
        //        }
    }
    
//    override func viewDidAppear(animated: Bool) {
//        var nav = self.navigationController?.navigationBar
//        nav?.barStyle = UIBarStyle.
//        nav?.tintColor = UIColor.yellowColor()
//        
////        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
////        imageView.contentMode = .ScaleAspectFit
////        
////        let image = UIImage(named: "buscar")
////        imageView.image = image
////        
////        navigationItem.titleView = imageView
//    }

    
    /*func loadDatos() -> [Transaction]? {
    return NSKeyedUnarchiver.unarchiveObjectWithFile(transacLog) as? [Transaction]
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

