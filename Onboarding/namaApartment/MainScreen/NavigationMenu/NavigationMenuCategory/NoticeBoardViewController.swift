//
//  NoticeBoardViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 25/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class NoticeBoardViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var navTitle = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        super.ConfigureNavBarTitle(title: navTitle)

    }
    
    //TODO: Need to get Committe Members Notice Board Data from Firebase.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! NoticeBoardCollectionViewCell
        NAShadowEffect().shadowEffect(Cell: cell)
        return cell
    }
}
