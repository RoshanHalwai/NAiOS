//
//  MainPageViewController.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 25/05/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class MainPageViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate
{
    let sb = UIStoryboard(name: "Main", bundle: nil)
    
    var VC: UIViewController?
    var currentIndex = 0
    var customView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VC = sb.instantiateViewController(withIdentifier: "mainScreenVC")
        
        self.dataSource = self
        self.delegate = self
        
        if VC == nil
        {
            self.setViewControllers([VC] as? [UIViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        if currentIndex <= 1 {
            currentIndex = currentIndex - 1
        }
        let tmpVc =  sb.instantiateViewController(withIdentifier: "mainScreenVC") as! MainScreenViewController
        tmpVc.currentIndex = currentIndex
        
        return tmpVc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        if currentIndex <= 0 {
            currentIndex = currentIndex + 1
        }
        
        let tmpVc =  sb.instantiateViewController(withIdentifier: "mainScreenVC") as! MainScreenViewController
        tmpVc.currentIndex = currentIndex
        
        return tmpVc
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return VC
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        return 2
    }
}
