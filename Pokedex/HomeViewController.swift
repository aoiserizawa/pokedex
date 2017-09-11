//
//  ViewController.swift
//  Pokedex
//
//  Created by Alvin Joseph Valdez on 28/08/2017.
//  Copyright © 2017 Alvin Joseph Valdez. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var pokemonArray = [Pokemon]()
    
    var page:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchPokemon(pageNumber: 0)
        
        navigationItem.title = "Pokedex"
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(HomePokemonCell.self, forCellWithReuseIdentifier: "pokemonCell")
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonArray.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func fetchPokemon(pageNumber: Int){
        
        page += pageNumber
        
        guard let url = URL(string: "http://pokeapi.co/api/v2/pokemon/?offset=\(page)") else { return }
        
        let session = URLSession.shared
        
        ActivityManager.addActivity()
        session.dataTask(with: url) { (data, response, error) in
            if let response = response{
                ActivityManager.removeActivity()
            }
            
            if let data = data {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    
                    if let dictionary = json as? [String:AnyObject] {
                        if let results = dictionary["results"] as? [[String:AnyObject]]{
                            for result in results{
                                if let url = result["url"]?.components(separatedBy: "/"), let name = result["name"] {
                                    self.pokemonArray.append(Pokemon(name: name as! String, pokedexId: Int(url[6])!) )
                                    
                                    DispatchQueue.main.async {
                                        
                                        self.collectionView?.reloadData()
                                        
                                    }
                                }
                            }
                        }
                    }
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as! HomePokemonCell
        
        cell.backgroundColor = UIColor.red        
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        cell.nameLabel.text = pokemonArray[indexPath.row].name
        
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
            self.fetchPokemon(pageNumber: 20)
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
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
