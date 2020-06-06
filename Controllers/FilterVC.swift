//
//  FilterVC.swift
//  Acadmic
//
//  Created by MAC on 12/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class FilterVC: headerVC {
    
    
    var filter = 1
    var selected : [Bool] = [true,false,false,false]
    var SelectedImage : [UIImage] = [#imageLiteral(resourceName: "ic_uncheck_s"),#imageLiteral(resourceName: "ic_uncheck_s"),#imageLiteral(resourceName: "ic_uncheck_s"),#imageLiteral(resourceName: "ic_check_s")]
    var delegate :setData!
    @IBOutlet weak var tblVw: UITableView!
    
    @IBOutlet weak var ShdwVw: UIView!
    var filterArray : [String] = ["Unpaid Orders", "In Progress Orders","Completed Orders","All Orders"]
    var ChineseFilter : [String] = ["未付款订单","进⾏行行中的订单","已完成的订单","所有订单"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tblVw.delaysContentTouches = false
        header.text = "Filters"
        
        tblVw.estimatedRowHeight = 60
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        if Chinese == 1{
            header.text = "订单类别"
            
        }
        //tblVw.reloadData()
        ShdwVw.makeSemiCircle()
        ShdwVw.isHidden = true
        for x in 0 ... 3{
            selected[x] = false
            SelectedImage[x] = #imageLiteral(resourceName: "ic_uncheck_s")
        }
        selected[filter - 1] = true
        SelectedImage[filter - 1] =  #imageLiteral(resourceName: "ic_check_s")
        // Do any additional setup after loading the view.
    }
   
    @objc func btnActRadio(_ sender : UIButton){
        //check()
               // sender.setImage(#imageLiteral(resourceName: "ic_check_s"), for: .normal)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tblVw.reloadData()
       // check()
    }
   
}
extension FilterVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTVC", for: indexPath) as! FilterTVC
       
        if Chinese == 1{
            cell.lblFilter.text = ChineseFilter[indexPath.row]
           
        }else{
           cell.lblFilter.text = filterArray[indexPath.row]
           
        }
        if indexPath.row == 3{
            cell.SprtrVw.isHidden = true
        }
//        DispatchQueue.main.async {
//            if self.selected[indexPath.row]{
//                cell.imgRadio.image = #imageLiteral(resourceName: "ic_check_s")
//
//            }else{
//                cell.imgRadio.image = #imageLiteral(resourceName: "ic_uncheck_s")
//            }
//        }
        //tblVw.reloadData()
        cell.imgRadio.image = SelectedImage[indexPath.row]
        
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selected[indexPath.row] == false{
            selected = [false,false,false,false]
            SelectedImage = [#imageLiteral(resourceName: "ic_uncheck_s"),#imageLiteral(resourceName: "ic_uncheck_s"),#imageLiteral(resourceName: "ic_uncheck_s"),#imageLiteral(resourceName: "ic_uncheck_s")]
            SelectedImage[indexPath.row] = #imageLiteral(resourceName: "ic_check_s")
            selected[indexPath.row] = !selected[indexPath.row]
           
        }else{
            SelectedImage[indexPath.row] =  #imageLiteral(resourceName: "ic_uncheck_s")
            selected[indexPath.row] = !selected[indexPath.row]
        }
        tblVw.reloadData()
        
        self.delegate.setFiles(["Type" : "\(indexPath.row)"])
        
        self.back()


    }
    
    
    
}
