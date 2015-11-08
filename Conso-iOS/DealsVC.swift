//
//  DealsVC.swift
//  Conso-iOS
//
//  Created by Bilal Karim Reffas on 07.11.15.
//  Copyright © 2015 Quantum. All rights reserved.
//

import UIKit
import Haneke

class DealsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout {
    @IBOutlet weak var collectionView: UICollectionView!
  
    var products : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = UIColor(red:0.21, green:0.22, blue:0.26, alpha:1)
        self.navigationController?.navigationBar.topItem?.title = "Recommendation"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: ".SFUIText-Medium", size: 18)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.setupCollectionView()
        self.NetworkStuff()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func NetworkStuff() -> Void {
        let urlString = "http://consoweb.eu-gb.mybluemix.net/api/products"
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
        layout.minimumColumnSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        
        self.collectionView.alwaysBounceVertical = true
        
        self.collectionView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth]
        
        self.collectionView.collectionViewLayout = layout
    }
    
    

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
    
        
        return  CGSize(width: 35.0, height: 35.0)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! DealUICollectionViewCell
    
        cell.nameLabel.text = self.products[indexPath.row].name
        cell.mainImage.hnk_setImageFromURL(NSURL(string: self.products[indexPath.row].picture)!)
        if let price = Int(self.products[indexPath.row].price) {
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = .CurrencyStyle
            numberFormatter.locale = NSLocale(localeIdentifier: "de_DE")
            cell.priceLabel.text = numberFormatter.stringFromNumber(price)
        }
        
        if self.products[indexPath.row].deal {
            cell.voteImage.image = UIImage(named: "down")
        }else{
            cell.voteImage.image = UIImage(named: "up")
        }
        
        if self.products[indexPath.row].deal {
            cell.heartButton.imageView?.image = UIImage(named: "heartunFill")
        }else{
            cell.heartButton.imageView?.image = UIImage(named: "heartFill")
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    
}
