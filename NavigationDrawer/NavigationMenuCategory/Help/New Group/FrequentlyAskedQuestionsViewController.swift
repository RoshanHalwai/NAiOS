//
//  FrequentlyAskedQuestionsViewController.swift
//  nammaApartment
//
//  Created by Sundir Talari on 17/08/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class FrequentlyAskedQuestionsViewController: NANavigationViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var frequentlyAskedArray = [NAString().frequently_asked_questions(), NAString().using_namma_apartments_app(), NAString().contact_us(), NAString().terms_and_conditions(), NAString().privacy_policy()]
    var navTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.ConfigureNavBarTitle(title: navTitle)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        
        //Hiding History NavigationBar  RightBarButtonItem
        navigationItem.rightBarButtonItem = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frequentlyAskedArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAString().cellID(), for: indexPath) as! HelpCollectionViewCell
        cell.label_View.text = frequentlyAskedArray[indexPath.row]
        
        //Label formatting & setting
        cell.label_View.font = NAFont().textFieldFont()
        NAShadowEffect().shadowEffect(Cell: cell)
        return cell
    }
}
