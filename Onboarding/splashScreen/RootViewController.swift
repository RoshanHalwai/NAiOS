//
//  RootViewController.swift
//  namaAppartment
//
//  Created by Vikas Nayak on 30/04/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import UIKit

class RootViewController: UIViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate
{
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageController: UIPageControl!
    
    lazy var viewControllerList : [UIViewController] = {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let VC1 = sb.instantiateViewController(withIdentifier: "vc1")
        let VC2 = sb.instantiateViewController(withIdentifier: "vc2")
        let VC3 = sb.instantiateViewController(withIdentifier: "vc3")
        
        return[VC1,VC2,VC3]
    }()
    
    var customView = UIView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        self.dataSource = self
//
//        if let firstViewController = viewControllerList.first
//        {
//            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
//        }

        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {return nil}
        
        guard viewControllerList.count > previousIndex else {return nil}
        return viewControllerList[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        let nextIndex = vcIndex + 1
        guard viewControllerList.count != nextIndex else {return nil}
        
        guard viewControllerList.count > nextIndex else {return nil}
        
        return viewControllerList[nextIndex]
        
    }
    

}
