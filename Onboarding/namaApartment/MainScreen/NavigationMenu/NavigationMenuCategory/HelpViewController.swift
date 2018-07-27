//
//  HelpViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 20/07/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class HelpViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collection_View: UICollectionView!
    
    var helpArray = [NAString().frequently_asked_questions(), NAString().using_namma_apartments_app(), NAString().contact_us(), NAString().terms_and_conditions(), NAString().privacy_policy()]
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.ConfigureNavBarTitle(title: navTitle)
        collection_View.delegate = self
        collection_View.dataSource = self
        collection_View.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return helpArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! HelpCollectionViewCell
        cell.label_View.text = helpArray[indexPath.row]
        cell.label_View.font = NAFont().textFieldFont()
        NAShadowEffect().shadowEffect(Cell: cell)
        return cell
    }
}
