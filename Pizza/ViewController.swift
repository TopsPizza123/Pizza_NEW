//
//  ViewController.swift
//  Pizza
//
//  Created by TOPS on 8/7/18.
//  Copyright © 2018 TOPS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CAAnimationDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate{
    
    var flg  = 0;
    var mainview  = UIView()
    
    
    var backgroudview = UIView();
    var tbl = UITableView();
    @IBOutlet weak var maintable: UITableView!
    
    @IBOutlet weak var menutable: UITableView!
    
    @IBOutlet weak var LeadingConstrain: NSLayoutConstraint!
    @IBOutlet weak var MenuView: UIView!
    
    var menuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navbar();
        //swipegesture();
       // MenuView.layer.opacity = 1
       // MenuView.layer.shadowRadius = 6
    }
    
    
    func navbar()  {
    
        
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height:  50));
        
        let navitem = UINavigationItem();
        
        
        let btn = UIButton(type: .custom);
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
        btn.setImage(UIImage(named: "SideBar"), for: .normal);
        btn.addTarget(self, action: #selector(self.menubutton), for: .touchUpInside);
        
        let menubutton = UIBarButtonItem(customView: btn);
        navitem.leftBarButtonItem = menubutton;
        navbar.items = [navitem];
        
        self.view.addSubview(navbar);
        
        
        
        
    }
  
    
    func menubutton(sender:UIButton) {
       if flg == 0{
         showmenu()
        }
        else
        {
            hidemenu()
        }
    }
    
    func showmenu(){
        mainview = UIView(frame: CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: self.view.frame.size.height-50));
        mainview.backgroundColor = UIColor.gray;
        mainview.alpha = 0.3;
        mainview.isUserInteractionEnabled = true;
        self.view.addSubview(mainview);
        
        
        tapgesture()
        
        backgroudview = UIView(frame: CGRect(x: 0, y: 50, width: 0, height: self.view.frame.size.height));
        backgroudview.backgroundColor = UIColor.gray;
        
        backgroudview.alpha = 1;
        tbl = UITableView(frame: CGRect(x: 0, y: 50, width: 0, height: self.view.frame.size.height-50));
        //footer remove after cell
        tbl.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0));
        tbl.tag = 2;
        
        tbl.dataSource = self;
        tbl.delegate = self;
        
        self.view.addSubview(tbl);
        
        
        
        //self.view.addSubview(backgroudview);
        
        UITableView.beginAnimations(nil, context: nil);
        UITableView.setAnimationDuration(0.6);
        tbl.frame = CGRect(x: 0, y: 50, width: 200, height: self.view.frame.size.height-50)
        
        UITableView.commitAnimations();
        flg = 1;
        

    }
    func hidemenu(){
        UITableView.beginAnimations(nil, context: nil);
        UITableView.setAnimationDuration(0.6);
        tbl.frame = CGRect(x: 0, y: 50, width: 0, height: self.view.frame.size.height-50)
        UIView.setAnimationDelegate(self);
        
        UIView.commitAnimations();
        
        flg = 0;

    }
    
    func swipegesture()  {
        let left_Swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipecontoller))
        left_Swipe.direction = .left
        
        let Right_Swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipecontoller))
        Right_Swipe.direction = UISwipeGestureRecognizerDirection.right
        
        self.view.addGestureRecognizer(left_Swipe)
        self.view.addGestureRecognizer(Right_Swipe)

    }
    func swipecontoller(sender:UISwipeGestureRecognizer)  {
        
        if sender.direction == .left {
            hidemenu()
        }
        else if sender.direction == .right {
            showmenu()
        }

    }
    
    func tapgesture()  {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.slideout));
         tap.numberOfTapsRequired = 1;
        
        mainview.addGestureRecognizer(tap);
        
    }
    
    func slideout(sender:UITapGestureRecognizer) {
       UITableView.beginAnimations(nil, context: nil);
        UITableView.setAnimationDuration(0.6);
       tbl.frame = CGRect(x: 0, y: 50, width: 0, height: self.view.frame.size.height-50)
        UIView.setAnimationDelegate(self);
        
        UIView.commitAnimations();
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
         mainview.removeFromSuperview();
        
    }
    
    @IBAction func openMenu(_ sender: Any) {
        
        if menuShowing {
            LeadingConstrain.constant = -210
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            LeadingConstrain.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing
    }
    
//TableView
    let menuarr = ["A","B","C","D"]
    let mainarr = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView.tag == 2
        {
        return menuarr.count
        }
        else
        {
           return mainarr.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView.tag == 1
        {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "maincell", for: indexPath)
            
            cell.textLabel?.text = mainarr[indexPath.row]
            
            return cell
            
        }
        else
        {
            
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "menucell");
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "menucell", for: indexPath)
        
        cell.textLabel?.text = menuarr[indexPath.row]
        
        return cell
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}


