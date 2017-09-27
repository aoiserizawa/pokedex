//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Alvin Joseph Valdez on 30/08/2017.
//  Copyright © 2017 Alvin Joseph Valdez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    var customSegmentedControl = UISegmentedControl()
    var segmentConstraints = [NSLayoutConstraint]()
    var contentViewConstraints = [NSLayoutConstraint]()
    
    lazy var bioViewController: UIViewController? = {
       let vc = BioViewController()
        return vc
    }()
    
    lazy var movesViewController: UIViewController? = {
        let vc = MovesViewController()
        return vc
    }()
    
    
    var contentview = UIView()
    var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        
        displayCurrentTab(0)

        setUpSegmentControl()
        setUpSegmentConstraint()
        
        setUpContentView()
    }
    

    
    func setUpSegmentConstraint(){
        let topConstraint = self.customSegmentedControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10)
        let widthConstraint = self.customSegmentedControl.widthAnchor.constraint(equalToConstant: 200)
        let heightConstraint = self.customSegmentedControl.heightAnchor.constraint(equalToConstant: 30)
        let xConstraint = self.customSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        segmentConstraints.append(contentsOf: [topConstraint, widthConstraint, heightConstraint, xConstraint])
        
        NSLayoutConstraint.activate(segmentConstraints)
        
    }
    
    func setUpSegmentControl(){
        customSegmentedControl.insertSegment(withTitle: "Bio", at: 0, animated: true)
        customSegmentedControl.insertSegment(withTitle: "Moves", at: 1, animated: true)
        customSegmentedControl.selectedSegmentIndex = 0
        customSegmentedControl.tintColor = UIColor.red
        customSegmentedControl.addTarget(self, action: #selector(switchTabs), for: .valueChanged)
        customSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.view.addSubview(customSegmentedControl)
    }
    
    func setUpContentView(){
        self.contentview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.contentview)
        
        let topConstraint = self.contentview.topAnchor.constraint(equalTo: customSegmentedControl.bottomAnchor, constant: 10)
        let bottomConstraint = self.contentview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let leftConstraint = self.contentview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let rightConstraint = self.contentview.trailingAnchor.constraint(equalTo:self.view.trailingAnchor)
        
        self.contentViewConstraints.append(contentsOf: [topConstraint, bottomConstraint, leftConstraint, rightConstraint])
        NSLayoutConstraint.activate(contentViewConstraints)
        
    }
    
    @objc func switchTabs(_ sender: UISegmentedControl){
        
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        
        if let vc = viewControllerSelectedSegmentIndex(tabIndex){
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.contentview.bounds
            self.contentview.addSubview(vc.view)
            self.currentViewController = vc
            
        }
    }
    
    
    func viewControllerSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        
        switch index{
        case 0:
            vc = bioViewController
        case 1:
            vc = movesViewController
        default:
            return nil
        }
        
        return vc
    }
}
