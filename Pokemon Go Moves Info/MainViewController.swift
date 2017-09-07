//
//  MainViewController.swift
//  Pokemon Go Moves Info
//
//  Created by guest on 2017/08/28.
//  Copyright © 2017年 JEC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet var pokemonTableView: UITableView!
    var pokemons : [[String : Any]]? = [[String : Any]]()
    var searchedPokemons : [[String : Any]] = [[String : Any]]()
    var isSearching : Bool = false
    var types : [[String : Any]]? = [[String : Any]]()
    var mySearchBar : UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        if let path_for_pokemon = Bundle.main.path(forResource: "genOne", ofType: "plist"){
            if let array = NSArray.init(contentsOfFile: path_for_pokemon) as? [[String : Any]]{
                array.forEach({ (item) in
                    pokemons?.append(item)
                })
            }
        }
        
        if let path_for_type = Bundle.main.path(forResource: "types", ofType: "plist") {
            if let array = NSArray.init(contentsOfFile: path_for_type) as? [[String : Any]]{
                array.forEach({ (item) in
                    types?.append(item)
                    
                })
            }
        }
        
//        types?.forEach({ (a) in
//            print(a["name"])
//        })
    
        self.mySearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        self.mySearchBar.backgroundColor = UIColor.blue
        self.mySearchBar.tintColor = UIColor.blue
        self.mySearchBar.delegate = self
        self.mySearchBar.returnKeyType = UIReturnKeyType.search
        self.mySearchBar.showsCancelButton = true
        
        self.pokemonTableView.tableHeaderView = self.mySearchBar
        self.pokemonTableView.contentOffset = CGPoint(x: 0, y: 40)
        self.pokemonTableView.separatorStyle  = UITableViewCellSeparatorStyle.none
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named : "nav_bar_img1"), for: UIBarMetrics.default)
        let titleLogo : UIImageView = UIImageView(image: UIImage(named: "pokemon_go_logo"))
        titleLogo.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (self.navigationController?.navigationBar.frame.height)!)
        titleLogo.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleLogo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return (searchedPokemons.count)
        }
        return (pokemons?.count)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonCell
         // Configure the cell...
        var current_pokemon  : [String : Any] = [String : Any]()
        if isSearching {
            current_pokemon = searchedPokemons[indexPath.row]
        }else{
            current_pokemon  =  (pokemons?[indexPath.row])!
        }
        
        if let name = current_pokemon["name"] {
            if let num = current_pokemon["num"] {
                let name_label = "\(String(describing: name)) | #\(String(describing: num))"
                //print(name_label)
                cell.pokemon_label.text = name_label
                let image = "main\(num)"
                cell.pokemon_image.image = UIImage(named: image)
            }
            
        }
        
        //Getting the Type 1 Of Pokemon Form types([[String : Any]])
        if let type1_of_pokemon = current_pokemon["type1"] as? String {
            var type : [String : Any]? = [String : Any]()
            types?.forEach({ (item) in
                if let type_name = item["name"] as? String{
                    if type_name == type1_of_pokemon{
                        type = item
                    }
                }
            })
            
            if let name = type?["name"] as? String{
                cell.type1_label.text = name
            }
            if let image = type?["icon"] as? String{
                cell.type1_image.image = UIImage(named: image)
            }
        }
        
        //Getting the type 1 of Pokemon form types([[String : Any]]) and setting to nil if doesnt have second any second type
        if let type2_of_pokemon = current_pokemon["type2"] as? String {
            if type2_of_pokemon != "nil" {
                var type : [String : Any]? = [String : Any]()
                types?.forEach({ (item) in
                    if let type_name = item["name"] as? String{
                        if type_name == type2_of_pokemon{
                            type = item
                        }
                    }
                })
                
                if let name = type?["name"] as? String{
                    cell.type2_label.text = name
                }
                if let image = type?["icon"] as? String{
                    cell.type2_image.image = UIImage(named: image)
                }
            }else{
                cell.type2_image.image = nil
                cell.type2_label.text = nil
            }
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController : DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        let index = indexPath.row
        if isSearching {
            detailViewController.pokemon = searchedPokemons[indexPath.row]
        }else{
            detailViewController.pokemon = (pokemons?[index])!
        }
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedPokemons.removeAll()
        
        if searchText == "" {
            isSearching = false
            self.pokemonTableView.reloadData()
            return
        }
        
        pokemons?.forEach({ (pokemon) in
            if let name = pokemon["name"] as? String{
                if name.contains(searchText) || name.uppercased().contains(searchText) || name.lowercased().contains(searchText){
                    searchedPokemons.append(pokemon)
                }
            }
        })
        isSearching = true
        self.pokemonTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching  = false
        self.pokemonTableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
}
