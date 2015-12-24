//
//  ViewController.swift
//  Photometer
//
//  Created by Morten Just Petersen on 12/20/15.
//  Copyright © 2015 Morten Just Petersen. All rights reserved.
//

import UIKit
import Photos


class ViewController: UIViewController {
    var fetcher:PhotoFetcher!
    var adapter:PhotoTableAdapter!
    @IBOutlet weak var photoTable: UITableView!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return UIStatusBarAnimation.Slide
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = C.appBackgroundColor
        
        prefersStatusBarHidden()
        
        adapter = PhotoTableAdapter()
        adapter.photoTable = photoTable
        
        photoTable.separatorStyle = .None
        photoTable.dataSource = adapter
        photoTable.delegate = adapter
        photoTable.backgroundColor = C.photoTableBackgroundColor
        
        fetcher = PhotoFetcher()        
        refreshPhotoList()
    }
    
    func PhotoFetcherLibraryChanged() {
        refreshPhotoList()
        print("lib changed!")
    }
    
    func refreshPhotoList(){
        fetcher.getAll { (photos) -> Void in
            print("Done getting all \(photos.count) images. Reloading data")
            self.adapter.allPhotos = photos
            self.photoTable.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

