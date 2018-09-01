//
//  HomeViewController.swift
//  Marvel
//
//  Created by Administrator on 25/06/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import UIKit

private let imageCache = NSCache<AnyObject, AnyObject>()

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let reuseIdentifier = "Cell"
    
    private  var  commicBooks = CommicBook.sharedInstance.commicBooks
    
    //private var  thumbnailArray =    ["http://i.annihil.us/u/prod/marvel/i/mg/e/e0/4bac3ad5d17c7/portrait_xlarge.jpg",
    //                                  "http://i.annihil.us/u/prod/marvel/i/mg/4/20/4bc697c680890/portrait_xlarge.jpg",
    //                                  "http://i.annihil.us/u/prod/marvel/i/mg/6/90/5a664c954a55b/portrait_xlarge.jpg",
    //                                  "http://i.annihil.us/u/prod/marvel/i/mg/d/00/56f45f95cdd1e/portrait_xlarge.jpg",
    //                                  "http://i.annihil.us/u/prod/marvel/i/mg/a/30/56f46483efc4f/portrait_xlarge.jpg"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  self.clearsSelectionOnViewWillAppear = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTabledNotification(notification:)), name: Notification.Name("reloadTabledNotification"), object: nil)
        
        // Register cell classes
        self.collectionView!.register(UINib(nibName: "ThumbnailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        
        
        self.activityIndicator.startAnimating()
        self.navigationItem.title = "Home"
        
        // self.collectionView!.allowsSelection = true
        self.collectionView.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return  thumbnailArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!  ThumbnailCollectionViewCell
        
        cell.thumbnailImageView.loadImagesUsingCacheWithUrlString(urlString: thumbnailArray[indexPath.row])
        cell.tag = indexPath.row
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //select image
        self.activityIndicator.startAnimating()
        
        //  let cell = collectionView.cellForItem(at: indexPath)
        
        let cell = collectionView.cellForItem(at: indexPath) as!  ThumbnailCollectionViewCell
        
        let index = cell.tag
        let thisurl = self.thumbnailArray[index] as String
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let  detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailsVC.url = thisurl
        
        self.present(detailsVC, animated: false, completion: nil)
        
    }
    
    
    fileprivate func updateCollectionView() {
        self.activityIndicator.startAnimating()
             commicBooks = CommicBook.sharedInstance.commicBooks
        self.collectionView!.reloadData()
        self.activityIndicator.stopAnimating()
    }
    
    @objc func reloadTabledNotification(notification: Notification){
        
        updateCollectionView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.activityIndicator.stopAnimating()
    }
    
}

extension UIImageView  {
    
    func loadImagesUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
            
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async  {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                    
                    self.contentMode = .scaleAspectFill //.scaleAspectFit //
                    self.translatesAutoresizingMaskIntoConstraints = false
                    
                }
                
            }
            
        }).resume()
        
    }
    
}
