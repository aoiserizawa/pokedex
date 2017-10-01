//
//  ViewController.swift
//  Pokedex
//
//  Created by Alvin Joseph Valdez on 28/08/2017.
//  Copyright © 2017 Alvin Joseph Valdez. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var pokemonArray = [Pokemon]()
    
    var page:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        navigationItem.title = "Pokedex"
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(HomePokemonCell.self, forCellWithReuseIdentifier: "pokemonCell")
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        APIManager().fetchPokemon(pageNumber: 0).onSuccess { (pokemons) in
            self.pokemonArray = pokemons
            self.collectionView?.reloadData()
        }        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as! HomePokemonCell
        
        cell.backgroundColor = UIColor.red        
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        cell.nameLabel.text = pokemonArray[indexPath.row].name
        cell.pokemonImageView.image = UIImage(named: String(pokemonArray[indexPath.row].pokedexId))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = self.view.frame.size.width / 4.0
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
        self.collectionView?.reloadData()
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == pokemonArray.count - 1 {
            self.page += 20
            
            APIManager().fetchPokemon(pageNumber: self.page).onSuccess(callback: { (pokemons) in
                self.pokemonArray.append(contentsOf: pokemons)
                self.collectionView?.reloadData()
            })
        }
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
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "sample"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        return label
    }()
    
    var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    func setUpViews(){
        
        addSubview(footerView)
        
        let footerViewBottom = footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        let footerViewWidth = footerView.widthAnchor.constraint(equalTo: widthAnchor)
        let footerViewHeight = footerView.heightAnchor.constraint(equalToConstant: 20.0)
        
        footerConstraints.append(contentsOf: [footerViewBottom,footerViewWidth,footerViewHeight])
        
        NSLayoutConstraint.activate(footerConstraints)
        
        footerView.addSubview(nameLabel)
        
        let nameXConstraint = nameLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor)
        let nameYConstraint = nameLabel.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        
        nameConstraints.append(contentsOf: [nameXConstraint, nameYConstraint])
        
        NSLayoutConstraint.activate(nameConstraints)
        
        addSubview(pokemonImageView)
        
        pokemonImageView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(footerView.snp.top)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
