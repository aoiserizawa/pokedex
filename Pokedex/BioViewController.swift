//
//  BioViewController.swift
//  Pokedex
//
//  Created by Alvin Joseph Valdez on 30/08/2017.
//  Copyright © 2017 Alvin Joseph Valdez. All rights reserved.
//

import UIKit
import SnapKit

class BioViewController: UIViewController {
    
    var scrollViewContainer = UIScrollView()
    var mainContainerView = UIView()
    var imageView = UIView()
    var bioDescTextView = UITextView()
    var evolutionView = UIView()
    
    var stackViewContainer = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.backgroundColor = UIColor.red
        
        self.setUpScrollViewContainer()
        self.setUpMainContainerView()
        self.setUpImageView()
        self.setUpBiosDescTextView()
        self.setUpBioStatus()
        self.setUpEvolutionSection()
    }
    
    func setUpImageView(){
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.mainContainerView.addSubview(self.imageView)
        self.imageView.backgroundColor = UIColor.red
        
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.mainContainerView.snp.top).offset(10)
            make.left.equalTo(self.mainContainerView.snp.left).offset(10)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
    }
    
    func setUpBiosDescTextView(){
        self.bioDescTextView.translatesAutoresizingMaskIntoConstraints = false
        self.mainContainerView.addSubview(self.bioDescTextView)
        
        self.bioDescTextView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        
        self.bioDescTextView.isEditable = false
        self.bioDescTextView.isScrollEnabled = false
        
        self.bioDescTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.mainContainerView.snp.top).offset(10)
            make.left.equalTo(self.imageView.snp.right)
            make.right.equalTo(self.mainContainerView.snp.right).offset(0)
            make.height.greaterThanOrEqualTo(120)
            
        }
        
    }
    
    func setUpScrollViewContainer(){
        self.view.addSubview(self.scrollViewContainer)
        
        self.scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollViewContainer.snp.makeConstraints { (make) in
//            make.top.equalTo(topLayoutGuide.snp.bottom)
//            make.left.equalTo(view)
//            make.right.equalTo(view)
//            make.bottom.equalTo(bottomLayoutGuide.snp.top)
            make.edges.equalTo(view)
        }
        
    }
    
    func setUpMainContainerView(){
        self.scrollViewContainer.addSubview(self.mainContainerView)
        self.mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.mainContainerView.backgroundColor = UIColor.white
        
        self.mainContainerView.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width)
            make.edges.equalTo(scrollViewContainer)
        }
        
    }
    
    
    func setUpBioStatus(){
        
        let stackViewTop = UIStackView(arrangedSubviews: self.createLabels("Type:", "Grass", "PokemonID:", "143", size: 14, font: "AvenirNext-Bold", special: true))
        stackViewTop.translatesAutoresizingMaskIntoConstraints = false
        stackViewTop.axis = .horizontal
//        stackViewTop.spacing = 10
        stackViewTop.distribution = .fillEqually
        stackViewTop.alignment = .center
        
        let stackViewMiddle = UIStackView(arrangedSubviews: self.createLabels("Height:", "4", "Base Attack:", "55", size: 11, font: "AvenirNext-Bold", special: false))
        stackViewMiddle.translatesAutoresizingMaskIntoConstraints = false
        stackViewMiddle.axis = .horizontal
//        stackViewMiddle.spacing = 10
        stackViewMiddle.distribution = .fillEqually
        stackViewMiddle.alignment = .center
        
        let stackViewBottom = UIStackView(arrangedSubviews: self.createLabels("Weight:", "522", "Base Defense:", "65", size: 11, font: "AvenirNext-Bold", special: false))
        stackViewBottom.translatesAutoresizingMaskIntoConstraints = false
        stackViewBottom.axis = .horizontal
//        stackViewBottom.spacing = 10
        stackViewBottom.distribution = .fillEqually
        stackViewBottom.alignment = .center
        
        
        stackViewContainer.addArrangedSubview(stackViewTop)
        stackViewContainer.addArrangedSubview(stackViewMiddle)
        stackViewContainer.addArrangedSubview(stackViewBottom)
        
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.axis = .vertical
        stackViewContainer.spacing = 10
        stackViewContainer.distribution = .fillProportionally
        stackViewContainer.alignment = .fill
        
        
        self.mainContainerView.addSubview(stackViewContainer)
        
        stackViewContainer.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).offset(30)
            make.right.left.equalTo(self.mainContainerView).offset(20)
//            make.bottom.equalTo(self.mainContainerView.snp.bottom)
        }
        
    }
    
    private func createLabels(_ labels: String..., size: Float, font: String, special: Bool) -> [UILabel] {
        return labels.enumerated().map{ (index, label) in
            
            let labelAttribute = UILabel()
            labelAttribute.translatesAutoresizingMaskIntoConstraints = false
            labelAttribute.text = label
            labelAttribute.adjustsFontSizeToFitWidth = true
            
            if special == true {
                if index == 1 || index % 2 == 0 {
                    labelAttribute.font = UIFont(name: font, size: CGFloat(size))
//                    print(label)
                }else{
                    let fontUnbold = font.components(separatedBy: "-")
//                    print(fontUnbold[0])
                    labelAttribute.font = UIFont(name: fontUnbold[0]+"-Regular", size: CGFloat(size))
                }
            }else{
                if index % 2 == 0 {
                    labelAttribute.font = UIFont(name: font, size: CGFloat(size))
//                    print(label)
                }else{
                    let fontUnbold = font.components(separatedBy: "-")
//                    print(fontUnbold[0])
                    labelAttribute.font = UIFont(name: fontUnbold[0]+"-Regular", size: CGFloat(size))
                }
            }
            
            return labelAttribute
        }
    }
    
    func setUpEvolutionSection(){
        self.evolutionView.translatesAutoresizingMaskIntoConstraints = true
        self.mainContainerView.addSubview(self.evolutionView)
        
        self.evolutionView.backgroundColor = UIColor.red
        
        self.evolutionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.stackViewContainer.snp.bottom).offset(10)
            make.right.left.equalTo(self.mainContainerView)
            make.height.equalTo(29)
            make.bottom.equalTo(self.mainContainerView.snp.bottom)
        }
        
        self.setEvolutionHeaderText(parentView: evolutionView)
        
    }
    
    
    func setEvolutionHeaderText(nextEvolution: String? = nil, parentView: UIView){
        let evolutionLabel = UILabel()
        evolutionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        evolutionLabel.text = "No Next Evolution"
        evolutionLabel.font = UIFont(name: "AvenirNext-Bold", size: 15)
        evolutionLabel.textColor = UIColor.white
        
        if nextEvolution != nil {
            evolutionLabel.text = nextEvolution
        }
        
        parentView.addSubview(evolutionLabel)
        
        evolutionLabel.snp.makeConstraints { (make) in
            make.center.equalTo(parentView)
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {

            
        } else if UIDevice.current.orientation.isPortrait {
            
        }
    }


}
