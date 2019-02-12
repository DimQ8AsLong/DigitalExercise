//
//  DetailViewController.swift
//  DigitalExercise
//
//  Created by Saad Al Mubarak on 2/11/19.
//  Copyright © 2019 Saad Al Mubarak. All rights reserved.
//


import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var imgCaption: UILabel!
    
    @IBOutlet weak var headTitle: UILabel!
    
    @IBOutlet weak var publishedDate: UILabel!
    
    @IBOutlet weak var abstract: UITextView!
    
    @IBOutlet weak var byLine: UILabel!
    
    
    @IBOutlet weak var section: UILabel!
    
    
    
    
    
    var coverImgUrl : String?
    var coverImgCaption: String?
    var theHeadTitle: String?
    var theAbstract: String?
    var thePublishedBy: String?
    var thePublishedDate: String?
    var theSection: String?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set contents 
        img.downloaded(from: coverImgUrl ?? "")
        img.contentMode = .scaleToFill
        imgCaption.text = coverImgCaption
        headTitle.text = theHeadTitle
        abstract.text = theAbstract
        publishedDate.text = thePublishedDate
        byLine.text = thePublishedBy
        section.text = theSection
    
    }
   
    
} // end class
