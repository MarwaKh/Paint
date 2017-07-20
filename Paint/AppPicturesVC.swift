//
//  AppPicturesVC.swift
//  Paint
//
//  Created by My Computer on 2017-07-19.
//  Copyright © 2017 Marwa. All rights reserved.
//

import UIKit

class AppPicturesVC: UIViewController {

    @IBOutlet weak var picturesCollectionView: UICollectionView!
    
    var pictures = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pictures = Picture.importPictures()
    }

  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AppPicturesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = picturesCollectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath) as! PictureCell
        
        cell.picture = pictures[indexPath.item]
        return cell
    }
}
