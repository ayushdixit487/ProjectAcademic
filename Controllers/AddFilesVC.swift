//
//  AddFilesVC.swift
//  Acadmic
//
//  Created by MAC on 09/08/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class AddFilesVC: headerVC {

    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var tfPasswrd3: UITextField!
    @IBOutlet weak var tfUserName3: UITextField!
    @IBOutlet weak var tfWebsite3: UITextField!
    @IBOutlet weak var tfUserName2: UITextField!
    @IBOutlet weak var tfPassword2: UITextField!
    @IBOutlet weak var tfWebsite2: UITextField!
    @IBOutlet weak var tfPswrd1: UITextField!
    @IBOutlet weak var tfUserName1: UITextField!
    @IBOutlet weak var tfWebsite1: UITextField!
    @IBOutlet weak var btnBooks: UIButton!
    @IBOutlet weak var btnLectureNotes: UIButton!
    @IBOutlet weak var btnSyllabus: UIButton!
    @IBOutlet weak var btnSample: UIButton!
    @IBOutlet weak var btnOrignl: UIButton!
    @IBOutlet weak var ClctnOrignal: UICollectionView!
    
    @IBOutlet weak var booksClctnTop: NSLayoutConstraint!
    @IBOutlet weak var ClctnBooks: UICollectionView!
    @IBOutlet weak var lectureClctnTop: NSLayoutConstraint!
    @IBOutlet weak var LectureClctn: UICollectionView!
    @IBOutlet weak var syllabusClctnTop: NSLayoutConstraint!
    @IBOutlet weak var ClctnSyallbus: UICollectionView!
    @IBOutlet weak var sampleClctnTop: NSLayoutConstraint!
    @IBOutlet weak var ClctnSample: UICollectionView!
    @IBOutlet weak var orgnlClctnTop: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "ADD FILES"
        btnSave.makeRounderCorners(5)
        btnBooks.makeRounderCorners(5)
        btnOrignl.makeRounderCorners(5)
        btnSample.makeRounderCorners(5)
        btnLectureNotes.makeRounderCorners(5)
        btnSyllabus.makeRounderCorners(5)
        tfWebsite1.setPadding(left: 8, right: 8)
        tfWebsite2.setPadding(left: 8, right: 8)
        tfWebsite3.setPadding(left: 8, right: 8)
        tfUserName1.setPadding(left: 8, right: 8)
        tfUserName2.setPadding(left: 8, right: 8)
        tfUserName3.setPadding(left: 8, right: 8)
        tfPswrd1.setPadding(left: 8, right: 8)
        tfPassword2.setPadding(left: 8, right: 8)
        tfPasswrd3.setPadding(left: 8, right: 8)
        btnOrignl.tag = 0
        btnSample.tag = 1
        btnSyllabus.tag = 2
        btnLectureNotes.tag = 3
        btnBooks.tag = 4
        ClctnOrignal.isHidden = true
        ClctnBooks.isHidden = true
        ClctnSample.isHidden = true
        ClctnSyallbus.isHidden = true
        LectureClctn.isHidden = true
        orgnlClctnTop.constant = 24
        booksClctnTop.constant = 24
        sampleClctnTop.constant = 24
        lectureClctnTop.constant = 24
        syllabusClctnTop.constant = 24
        btnSave.backgroundColor = UIColor(netHex: COLORS.YELLOW.rawValue)
      
    }
    

   

}
extension AddFilesVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ClctnOrignal{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCVC", for: indexPath) as! PhotoCVC
            
            
            
            return cell
        }
        else if collectionView == ClctnSample{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCVC", for: indexPath) as! PhotoCVC
            
            
            
            return cell
        }
        else if collectionView == ClctnSyallbus{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCVC", for: indexPath) as! PhotoCVC
            
            
            
            return cell
        }
        else if collectionView == ClctnBooks{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCVC", for: indexPath) as! PhotoCVC
            
            
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCVC", for: indexPath) as! PhotoCVC
            
            
            
            return cell
        }
    }
        
    @objc func btnActCross(_ sender : UIButton){
        
    }
    
}
