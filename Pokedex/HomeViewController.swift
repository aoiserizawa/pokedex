//
//  ViewController.swift
//  Pokedex
//
//  Created by Alvin Joseph Valdez on 28/08/2017.
//  Copyright © 2017 Alvin Joseph Valdez. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "Pokedex"
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(HomePokemonCell.self, forCellWithReuseIdentifier: "pokemonCell")
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as! HomePokemonCell
        
        cell.backgroundColor = UIColor.red        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let dimension = self.view.frame.size.width / 4.0
        
        print(dimension)
        
        return CGSize(width: dimension, height: dimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
}

class HomePokemonCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUpViews()
    }
    
    var footerConstraints = [NSLayoutConstraint]()
    var nameConstraints = [NSLayoutConstraint]()
    
    let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "sample"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpViews(){
        
        addSubview(footerView)
        
        let footerViewBottom = footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        let footerViewWidth = footerView.widthAnchor.constraint(equalTo: widthAnchor)
        let footerViewHeight = footerView.heightAnchor.constraint(equalToConstant: contentView.frame.height / 4)
        
        footerConstraints.append(contentsOf: [footerViewBottom,footerViewWidth,footerViewHeight])
        
        NSLayoutConstraint.activate(footerConstraints)
        
        footerView.addSubview(nameLabel)
        
        let nameXConstraint = nameLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor)
        let nameYConstraint = nameLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        
        nameConstraints.append(contentsOf: [nameXConstraint, nameYConstraint])
        
        NSLayoutConstraint.activate(nameConstraints)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
