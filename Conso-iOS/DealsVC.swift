//
//  DealsVC.swift
//  Conso-iOS
//
//  Created by Bilal Karim Reffas on 07.11.15.
//  Copyright © 2015 Quantum. All rights reserved.
//

import UIKit

class DealsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    var products : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.setupCollectionView()
        self.NetworkStuff()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func NetworkStuff() -> Void {
        let urlString = "http://192.168.0.159:3000/api/products"
        let url = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        url.timeoutInterval = 20.0
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(url) { (data, response, error) -> Void in
            if error != nil{
                print(error?.localizedDescription)
            }
            let json = JSON(data: data!)
            self.parseData(json)
        }
        task.resume()
    }
    
    
    func parseData(json : JSON) -> Void {
        for (_,value) in json["products"]{
            let name = value["shop"]["name"].stringValue
            let urlItem = value["url"].stringValue
            let picture = value["photo_url"].stringValue
            let deal = value["offer"].boolValue
            let price = value["price_in_cent"].stringValue
            
            let product = Product(name: name, urlItem: urlItem, picture: picture, deal: deal, price: price)
            print(product)
            self.products.append(product)
            dispatch_async(dispatch_get_main_queue()){
                self.collectionView.reloadData()
            }
        }
    }
    
    func setupCollectionView() -> Void {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        
        self.collectionView.alwaysBounceVertical = true
        
        self.collectionView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth]
        
        self.collectionView.collectionViewLayout = layout
    }
    
    
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return CGSize()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! DealUICollectionViewCell
    
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    
}
