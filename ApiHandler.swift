//
//  ApiHandler.swift
//  dreamtrack
//
//  Created by MACBOOK on 06/12/17.
//  Copyright © 2017 MAC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

enum ApiMethod {
    case GET
    case POST
    case PostWithImage
    case PostWithJSON
    case PUT
    case DELETE
    case DELETE_SIMPLE
    case PUTWithJSON
}

class ApiHandler: NSObject {
    static func callApiWithParameters(url: String , withParameters parameters:[String:AnyObject], success:@escaping (JSON)->(), failure: @escaping (String)->(), method: ApiMethod, img: UIImage? , imageParamater: String,headers: [String:String]){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        switch method {
        case .GET:
            Alamofire.request("\(BASE_URL)\(url)" ,method : .get,parameters:parameters,encoding:URLEncoding.default ,headers: headers).responseJSON { response
                in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let statusCode = response.response?.statusCode
                do {
//                    let result = try doSomething()
                    let json = try JSON(data: response.data!)
                    
                    switch response.result{
                        
                    case .success(_):
                        if(statusCode==200){
                            if let data = response.result.value{
                                success(json)
                            }
                        }
                        else{
                            if let data = response.result.value{
                                let dict=data as! NSDictionary
                                if statusCode == 403{
                                    deleteData()
                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                    navCon.popToRootViewController(animated: true)
                                }else if statusCode == 401{
                                    deleteData()
                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                    navCon.popToRootViewController(animated: true)
                                }else{
                                    if let value = dict.value(forKey: "error_description"){
                                        failure(dict.value(forKey: "error_description") as! String)
                                    }else{
                                        failure(dict.value(forKey: "message") as! String)
                                    }
                                }
                            }
                        }
                        break
                    case .failure(_):
                        if let error = response.result.error{
                            let str = error.localizedDescription as String
//                            if str.isEqual("Something went wrong. Please try again"){
//                                return
//                            }
                            
                            failure(str)
                        }
                        
                    }
                }
                catch {
                    failure("Something went wrong. Please try again")
                    // Here you know about the error
                    // Feel free to handle to re-throw
                }
                
            }
            break
        case .POST:
            
            Alamofire.request( "\(BASE_URL)\(url)", method : .post, parameters:parameters,encoding: URLEncoding.default,headers: headers).responseJSON {
                response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let statusCode = response.response?.statusCode
                
                do {
//                    let result = try doSomething()
                    let json = try JSON(data: response.data!)
                    switch response.result{
                        
                    case .success(_):
                        if(statusCode==200){
                            if let data = response.result.value{
                                success(json)
                            }
                        }
                        else{
                            //                        failure(json)
                            if let data = response.result.value{
                                let dict = data as! NSDictionary
                                if statusCode == 403{
                                    deleteData()
                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                    navCon.popToRootViewController(animated: true)
                                }else if statusCode == 401{
                                    deleteData()
                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                    navCon.popToRootViewController(animated: true)
                                }else{
                                    if let value = dict.value(forKey: "error_description"){
                                        failure(dict.value(forKey: "error_description") as! String)
                                    }else{
                                        failure(dict.value(forKey: "message") as! String)
                                    }
                                }
                            }
                        }
                        break
                        
                    case .failure(_):
                        if let error = response.result.error{
                            //                        failure(json)
                            failure(error.localizedDescription as String)
                        }
                    }
                }
                catch {
                    failure("Something went wrong. Please try again")
                    // Here you know about the error
                    // Feel free to handle to re-throw
                }
                
                
            }
            break
        case .PostWithImage:
            guard let img = img else{
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                return
            }
            guard let imageData = UIImageJPEGRepresentation(img, 0.2)else{
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                return
            }
            
//            let imageData: Data = UIImagePNGRepresentation(img)! as Data
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: imageParamater ,fileName: "file.jpeg", mimeType: "image/jpeg")
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            },
                             to:"\(BASE_URL)\(url)", headers:headers)
            { (result) in

                switch result {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    upload.responseJSON { response in
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let statusCode = response.response?.statusCode
                        do {
//                            let result = try doSomething()
                            let json = try JSON(data: response.data!)
                            if(statusCode==200){
                                if let data = response.result.value{
                                    success(json)
                                    //                                success((data as AnyObject) as! NSDictionary)
                                }
                            }
                            else{
                                if response.result.isFailure{
                                    failure(response.result.error!.localizedDescription)
                                }
                                //                            failure(json)
                                if let data = response.result.value{
                                    let dict=data as! NSDictionary
                                    if statusCode == 403{
                                        deleteData()
                                        let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                        navCon.popToRootViewController(animated: true)
                                    }else if statusCode == 401{
                                        deleteData()
                                        let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                        navCon.popToRootViewController(animated: true)
                                    }else{
                                        if let value = dict.value(forKey: "error_description"){
                                            failure(dict.value(forKey: "error_description") as! String)
                                        }else{
                                            failure(dict.value(forKey: "message") as! String)
                                        }
                                    }
                                }
                            }
                        }
                        catch {
                            failure("Something went wrong. Please try again")
                            // Here you know about the error
                            // Feel free to handle to re-throw
                        }
                        
                        
                    }
                    
                case .failure(let encodingError):
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    //                    encodingError.
                    //                    let json = JSON(data: response.data!)
                    //                    failure(json)
                    failure(encodingError.localizedDescription as String)
                }
            }
            break
        case .PostWithJSON:
            
            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            
            var request = URLRequest(url: URL(string: "\(BASE_URL)\(url)")!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = jsonData
            request.allHTTPHeaderFields = headers
            Alamofire.request(request).responseJSON { response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let statusCode = response.response?.statusCode
                do {
//                    let result = try doSomething()
                    let json = try JSON(data: response.data!)
                    if(statusCode==200){
                        if let data = response.result.value{
                            success(json)
                            //                                success((data as AnyObject) as! NSDictionary)
                        }
                    }
                    else{
                        //                            failure(json)
                        if let data = response.result.value{
                            let dict=data as! NSDictionary
                            if statusCode == 403{
                                deleteData()
                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                navCon.popToRootViewController(animated: true)
                            }else if statusCode == 401{
                                deleteData()
                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                navCon.popToRootViewController(animated: true)
                            }else{
                                if let value = dict.value(forKey: "error_description"){
                                    failure(dict.value(forKey: "error_description") as! String)
                                }else{
                                    failure(dict.value(forKey: "message") as! String)
                                }
                            }
                        }
                    }
                }
                catch {
                    failure("Something went wrong. Please try again")
                    // Here you know about the error
                    // Feel free to handle to re-throw
                }
                
            }
            break
            
        case .PUTWithJSON:
            
            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            
            var request = URLRequest(url: URL(string: "\(BASE_URL)\(url)")!)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = jsonData
            
            Alamofire.request(request).responseJSON { response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let statusCode = response.response?.statusCode
                do {
                    //                    let result = try doSomething()
                    let json = try JSON(data: response.data!)
                    if(statusCode==200){
                        if let data = response.result.value{
                            success(json)
                            //                                success((data as AnyObject) as! NSDictionary)
                        }
                    }
                    else{
                        //                            failure(json)
                        if let data = response.result.value{
                            let dict=data as! NSDictionary
                            if statusCode == 403{
                                deleteData()
                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                navCon.popToRootViewController(animated: true)
                            }else if statusCode == 401{
                                deleteData()
                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                navCon.popToRootViewController(animated: true)
                            }else{
                                if let value = dict.value(forKey: "error_description"){
                                    failure(dict.value(forKey: "error_description") as! String)
                                }else{
                                    failure(dict.value(forKey: "message") as! String)
                                }
                            }
                        }
                    }
                }
                catch {
                    failure("Something went wrong. Please try again")
                    // Here you know about the error
                    // Feel free to handle to re-throw
                }
                
            }
            break
            
        case .PUT:
            Alamofire.request( "\(BASE_URL)\(url)", method : .put, parameters:parameters,encoding: JSONEncoding.default,headers: headers).responseJSON {
                response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let statusCode = response.response?.statusCode
                do {
//                    let result = try doSomething()
                    let json = try JSON(data: response.data!)
                    switch response.result{
                        
                    case .success(_):
                        if(statusCode==200){
                            if let data = response.result.value{
                                success(json)
                                //                            success((data as AnyObject) as! NSDictionary)
                            }
                        }
                        else{
                            //                        failure(json)
                            if let data = response.result.value{
                                let dict=data as! NSDictionary
                                if statusCode == 403{
                                    deleteData()
                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                    navCon.popToRootViewController(animated: true)
                                }else if statusCode == 401{
                                    deleteData()
                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                    navCon.popToRootViewController(animated: true)
                                }else{
                                    if let value = dict.value(forKey: "error_description"){
                                        failure(dict.value(forKey: "error_description") as! String)
                                    }else{
                                        failure(dict.value(forKey: "message") as! String)
                                    }
                                }
                            }
                        }
                        break
                        
                    case .failure(_):
                        //                    failure(json)
                        if let error = response.result.error{
                            failure(error.localizedDescription as String)
                        }
                        break
                    }
                }
                catch {
                    failure("Something went wrong. Please try again")
                    // Here you know about the error
                    // Feel free to handle to re-throw
                }
                
                
            }
            break
            
        case .DELETE:
            
            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            var request = URLRequest(url: URL(string: "\(BASE_URL)\(url)")!)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = jsonData
            
            Alamofire.request(request).responseJSON { response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let statusCode = response.response?.statusCode
                do {
                    //                    let result = try doSomething()
                    let json = try JSON(data: response.data!)
                    if(statusCode==200){
                        if let data = response.result.value{
                            success(json)
                            //                                success((data as AnyObject) as! NSDictionary)
                        }
                    }
                    else{
                        //                            failure(json)
                        if let data = response.result.value{
                            let dict=data as! NSDictionary
                            if statusCode == 403{
                                deleteData()
                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                navCon.popToRootViewController(animated: true)
                            }else if statusCode == 401{
                                deleteData()
                                let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                navCon.popToRootViewController(animated: true)
                            }else{
                                if let value = dict.value(forKey: "error_description"){
                                    failure(dict.value(forKey: "error_description") as! String)
                                }else{
                                    failure(dict.value(forKey: "message") as! String)
                                }
                            }
                        }
                    }
                }
                catch {
                    failure("Something went wrong. Please try again")
                    // Here you know about the error
                    // Feel free to handle to re-throw
                }
                
            }
            break
        case .DELETE_SIMPLE:
            Alamofire.request("\(BASE_URL)\(url)" ,method : .delete,parameters:parameters,encoding:URLEncoding.default ,headers: headers).responseJSON { response
                in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let statusCode = response.response?.statusCode
                do {
                    //                    let result = try doSomething()
                    let json = try JSON(data: response.data!)
                    
                    switch response.result{
                        
                    case .success(_):
                        if(statusCode==200){
                            if let data = response.result.value{
                                success(json)
                            }
                        }
                        else{
                            if let data = response.result.value{
                                let dict=data as! NSDictionary
                                if statusCode == 403{
                                    deleteData()
                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                    navCon.popToRootViewController(animated: true)
                                }else if statusCode == 401{
                                    deleteData()
                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                    navCon.popToRootViewController(animated: true)
                                }else{
                                    if let value = dict.value(forKey: "error_description"){
                                        failure(dict.value(forKey: "error_description") as! String)
                                    }else{
                                        failure(dict.value(forKey: "message") as! String)
                                    }
                                }
                            }
                        }
                        break
                    case .failure(_):
                        if let error = response.result.error{
                            let str = error.localizedDescription as String
                            //                            if str.isEqual("Something went wrong. Please try again"){
                            //                                return
                            //                            }
                            
                            failure(str)
                        }
                        
                    }
                }
                catch {
                    failure("Something went wrong. Please try again")
                    // Here you know about the error
                    // Feel free to handle to re-throw
                }
                
            }
            break
        default:
            break
        }
    }
    
    
    
    static func callApiForTwoImagesWithParameters(url: String , withParameters parameters:[String:AnyObject], success:@escaping (JSON)->(), failure: @escaping (String)->(), method: ApiMethod, images1: UIImage?, images2: UIImage?, name: String , name2: String ,headers: [String:String]){
        
        guard let img = images1 else{return}
        guard let imageData = UIImageJPEGRepresentation(img, 0.3)else{return}

        guard let img2 = images2 else{return}
        guard let imageData2 = UIImageJPEGRepresentation(img2, 0.3)else{return}
        
        //            let imageData: Data = UIImagePNGRepresentation(img)! as Data
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: name ,fileName: "file.jpeg", mimeType: "image/jpeg")
            
            multipartFormData.append(imageData2, withName: name2 ,fileName: "file.jpeg", mimeType: "image/jpeg")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        },
                         to:"\(BASE_URL)\(url)", headers:headers)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    let statusCode = response.response?.statusCode
                    
                    do {
                        
//                        let result = try doSomething()
                        
                        let json = try JSON(data: response.data!)
                        if(statusCode==200){
                            if let data = response.result.value{
                                success(json)
                                //                                success((data as AnyObject) as! NSDictionary)
                            }
                        }
                        else{
                            if response.result.isFailure{
                                failure(response.result.error!.localizedDescription)
                            }
                            //                            failure(json)
                            if let data = response.result.value{
                                let dict=data as! NSDictionary
                                if statusCode == 403{
                                    deleteData()
                                    let navCon = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                                    navCon.popToRootViewController(animated: true)
                                }else{
                                    if let value = dict.value(forKey: "error_description"){
                                        failure(dict.value(forKey: "error_description") as! String)
                                    }else{
                                        failure(dict.value(forKey: "message") as! String)
                                    }
                                }
                            }
                        }
                    }
                    catch {
                        failure("Something went wrong. Please try again")
                        // Here you know about the error
                        // Feel free to handle to re-throw
                    }
                    
                    
                }
                
            case .failure(let encodingError):
                //                    encodingError.
                //                    let json = JSON(data: response.data!)
                //                    failure(json)
                failure(encodingError.localizedDescription as String)
            }
        }
        
    }
}
