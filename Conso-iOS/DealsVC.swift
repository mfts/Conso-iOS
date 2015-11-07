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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        return UICollectionViewCell()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    
}
