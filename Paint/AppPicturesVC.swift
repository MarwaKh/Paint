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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainVCSegue" {
            if let destination = segue.destination as? ViewController {
                if let pictureDestination = sender as? Picture {
                    destination.pictureSelected = pictureDestination
                    destination.selection = true
                }
            }
        }
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
extension AppPicturesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pictureSelected = pictures[indexPath.item]
        performSegue(withIdentifier: "MainVCSegue", sender: pictureSelected)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = picturesCollectionView.bounds.width*0.45
        let height = picturesCollectionView.bounds.height*0.4
        
        return CGSize(width: width, height: height)
    }
}
