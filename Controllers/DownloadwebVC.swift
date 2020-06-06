//
//  DownloadwebVC.swift
//  Acadmic
//
//  Created by MAC on 03/08/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class DownloadwebVC: headerVC {
    var DownloadUrl : String = ""
    var Header : String = ""
    @IBOutlet weak var webVw: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView(url: DownloadUrl)
        header.text = Header
         leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
    
      
    }
    func loadWebView(url : String){
        let myUrl = URL(string: url)
        
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "GET"// Compose a query string
        
//        let postString = "tok=\(loginModal.sharedInstance.stringAccessToken)&order_no=b\(order_Number)&amount=100"
//
//        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        webVw.loadRequest(request as URLRequest)
    }

}
