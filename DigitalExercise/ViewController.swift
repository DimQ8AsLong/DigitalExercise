//
//  ViewController.swift
//  DigitalExercise
//
//  Created by Saad Al Mubarak on 2/10/19.
//  Copyright © 2019 Saad Al Mubarak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //////////////////////////
    // Constants
    //////////////////////////
    static let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=2y50SXaQAPlosEmgjBkrwABDSXSq2xqN")
    
    
    
    //////////////////////////
    // variables
    //////////////////////////
    var data = [Result]()
    var selectedItem : Int!
   
    
    //////////////////////////
    // Outlets
    //////////////////////////
    @IBOutlet weak var tableView: UITableView!
    
    
    //////////////////////////
    // Actions
    //////////////////////////
    
    
    
    
    
    //////////////////////////
    // Functions
    //////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        URLSession.shared.BeginTheTask(with: ViewController.url!) { data, response, error in
            
            
            
            if let data = data {
                
              
                for result in data.results! {
                    self.data.append(result)
                    
                }
                // reload table data in the main thread
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            
            
            
            
            
            }.resume()
        
        
    }

    
    //////////////////////////
    // SEGUE
    /////////////////////////
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // check the identifier
        if segue.identifier == "details" {
            
            let dvc = segue.destination as! DetailViewController
            let dataa = data[selectedItem]
            let imgUrl = data[selectedItem].media![0].mediaMetadata![5].url
            let imgCaption = data[selectedItem].media![0].caption
            
            // assign values
            dvc.coverImgUrl = imgUrl
            dvc.theHeadTitle = dataa.title
            dvc.coverImgCaption = imgCaption
            dvc.theAbstract = dataa.abstract
            dvc.thePublishedBy = dataa.byline
            dvc.thePublishedDate = dataa.publishedDate
            dvc.theSection = dataa.section
            
        }
    }
    
} // end class






//////////////////////////
// Extensions
//////////////////////////

//VIEWCONTROLLER - TABLEVIEW
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:  indexPath) as! NYTableViewCell
        let dataa = data[indexPath.row]
        let imgUrl = dataa.media![0].mediaMetadata![0].url
        cell.coverImage.downloaded(from: imgUrl ?? "")
        cell.headTitle.text = dataa.title
        cell.publishedBy.text = dataa.byline
        cell.publishedDate.text = dataa.publishedDate
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = indexPath.row
        self.performSegue(withIdentifier: "details", sender: nil)
    }
}



// UIIMAGE
// image cache
 let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

    
    // function to handle images download from URL
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        contentMode = mode
        // set image as nil
        image = nil
        
        
        // check if the image is already in the cache
        // if so we dont need to dowmload it again from URL
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        
        // using urlsession to download image from url
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            // assign in main thread
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}



