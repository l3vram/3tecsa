//
//  BuscarViewController.swift
//  3tecsa
//
//  Created by Marvel Alvarez on 1/12/17.
//  Copyright (c) 2017 Marvel Alvarez. All rights reserved.
//

import UIKit

class BuscarViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    
    
    
    @IBOutlet weak var Lista: UITableView!
    
    
   // @IBOutlet weak var buttonBuscar: UIButton!
    
    
    //var scrollView: UIScrollView
    var isloading = false
    
    var searchActive : Bool = false
    var data111 = []
    var filtered:[String] = []
    var listaMovil = [movil]()
    
    var filemgr = NSFileManager()
    var path = ""
    var database = FMDatabase()
    
    
    
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    var container: UIView = UIView()
    
    var lastLocation:CGPoint = CGPointMake(254, 202)
    var lastmovilnumber:String = "0"
    var lastfixnumber: String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        Lista.delegate = self
        Lista.dataSource = self
        searchbar.delegate = self
        
        filemgr = NSFileManager.defaultManager()
        path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0].stringByAppendingPathComponent("etecsa.db") as String
        database = FMDatabase(path: path)
        
        if !CheckDB(path){
            self.view.endEditing(false)
            alert("3tecsa",mensaje : "Verifique la Base de Datos")
            
        }
         
        var panRecognizer = UIPanGestureRecognizer(target:self, action:"detectPan:")
       // buttonBuscar.gestureRecognizers = [panRecognizer]
        
       // buttonBuscar.layer.shadowColor = UIColor.blackColor().CGColor
       // buttonBuscar.layer.shadowOffset = CGSizeMake(3, 3)
      //  buttonBuscar.layer.shadowRadius = 3
       // buttonBuscar.layer.shadowOpacity = 1.0
        
      //  buttonBuscar.enabled = false
        
        //listaMovil = [movil]()
        
    }
    //      barra *****
    //    override func viewDidAppear(animated: Bool) {
    //        var nav = self.navigationController?.navigationBar
    //        nav?.barStyle = UIBarStyle.Black
    //        nav?.tintColor = UIColor.yellowColor()
    //
    //        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    //        imageView.contentMode = .ScaleAspectFit
    //
    //        let image = UIImage(named: "Apple_Swift_Logo")
    //        imageView.image = image
    //
    //        navigationItem.titleView = imageView
    //    }
    
    
    @IBAction func Buscarboton(sender: UIButton) {
        //if (!searchActive){
        searchbar.resignFirstResponder()
        // }
    }
    
    
//    func detectPan(recognizer:UIPanGestureRecognizer) {
//        var translation  = recognizer.translationInView(buttonBuscar.superview!)
//        buttonBuscar.center = CGPointMake(lastLocation.x + translation.x,  lastLocation.y + translation.y)
//        
//        
//    }
//    
    
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
    
    func CheckDB(path:String)->Bool{
        
        if (filemgr.fileExistsAtPath(path) && filemgr.isReadableFileAtPath(path)){
            
            return true
        }
        
        return false
    }
    
    // search bar delegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
//        self.navigationController!.navigationBar.hidden = true
//        var r = self.view.frame
//        r.origin.y = -44
//        r.size.height += 44
        
      //  self.view.frame = r
        searchBar.setShowsCancelButton(true, animated: true)
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
        searchBar.setShowsCancelButton(false, animated: true)
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        searchbar.resignFirstResponder()
        
        //self.navigationController!.navigationBar.hidden = false
//        var r = self.view.frame
//        r.origin.y = +44
//        r.size.height = -44
//        self.view.frame = r
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if(!searchText.isEmpty){
          //  buttonBuscar.enabled = true
            
            var scop: String = ""
            if(searchBar.selectedScopeButtonIndex == 0){
                scop = "movil"
                
                doSearchL(scop, text1: self.searchbar.text)
            }
            if(searchBar.selectedScopeButtonIndex == 1){
                
                scop = "fix"
                
                doSearch(scop, text1: self.searchbar.text)
            }

            
        }else{
          //  buttonBuscar.enabled = false
            listaMovil = [movil]()
            Lista.reloadData()
        }
        
        
    }
    
    func doSearchL(scop:String,text1:String){
        
        lastfixnumber = ""
        lastmovilnumber = ""
        first = 1
        ShowActivityIndicator()
        
        //listaMovil = [movil]()
        //
        //        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        //        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        //        dispatch_async(backgroundQueue, {
        
        var texto = text1
        if(!texto.isEmpty){
            self.listaMovil = self.Buscar(texto,scope: scop,lmoviln:self.lastmovilnumber,lfixn:self.lastfixnumber,page:0)
        }
        
        
        //     dispatch_async(dispatch_get_main_queue(), { () -> Void in
        if(self.listaMovil.count == 0){
            self.searchActive = false;
        } else {
            self.searchActive = true;
            
        }
        self.Lista.reloadData()
        
        self.HideActivityIndicator()
        if (self.listaMovil.isEmpty){
            self.alert("3tecsa", mensaje: "Sin Resultados, verifique los datos")
        }
        //            })
        //        })
        
        
        
        
    }
    func doSearch(scop:String,text1:String){
        
        
        
        lastmovilnumber = ""
        lastfixnumber = ""
        
        ShowActivityIndicator()
        
        first = 1
        //listaMovil = [movil]()
        //
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            
            var texto = text1
            if(!texto.isEmpty){
                self.listaMovil = self.Buscar(texto,scope: scop,lmoviln:self.lastmovilnumber,lfixn:self.lastfixnumber,page:0)
            }
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if(self.listaMovil.count == 0){
                    self.searchActive = false;
                } else {
                    self.searchActive = true;
                    
                }
                self.Lista.reloadData()
                
                self.HideActivityIndicator()
                if (self.listaMovil.isEmpty){
                    self.alert("3tecsa", mensaje: "Sin Resultados, verifique los datos")
                }
            })
        })
    }
    var listatem = [movil]()
    func doSearchpage(scop:String,text1:String){
        
        
        ShowActivityIndicator()
        
        
        //
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            
            var texto = text1
            if(!texto.isEmpty){
                self.listatem = self.Buscar(texto,scope: scop,lmoviln:self.lastmovilnumber,lfixn:self.lastfixnumber,page:1)
                for i in self.listatem{
                    self.listaMovil.append(i)
                    
                }
                
            }
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if(self.listaMovil.count == 0){
                    self.searchActive = false;
                } else {
                    self.searchActive = true;
                    
                }
                self.Lista.reloadData()
                
                self.HideActivityIndicator()
                if (self.listaMovil.isEmpty){
                    self.alert("3tecsa", mensaje: "Sin Resultados, verifique los datos")
                }
            })
        })
        
    }
    
    
   
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        var scop = "none"
        
        searchbar.resignFirstResponder()
        if(searchBar.selectedScopeButtonIndex == 2){
            scop = "nombre"
            
            doSearch(scop, text1: self.searchbar.text)
            
        }
    }
    
    // cargando
    
    func  ShowActivityIndicator() {
        var uiView = self.view
        
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor( white: 0.1, alpha: 0.3)
        
        var loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(0, 0, 80, 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(white: 0.5, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        
        actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        actInd.center = CGPointMake(loadingView.frame.size.width / 2,
            loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
        
    }
    
    func  HideActivityIndicator(){
        
        actInd.stopAnimating()
        container.removeFromSuperview()
    }
    
    func Buscar(num:String,scope:String,lmoviln:String,lfixn:String,page:Int)->[movil]{
        
        var listaMovil1 = [movil]()
        
        var number = ""
        var name = ""
        var identification = ""
        var address = ""
        var province = ""
        
        
        if !database.open() {
            alert("Info", mensaje : "Unable to open database")
            return listaMovil1
        }
        
        var num1 = num.stringByReplacingOccurrencesOfString("+53 ", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch)
        num1 = num1.stringByReplacingOccurrencesOfString("53 ", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch)
        num1 = num1.stringByReplacingOccurrencesOfString(" Cuba", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch)
        
        var consulta = ""
        var consulta1 = ""
        
        if(page == 0){
          
            lastfixnumber = "0"
            lastmovilnumber = "0"
            
            consulta = "Select number,name,identification,address,province  from movil where number like '53\(num1)%'   order by movil.number limit 10"
            if scope == "fix"{
                consulta = "Select number,name,address,province  from fix where number like '\(num1)%' order by fix.number limit 10"
            }
            if scope == "nombre"{
                consulta = "SELECT number,name,identification,address,province FROM movil where movil.name like '\(num1)%' order by movil.number limit 5"
                
                consulta1 = "SELECT number,name,address,province FROM fix where fix.name like '\(num1)%' order by fix.number limit 5"
            }
            
        }else{
           
            consulta = "Select number,name,identification,address,province  from movil where number like '53\(num1)%' and number > '\(lastmovilnumber)' order by movil.number limit 10"
            if scope == "fix"{
                consulta = "Select number,name,address,province  from fix where number like '\(num1)%' and number > '\(lastfixnumber)'order by fix.number limit 10"
            }
            if scope == "nombre"{
                consulta = "SELECT number,name,identification,address,province FROM movil where movil.name like '\(num1)%' and number > '\(lastmovilnumber)' order by movil.number limit 5"
                
                consulta1 = "SELECT number,name,address,province FROM fix where fix.name like '\(num1)%' and number > '\(lastfixnumber)' order by fix.number limit 5"
            }
        }
        
        
        
        if let rs = database.executeQuery(consulta, withArgumentsInArray: nil) {
            while rs.next() {
                if scope == "movil"{
                    number = rs.stringForColumn("number")
                    name = rs.stringForColumn("name")
                    identification = rs.stringForColumn("identification")
                    address = rs.stringForColumn("address")
                    province = rs.stringForColumn("province")
                    lastmovilnumber = number
                }
                if scope == "fix"{
                    number = rs.stringForColumn("number")
                    name = rs.stringForColumn("name")
                    identification = "NO DISPONIBLE"
                    address = rs.stringForColumn("address")+" "+rs.stringForColumn("province")
                    lastfixnumber = number
                }
                if scope == "nombre"{
                    number = rs.stringForColumn("number")
                    name = rs.stringForColumn("name")
                    identification = rs.stringForColumn("identification")
                    address = rs.stringForColumn("address")
                    lastmovilnumber = number
                }
                
                
                var datosc = movil(number: number, name: name, identification: identification, address: address)
                listaMovil1.append(datosc)
                
                
            }
        }
        if (scope == "nombre"){
            if let rs = database.executeQuery(consulta1, withArgumentsInArray: nil) {
                while rs.next() {
                    
                    
                    number = rs.stringForColumn("number")
                    name = rs.stringForColumn("name")
                    identification = "NO DISPONIBLE"
                    address = rs.stringForColumn("address")+" "+rs.stringForColumn("province")
                    
                    //lastfixnumber = number
                    var datosc = movil(number: number, name: name, identification: identification, address: address)
                    listaMovil1.append(datosc)
                    lastfixnumber = number
                }
            }
        }
        
        
        
        return listaMovil1
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - tableview
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return listaMovil.count
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = Lista.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as!
        _tecsaTableViewCell
        
        let tempcell = listaMovil[indexPath.row]
        cell.labNombre.text = tempcell.name
        cell.labNumero.text = tempcell.number
        
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = uicolorFromHex(0x165F95)
        cell.selectedBackgroundView = backgroundView
        
        self.navigationController!.navigationBar.hidden = false
        
        return cell
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    // paginacion
    var first = 1
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
         //println(listaMovil.count)
        
        if !(indexPath.row + 1 < listaMovil.count ) {
            if (listatem.count != 0 || first == 1){
                isloading = true;
                first = 0
                var scope = ""
                if(searchbar.selectedScopeButtonIndex == 0){
                    scope = "movil"
                }
                if(searchbar.selectedScopeButtonIndex == 1){
                    scope = "fix"
                }
                if(searchbar.selectedScopeButtonIndex == 2){
                    scope = "nombre"
                }
                if (!self.searchbar.text.isEmpty){
                    doSearchpage(scope, text1: searchbar.text)
                }
            }
            
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        // let listatablascell = sender.   FotosTableViewController
        if segue.identifier == "detalle1"{
            
            let Detalle = segue.destinationViewController as! DetalleViewController
            if let cellseleccionada = sender as? _tecsaTableViewCell{
                let pos = Lista.indexPathForCell(cellseleccionada)!
                Detalle.objDatos = listaMovil[pos.row]
                
                //println("si envia")
                
            }
            
        }
    }
    
    
}
