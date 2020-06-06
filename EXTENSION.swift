//
//  EXTENSION.swift
//  Acadmic
//
//  Created by MAC on 12/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func openLeftViewWithImage(_ imageNamed: String){
        self.leftViewMode = .always
        let leftView = UIImageView(frame: CGRect(x: 0, y: 0, width: 2*self.frame.height/3, height: self.frame.height))
        leftView.image = UIImage(named: imageNamed)
        leftView.contentMode = .right
        self.leftView = leftView
    }
    
    func openLeftViewWithSquareImage(_ image: UIImage){
        self.leftViewMode = .always
        let leftView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height))
        leftView.image = image
        leftView.contentMode = .center
        self.leftView = leftView
    }
    func setPadding(left: CGFloat? = nil, right: CGFloat? = nil){
        if let left = left {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        
        if let right = right {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }

    
    func setPlaceHolderColor(_ setColor: UIColor, placeholderText : String){
        self.textColor = setColor
        self.tintColor = setColor
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                        attributes: [kCTForegroundColorAttributeName as NSAttributedStringKey: setColor])
    }
}

extension UIImageView {
    public func imageFromServerURL(_ urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}

extension UIView{
    func makeSemiCircle(){
        self.layer.cornerRadius = self.frame.height/2
    }
    
    func makeRounderCorners(_ radius: CGFloat){
        self.layer.cornerRadius = radius
    }
    
    func makeInnerBorder(_ insideValue: CGFloat, color: CGColor){
        let newLayer = UIView()
        newLayer.frame = self.frame.insetBy(dx: insideValue, dy: insideValue)
        
        // Add rounded corners
        let maskLayer = CAShapeLayer()
        //        maskLayer.path = UIBezierPath(roundedRect: newLayer.bounds, cornerRadius: newLayer.frame.height/2).cgPath
        maskLayer.path = UIBezierPath(roundedRect: newLayer.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        newLayer.layer.mask = maskLayer
        newLayer.center = self.center
        
        // Add border
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color
        borderLayer.lineWidth = 2
        borderLayer.frame = CGRect(x: insideValue, y: insideValue, width: newLayer.frame.width, height: newLayer.frame.height)
        if(self.layer.sublayers != nil){
            for cLayer in self.layer.sublayers!{
                if(cLayer.isKind(of: CAShapeLayer.self)){
                    cLayer.removeFromSuperlayer()
                }
            }
        }
        self.layer.addSublayer(borderLayer)
    }
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func setShadow(_ cgColor: CGColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffset: CGSize, circular: Bool){
        self.layer.shadowColor = cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shouldRasterize = false
        if(circular){
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        }else{
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        }
    }
    
    public func pauseAnimation(_ delay: Double) {
        let time = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, time, 0, 0, 0, { timer in
            let layer = self.layer
            let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
            layer.speed = 0.0
            layer.timeOffset = pausedTime
        })
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
    }
    
    public func resumeAnimation() {
        let pausedTime  = layer.timeOffset
        
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}


extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [kCTFontAttributeName: font]
        let size = self.size(withAttributes: fontAttributes as [NSAttributedStringKey : Any])
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [kCTFontAttributeName: font]
        let size = self.size(withAttributes: fontAttributes as [NSAttributedStringKey : Any])
        return size.height
    }
}

extension UIViewController{
    func moveTowrads(_ vcName : String){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(secondVC!, animated: true)
    }
    
    func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func backToTabbar(){
        //        if APP_TYPE == App_Type.Individual{
        //            let dashboardVC = self.navigationController!.viewControllers.filter { $0 is tabBar}.first!
        //            self.navigationController!.popToViewController(dashboardVC, animated: true)
        //        }else{
        //            let dashboardVC = self.navigationController!.viewControllers.filter { $0 is tabBarOrganization}.first!
        //            self.navigationController!.popToViewController(dashboardVC, animated: true)
        //        }
    }
}


func isValidEmail(_ testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

func getScreenShot(_ lat: String, lng: String, Width: CGFloat, Height: CGFloat) -> String{
    
    let mapImageUrl = "https://maps.googleapis.com/maps/api/staticmap?center="
    let latlong = "\(lat), \(lng)"
    
    let mapUrl  = mapImageUrl + latlong
    
    let size = "&size=" +  "\(Int(Width))" + "x" +  "\(Int(Height))"
    let positionOnMap = "&markers=size:mid|color:red|" + latlong
    let staticImageUrl = mapUrl + size + positionOnMap
    
//    if let urlStr : String = staticImageUrl.addingPercentEscapes(using:String.Encoding.utf8)!{
//        // setImageFromURL
//        return urlStr
//    }
    return ""
}

func getTime(_ date:String) -> String{
    let dateFormatter = DateFormatter()
    //    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.timeZone = NSTimeZone.local
    let timeZone = NSTimeZone(name: "UTC")
    
    dateFormatter.timeZone = timeZone as! TimeZone
    let extractedDate = dateFormatter.date(from: date)!.addingTimeInterval(TimeInterval(dateFormatter.timeZone.secondsFromGMT()))
    
    
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy"
    let result = formatter.string(from: extractedDate as Date)
    
    return result
}

func getDate(_ date:String) -> Date{
    let dateFormatter = DateFormatter()
    //    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    //    dateFormatter.timeZone =
    dateFormatter.timeZone = NSTimeZone.local
    let timeZone = NSTimeZone(name: "UTC")
    
    dateFormatter.timeZone = timeZone! as TimeZone
    //    dateFormatter.timeZone = NSTimeZone.local
    return dateFormatter.date(from: date)!.addingTimeInterval(TimeInterval(dateFormatter.timeZone.secondsFromGMT()))
}

func makeDate() -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let result = formatter.string(from: Date())
    
    return result
}

//func getResizableLink(_ currentUrl : String, width:Int) -> String{
//    if(currentUrl.contains("graph.facebook.com")){
//        return currentUrl
//    }
//    var url = currentUrl.replacingOccurrences(of: "https://s3-us-west-2.amazonaws.com/vippy/", with: "http://rpmofficial.com:8003/resizeImage/")
//    url += "/\(width)"
//    print(url)
//    return url
//}

func convertDateForApi(_ date: String) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM, yyyy"
    let cDate = formatter.date(from: date)
    
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: cDate!)
}

func convertDateForApp(_ date: String) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let cDate = formatter.date(from: date)
    
    if cDate == nil{
        return "01 Jan, 2017"
    }
    
    formatter.dateFormat = "dd MMM, yyyy"
    return formatter.string(from: cDate!)
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            return nil
            //            if let selected = tabController.selectedViewController {
            //                return topViewController(controller: selected)
            //            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    class func topTabBarController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UITabBarController? {
        if let navigationController = controller as? UINavigationController {
            return topTabBarController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            return tabController
        }else{
            return nil
        }
    }
}

class paddingLabel: UILabel {
    
    let topInset = CGFloat(16.0), bottomInset = CGFloat(16.0), leftInset = CGFloat(16.0), rightInset = CGFloat(16.0)
    
    override func drawText(in rect: CGRect) {
        
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
    
}

class chatRightView: UIView {
    var maskLayer = CAShapeLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        maskLayer.frame = layer.bounds
        maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 8, height: 8)).cgPath
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.mask = maskLayer
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.mask = maskLayer
    }
}


class chatLeftView: UIView {
    var maskLayer = CAShapeLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        maskLayer.frame = layer.bounds
        maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 8, height: 8)).cgPath
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.mask = maskLayer
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.mask = maskLayer
    }
}

func format(phoneNumber sourcePhoneNumber: String) -> String? {
    
    // Remove any character that is not a number
    let numbersOnly = sourcePhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    let length = numbersOnly.characters.count
    let hasLeadingOne = numbersOnly.hasPrefix("1")
    
    // Check for supported phone number length
    guard length == 7 || length == 10 || (length == 11 && hasLeadingOne) else {
        return nil
    }
    
    let hasAreaCode = (length >= 10)
    var sourceIndex = 0
    
    // Leading 1
    var leadingOne = ""
    if hasLeadingOne {
        leadingOne = "1 "
        sourceIndex += 1
    }
    
    // Area code
    var areaCode = ""
    if hasAreaCode {
        let areaCodeLength = 3
        guard let areaCodeSubstring = numbersOnly.characters.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
            return nil
        }
        areaCode = String(format: "(%@) ", areaCodeSubstring)
        sourceIndex += areaCodeLength
    }
    
    // Prefix, 3 characters
    let prefixLength = 3
    guard let prefix = numbersOnly.characters.substring(start: sourceIndex, offsetBy: prefixLength) else {
        return nil
    }
    sourceIndex += prefixLength
    
    // Suffix, 4 characters
    let suffixLength = 4
    guard let suffix = numbersOnly.characters.substring(start: sourceIndex, offsetBy: suffixLength) else {
        return nil
    }
    
    return leadingOne + areaCode + prefix + "-" + suffix
}

extension String.CharacterView {
    /// This method makes it easier extract a substring by character index where a character is viewed as a human-readable character (grapheme cluster).
    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }
        
        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }
        
        return String(self[substringStartIndex ..< substringEndIndex])
    }
}
