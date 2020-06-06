//
//  PayPalWebVwVC.swift
//  Acadmic
//
//  Created by MAC on 25/07/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class PayPalWebVwVC: headerVC,UIWebViewDelegate{
    var Amount :  String  = ""
    var order_No : String = ""
    var ScreenType = 0
    @IBOutlet weak var webVw: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "Payment"
         leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        if ScreenType == 0{
            LoadPayPAalWebVw()
        }else{
            loadWebView()
        }
        
    }
    func loadWebView(){
        let myUrl = URL(string: "http://18.217.103.89:8016/api/add-credits-form?tok=\(loginModal.sharedInstance.stringAccessToken)&amount=\(Amnt)")
        
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "GET"// Compose a query string
        
        let postString = "tok=\(loginModal.sharedInstance.stringAccessToken)&order_no=b\(order_Number)&amount=100"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        webVw.loadRequest(request as URLRequest)
    }
    func LoadPayPAalWebVw(){
        let myUrl = URL(string: "http://18.217.103.89:8016/api/paypal-form?tok=\(loginModal.sharedInstance.stringAccessToken)&order_id=\(order_Id)&amount=\(order_Amount)")
        
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "GET"// Compose a query string
        
        let postString = "tok=\(loginModal.sharedInstance.stringAccessToken)&order_no=b\(order_Number)&amount=100"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        webVw.loadRequest(request as URLRequest)
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
            
            if (request.url?.absoluteString == "http://18.217.103.89:8016/paypal-status?status=1") {
                //Do something
                print("Success")
                
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AsgnmntRelsVC" ) as! AsgnmntRelsVC
                secondVC.ScreenType = 0
                self.navigationController?.pushViewController(secondVC, animated: true)
            }
        if (request.url?.absoluteString == "http://18.217.103.89:8016/credit-paypal-status?status=1"){
            
                    self.moveTowrads("BalanceAddVC")
            }
        
        
        
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
