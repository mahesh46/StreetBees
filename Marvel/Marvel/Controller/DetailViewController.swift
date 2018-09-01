//
//  DetailViewController.swift
//  Marvel
//
//  Created by Administrator on 25/06/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var comicImageView: UIImageView!
   // var url : String?
   // var image : UIImage?
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var commicObject : commic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.comicImageView.loadImagesUsingCacheWithUrlString(urlString: self.commicObject?.thumbnailUrl ?? "")
        
        self.titleLabel.text = self.commicObject?.title ?? ""
        self.descriptionLabel.text = self.commicObject?.description ?? ""
    }
    
    
}
