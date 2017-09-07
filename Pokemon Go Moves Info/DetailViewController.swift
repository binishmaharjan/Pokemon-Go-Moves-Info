//
//  DetailViewController.swift
//  Pokemon Go Moves Info
//
//  Created by guest on 2017/08/29.
//  Copyright © 2017年 JEC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pokemon : [String : Any] = [String : Any]()
    var types : [[String : Any]] = [[String : Any]]()
    var allmoves : [[String : Any]] = [[String : Any]]()
    var topView : UIView = UIView()
    var type1 : [String : Any] = [String : Any]()
    var type2 : [String : Any] = [String : Any]()
    var pokemonStrongAgainst : [[String : Any]] = [[String : Any]]()
    var pokemonWeakAgainst : [[String : Any]] = [[String : Any]]()
    var featuresView : UIView = UIView()
    var allMovesView : UIView = UIView()
    var bestmovesView : UIView = UIView()
    var maxCpView : UIView = UIView()
    var TABLLE_SIZE : CGFloat = 0
    
    @IBOutlet var mainScrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        TABLLE_SIZE = self.view.frame.width - 16
        _ = (self.navigationController?.navigationBar.frame.size.height)!
        
        mainScrollView.contentSize = CGSize(width: self.view.frame.width, height: 2000)
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        //customizing topView(name,image,types,maxcp)
        self.mainScrollView.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: self.mainScrollView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        //topView.backgroundColor = UIColor.red
        
        //putting logo to navigation bar
        let titleLogo : UIImageView = UIImageView(image: UIImage(named: "pokemon_go_logo"))
        titleLogo.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (self.navigationController?.navigationBar.frame.height)!)
        titleLogo.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleLogo
        
        
       //getting all the types of pokemon
        if let path_for_types  = Bundle.main.path(forResource: "types", ofType: "plist"){
            if let array = NSArray.init(contentsOfFile: path_for_types) as? [[String : Any]]{
                array.forEach({ (item) in
                    types.append(item)
                })
                
            }
        }
        
        //getting all moves of pokemon
        if let path_for_moves = Bundle.main.path(forResource: "allmoves", ofType: "plist") {
            if let array = NSArray.init(contentsOfFile: path_for_moves) as? [[String : Any]]{
                array.forEach({ (item) in
                    allmoves.append(item)
                })
            }
        }
        
        
        //Customizing the title label for pokemon
        let pokemon_name : UILabel = UILabel()
        pokemon_name.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(pokemon_name)
        
        pokemon_name.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        pokemon_name.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor).isActive = true
        pokemon_name.topAnchor.constraint(equalTo: self.topView.topAnchor).isActive = true
        pokemon_name.heightAnchor.constraint(equalToConstant: 30).isActive = true
        pokemon_name.textAlignment = NSTextAlignment.center
        // pokemon_name.backgroundColor = UIColor.black
       
        
        if let name = pokemon["name"] as? String{
            pokemon_name.font = UIFont(name: "Menlo-Bold", size: 25)
            pokemon_name.textColor = UIColor.white
            pokemon_name.text = name
        }
        
        //customizing background behind pokemon image
        let pokemon_background = UIImageView()
        pokemon_background.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(pokemon_background)
        pokemon_background.topAnchor.constraint(equalTo: pokemon_name.bottomAnchor).isActive = true
        pokemon_background.heightAnchor.constraint(equalToConstant: 180).isActive = true
        pokemon_background.widthAnchor.constraint(equalToConstant: 180).isActive = true
        pokemon_background.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pokemon_background.image = UIImage(named: "pokemon_bg")
        pokemon_background.contentMode = UIViewContentMode.scaleAspectFit
        
        //customizing pokemon image
        let pokemon_image = UIImageView()
        pokemon_image.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(pokemon_image)
        pokemon_image.topAnchor.constraint(equalTo: pokemon_name.bottomAnchor, constant : 15).isActive = true
        pokemon_image.heightAnchor.constraint(equalToConstant: 122).isActive = true
        pokemon_image.widthAnchor.constraint(equalToConstant: 122).isActive = true
        pokemon_image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pokemon_image.contentMode = UIViewContentMode.scaleAspectFit
        
        if let num = pokemon["num"] as? String{
            let image = "main\(num)"
            pokemon_image.image = UIImage(named: image)
        }
        
        //customizing the types of pokemon label(type1 and type2)
        var types_of_pokemon : [UILabel] = [UILabel]()
        //customizing the type1
        if let type1_of_pokemon = pokemon["type1"] as? String {
            var type : [String : Any] = [String : Any]()
            types.forEach({ (item) in
                if let name = item["name"] as? String{
                    if name == type1_of_pokemon {
                        type = item
                        type1 = item
                    }
                }
            })
            types_of_pokemon.append(createTypeLabel(type: type))
        }
        
        //customizing type 2
        if let type2_of_pokemon = pokemon["type2"] as? String {
            if type2_of_pokemon != "nil" {
                var type : [String : Any] = [String : Any]()
                types.forEach({ (item) in
                    if let name = item["name"] as? String{
                        if name == type2_of_pokemon {
                            type = item
                            type2 = item
                        }
                    }
                })
                
                let label = UILabel()
                label.font = UIFont(name: "Menlo-Bold", size: 18)
                label.textColor = UIColor.white
                label.textAlignment = NSTextAlignment.center
                label.frame = CGRect(x: 0, y: 400, width: 100, height: 30)
                if let name = type["name"] {
                    label.text = name as? String
                }
                if let color = type["color_code"] as? String{
                    label.backgroundColor = UIColor(hex: color)
                }
                types_of_pokemon.append(createTypeLabel(type: type))
            }
        }
        
      
        //stack view for the managing the types of pokemon with respect to its count
        let types_stackView = UIStackView(arrangedSubviews: types_of_pokemon)
        types_stackView.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(types_stackView)
        types_stackView.alignment = .fill
        types_stackView.distribution = .fillEqually
        
//        types_stackView.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor).isActive = true
//        types_stackView.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor).isActive = true
        types_stackView.topAnchor.constraint(equalTo: pokemon_background.bottomAnchor).isActive  = true
        types_stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        if types_of_pokemon.count == 1 {
            types_stackView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        }
        else{
            types_stackView.widthAnchor.constraint(equalToConstant: 250).isActive = true
            types_stackView.spacing = 10
        }
        types_stackView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        types_stackView.backgroundColor = UIColor.orange
        
        //Managing the strength and weak type of pokemon
        
        if type2.count == 0 {
            pokemonStrongAgainst = getStrongOrWeakAgainstFromType(type: type1, field_name: "strong_against")
            
            pokemonWeakAgainst = getStrongOrWeakAgainstFromType(type: type1, field_name: "weak_against")
        }else{
            var strong : [String] = [String]()
            var weak : [String] = [String]()
            
            if let strong1 = type1["strong_against"] as? [String]{
                if let weak2 = type2["weak_against"] as? [String] {
                    strong1.forEach({ (s) in
                        var count = 0
                        weak2.forEach({ (w) in
                            if s == w{
                                count += 1
                            }
                        })
                        if count == 0{
                            strong.append(s)
                        }
                    })
                    
                    weak2.forEach({ (w) in
                        var count = 0
                        strong1.forEach({ (s) in
                            if s == w{
                                count += 1
                            }
                        })
                        if count == 0{
                            weak.append(w)
                        }
                    })
                }
            }
            
            if let strong2 = type2["strong_against"] as? [String]{
                if let weak1 = type1["weak_against"] as? [String] {
                    strong2.forEach({ (s) in
                        var count = 0
                        weak1.forEach({ (w) in
                            if s == w{
                                count += 1
                            }
                        })
                        if count == 0{
                            var count2 = 0
                            strong.forEach({ (st) in
                                if s == st {
                                    count2 += 1
                                }
                            })
                            if count2 == 0{
                                strong.append(s)
                            }
                            
                        }
                    })
                    
                    weak1.forEach({ (w) in
                        var count = 0
                        strong2.forEach({ (s) in
                            if s == w{
                                count += 1
                            }
                        })
                        if count == 0{
                            var count2 = 0
                           weak.forEach({ (we) in
                                if w == we {
                                    count2 += 1
                                }
                            })
                            if count2 == 0{
                                weak.append(w)
                            }

                        }
                    })
                }
            }
            pokemonStrongAgainst = getStrongAgainstOrWeakAgainstFromArray(temp: strong)
            pokemonWeakAgainst = getStrongAgainstOrWeakAgainstFromArray(temp: weak)
        }
        
//        print("Strong")
//        pokemonStrongAgainst.forEach { (item) in
//            print(item["name"])
//        }
//        print("weak")
//        pokemonWeakAgainst.forEach { (item) in
//            print(item["name"])
//        }
        
        
        /*
         *
         *customizing the pokemon features view
         *
         */
        var HEIGHT_FOR_FEATURES_VIEW = 0
        
        if pokemonStrongAgainst.count > pokemonWeakAgainst.count {
            HEIGHT_FOR_FEATURES_VIEW = pokemonStrongAgainst.count + 1
        }else{
            HEIGHT_FOR_FEATURES_VIEW = pokemonWeakAgainst.count + 1
        }
        
        self.mainScrollView.addSubview(featuresView)
        featuresView.translatesAutoresizingMaskIntoConstraints = false
        featuresView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant : 8).isActive = true
        featuresView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor , constant : -8).isActive  = true
        featuresView.topAnchor.constraint(equalTo: topView.bottomAnchor , constant : 8).isActive  = true
        featuresView.heightAnchor.constraint(equalToConstant: CGFloat((5 * HEIGHT_FOR_FEATURES_VIEW) + (36 * HEIGHT_FOR_FEATURES_VIEW) + 10)).isActive = true
        featuresView.backgroundColor = UIColor(red: 0.9569, green: 0.9412, blue: 0.902, alpha: 0.5)
        featuresView.layer.cornerRadius = 5
        featuresView.clipsToBounds = true
        
        //adding top bar to the features view
        let featuresView_topBar : UIView = UIView()
        createTopBar(parentView: featuresView, childView: featuresView_topBar, color: UIColor.red)
        
        let WIDTH_OF_FEATURES_VIEW = self.view.frame.width - 16
        
        //customizing the left side strong view
        let featuresView_strongView : UIView = UIView()
        featuresView.addSubview(featuresView_strongView)
        featuresView_strongView.translatesAutoresizingMaskIntoConstraints = false
        featuresView_strongView.leadingAnchor.constraint(equalTo: featuresView.leadingAnchor).isActive = true
        featuresView_strongView.widthAnchor.constraint(equalToConstant: WIDTH_OF_FEATURES_VIEW/2).isActive = true
        featuresView_strongView.topAnchor.constraint(equalTo: featuresView_topBar.bottomAnchor).isActive  = true
        featuresView_strongView.bottomAnchor.constraint(equalTo: featuresView.bottomAnchor).isActive  = true
        //featuresView_strongView.backgroundColor = UIColor.green
        
        //customizing the right side weak view
        let featuresView_weakView : UIView = UIView()
        featuresView.addSubview(featuresView_weakView)
        featuresView_weakView.translatesAutoresizingMaskIntoConstraints = false
        featuresView_weakView.leadingAnchor.constraint(equalTo: featuresView_strongView.trailingAnchor).isActive = true
        featuresView_weakView.widthAnchor.constraint(equalToConstant: WIDTH_OF_FEATURES_VIEW/2).isActive = true
        featuresView_weakView.topAnchor.constraint(equalTo: featuresView_topBar.bottomAnchor).isActive  = true
        featuresView_weakView.bottomAnchor.constraint(equalTo: featuresView.bottomAnchor).isActive  = true
        //featuresView_weakView.backgroundColor = UIColor.purple
        
        //adding strong against
        var COUNT_FOR_STRONG_AGAINST = 1
        //creating title
        let featuresView_strong_titleLabel : UILabel = UILabel()
        createTitleLabel(text: "Strong Against", parentView: featuresView_strongView, label: featuresView_strong_titleLabel)
        
        pokemonStrongAgainst.forEach { (strong_type) in
            let temp_label  = createTypeLabel(type: strong_type)
            featuresView_strongView.addSubview(temp_label)
            temp_label.translatesAutoresizingMaskIntoConstraints = false
            temp_label.centerXAnchor.constraint(equalTo: featuresView_strongView.centerXAnchor).isActive = true
            temp_label.heightAnchor.constraint(equalToConstant: 36).isActive = true
            temp_label.widthAnchor.constraint(equalToConstant: 140).isActive = true
            temp_label.topAnchor.constraint(equalTo: featuresView_strongView.topAnchor, constant : CGFloat((5 * COUNT_FOR_STRONG_AGAINST) + (36 * COUNT_FOR_STRONG_AGAINST) + 5)).isActive  = true
            COUNT_FOR_STRONG_AGAINST += 1
        }
        
        //adding weak against
        var COUNT_FOR_WEAK_AGAINST = 1
        //creating title
        let featuresView_weak_titleLabel : UILabel = UILabel()
        createTitleLabel(text: "Weak Against", parentView: featuresView_weakView, label: featuresView_weak_titleLabel)
        pokemonWeakAgainst.forEach { (weak_type) in
            let temp_label  = createTypeLabel(type: weak_type)
            featuresView_weakView.addSubview(temp_label)
            temp_label.translatesAutoresizingMaskIntoConstraints = false
            temp_label.centerXAnchor.constraint(equalTo: featuresView_weakView.centerXAnchor).isActive = true
            temp_label.heightAnchor.constraint(equalToConstant: 36).isActive = true
            temp_label.widthAnchor.constraint(equalToConstant: 140).isActive = true
            temp_label.topAnchor.constraint(equalTo: featuresView_weakView.topAnchor, constant : CGFloat((5 * COUNT_FOR_WEAK_AGAINST) + (36 * COUNT_FOR_WEAK_AGAINST) + 5)).isActive  = true
            COUNT_FOR_WEAK_AGAINST += 1
        }
        
        
        /*
         *
         *customizing the allmoves view
         *
         */
                
        self.mainScrollView.addSubview(allMovesView)
        allMovesView.translatesAutoresizingMaskIntoConstraints = false
        allMovesView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        allMovesView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive  = true
        allMovesView.topAnchor.constraint(equalTo: featuresView.bottomAnchor, constant: 8).isActive  = true
        allMovesView.backgroundColor = UIColor(red: 0.9569, green: 0.9412, blue: 0.902, alpha: 0.5)
        allMovesView.layer.cornerRadius  = 5
        allMovesView.clipsToBounds  = true
        
        //adding green bar to allmoves view
        let allMovesView_topBar : UIView = UIView()
        createTopBar(parentView: allMovesView, childView: allMovesView_topBar, color: UIColor.green)
        
        //add  moves label
        let allMoveView_titleView = UIView()
        allMovesView.addSubview(allMoveView_titleView)
        allMoveView_titleView.translatesAutoresizingMaskIntoConstraints = false
        allMoveView_titleView.topAnchor.constraint(equalTo: allMovesView_topBar.bottomAnchor).isActive  = true
        allMoveView_titleView.leadingAnchor.constraint(equalTo: allMovesView.leadingAnchor).isActive  = true
        allMoveView_titleView.trailingAnchor.constraint(equalTo: allMovesView.trailingAnchor).isActive  = true
        allMoveView_titleView.heightAnchor.constraint(equalToConstant: 36).isActive = true

        
        let allMovesView_titleLabel = UILabel()
        createTitleLabel(text: "All Moves", parentView: allMoveView_titleView, label: allMovesView_titleLabel)
        
        var QUICKMOVES_LENGTH = 1
        if let quickmoves = pokemon["quick_moves"] as? [String]{
            QUICKMOVES_LENGTH += quickmoves.count
        }
        
        
        //creatingg quick moves view
        let quickMovesView : UIView = UIView()
        quickMovesView.translatesAutoresizingMaskIntoConstraints = false
        allMovesView.addSubview(quickMovesView)
        quickMovesView.leadingAnchor.constraint(equalTo: allMovesView.leadingAnchor).isActive  = true
        quickMovesView.trailingAnchor.constraint(equalTo: allMovesView.trailingAnchor).isActive = true
        quickMovesView.topAnchor.constraint(equalTo: allMoveView_titleView.bottomAnchor).isActive = true
        quickMovesView.heightAnchor.constraint(equalToConstant: CGFloat(QUICKMOVES_LENGTH * 36)).isActive  = true
        
        //creating quick moves table
        createMovesTable(title: "Quick Moves", parentView: quickMovesView , search_field: "quick_moves" )
        
        var CHARGEMOVES_LENGTH = 1
        if let chargemoves = pokemon["charge_moves"] as? [String]{
            CHARGEMOVES_LENGTH += chargemoves.count
        }
        
        //creating charge move view
        let chargeMovesView : UIView = UIView()
        chargeMovesView.translatesAutoresizingMaskIntoConstraints = false
        allMovesView.addSubview(chargeMovesView)
        chargeMovesView.leadingAnchor.constraint(equalTo: allMovesView.leadingAnchor).isActive  = true
        chargeMovesView.trailingAnchor.constraint(equalTo: allMovesView.trailingAnchor).isActive = true
        chargeMovesView.topAnchor.constraint(equalTo: quickMovesView.bottomAnchor , constant : 8).isActive = true
        chargeMovesView.heightAnchor.constraint(equalToConstant: CGFloat(CHARGEMOVES_LENGTH * 36)).isActive  = true
        
        //creating charged move table
        createMovesTable(title: "Charge Moves", parentView: chargeMovesView, search_field: "charge_moves")
        
        //calculating the height of allmoves view
        allMovesView.bottomAnchor.constraint(equalTo: chargeMovesView.bottomAnchor).isActive = true
        
        /*
         *
         *customizing best moves sets
         *
         */
        self.mainScrollView.addSubview(bestmovesView)
        bestmovesView.translatesAutoresizingMaskIntoConstraints = false
        bestmovesView.topAnchor.constraint(equalTo: allMovesView.bottomAnchor , constant : 8).isActive  = true
        bestmovesView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant : 8).isActive  = true
        bestmovesView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant : -8).isActive = true
        bestmovesView.backgroundColor  = UIColor(red: 0.9569, green: 0.9412, blue: 0.902, alpha: 0.5)
        bestmovesView.layer.cornerRadius = 5
        bestmovesView.clipsToBounds = true
        
        var bestmovesView_topBar = UIView()
        //creating top bar
        createTopBar(parentView: bestmovesView, childView: bestmovesView_topBar, color: UIColor.purple)
        
        //add best moves title View
        let bestmovesView_titleView = UIView()
        bestmovesView.addSubview(bestmovesView_titleView)
        bestmovesView_titleView.translatesAutoresizingMaskIntoConstraints = false
        bestmovesView_titleView.topAnchor.constraint(equalTo: bestmovesView_topBar.bottomAnchor).isActive  = true
        bestmovesView_titleView.leadingAnchor.constraint(equalTo: bestmovesView.leadingAnchor).isActive  = true
        bestmovesView_titleView.trailingAnchor.constraint(equalTo: bestmovesView.trailingAnchor).isActive  = true
        bestmovesView_titleView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        //add best moves title
        let bestmovesView_titleLabel = UILabel()
        createTitleLabel(text: "Best Move Sets", parentView: bestmovesView_titleView, label: bestmovesView_titleLabel)
        
        //creating best off move table view
        let bestOffMovesView : UIView = UIView()
        bestOffMovesView.translatesAutoresizingMaskIntoConstraints = false
        bestmovesView.addSubview(bestOffMovesView)
        bestOffMovesView.leadingAnchor.constraint(equalTo: bestmovesView.leadingAnchor).isActive  = true
        bestOffMovesView.trailingAnchor.constraint(equalTo: bestmovesView.trailingAnchor).isActive = true
        bestOffMovesView.topAnchor.constraint(equalTo: bestmovesView_titleView.bottomAnchor).isActive = true
        bestOffMovesView.heightAnchor.constraint(equalToConstant: 36 * 3).isActive  = true
        
        //creating best off moves table
        createMovesTable(title: "Best Offence", parentView: bestOffMovesView, search_field: "off")
        
        //creating best def move table view
        let bestDefMovesView : UIView = UIView()
        bestDefMovesView.translatesAutoresizingMaskIntoConstraints = false
        bestmovesView.addSubview(bestDefMovesView)
        bestDefMovesView.leadingAnchor.constraint(equalTo: bestmovesView.leadingAnchor).isActive  = true
        bestDefMovesView.trailingAnchor.constraint(equalTo: bestmovesView.trailingAnchor).isActive = true
        bestDefMovesView.topAnchor.constraint(equalTo: bestOffMovesView.bottomAnchor , constant : 8).isActive = true
        bestDefMovesView.heightAnchor.constraint(equalToConstant: 36 * 3).isActive  = true
        
        //creating best fed moves table
        createMovesTable(title: "Best Defence", parentView: bestDefMovesView, search_field: "def")
        
        //calculating the height of best move view
        bestmovesView.bottomAnchor.constraint(equalTo: bestDefMovesView.bottomAnchor).isActive = true
        
        /*
         *
         *Customizing Map Cp View
         *
         */
        
        self.mainScrollView.addSubview(maxCpView)
        maxCpView.translatesAutoresizingMaskIntoConstraints = false
        maxCpView.topAnchor.constraint(equalTo: bestmovesView.bottomAnchor, constant : 8).isActive = true
        maxCpView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant : 8).isActive = true
        maxCpView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor , constant : -8).isActive = true
        maxCpView.heightAnchor.constraint(equalToConstant: 5 * 36 + 5).isActive  = true
        maxCpView.backgroundColor = UIColor(red: 0.9569, green: 0.9412, blue: 0.902, alpha: 0.5)
        maxCpView.layer.cornerRadius  = 5
        maxCpView.clipsToBounds = true
        
        let maxCpView_topBar = UIView()
        createTopBar(parentView: maxCpView, childView: maxCpView_topBar, color: UIColor.yellow)
        
        let maxCpView_titleView = UIView()
        maxCpView_titleView.translatesAutoresizingMaskIntoConstraints = false
        maxCpView.addSubview(maxCpView_titleView)
        maxCpView_titleView.topAnchor.constraint(equalTo: maxCpView_topBar.bottomAnchor).isActive = true
        maxCpView_titleView.leadingAnchor.constraint(equalTo: maxCpView.leadingAnchor).isActive = true
        maxCpView_titleView.trailingAnchor.constraint(equalTo: maxCpView.trailingAnchor).isActive  = true
        maxCpView_titleView.heightAnchor.constraint(equalToConstant: 36).isActive  = true
        
        let maxCp_titleLabel : UILabel = UILabel()
        createTitleLabel(text: "Max CP", parentView: maxCpView_titleView, label: maxCp_titleLabel)
        
        
        if let max_cp = pokemon["max_cp"] as? String{
            let max_cp_double : Double = Double(max_cp)!
            var level_array  = ["Level","20","30","39"]
            var cp_array = ["Max CP","\(Int(max_cp_double - (max_cp_double * 42.05 / 100)))",
                                  "\(Int( max_cp_double - (max_cp_double * 13.05 / 100)))",
                                  "\(Int(max_cp)!)"]
            for index in 0...3{
                let level_label = createTextLabel(title: "\(level_array[index])")
                let cp_label = createTextLabel(title: "\(cp_array[index])")
                if index == 0 {
                    level_label.font = UIFont(name: "Menlo-Bold", size: 15)
                    cp_label.font = UIFont(name: "Menlo-Bold", size: 15)
                }
                let stackView :UIStackView = UIStackView(arrangedSubviews: [level_label,cp_label])
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.alignment = .fill
                stackView.distribution = .fillEqually
                maxCpView.addSubview(stackView)
                stackView.topAnchor.constraint(equalTo: maxCpView_titleView.bottomAnchor , constant : CGFloat(index * 36)).isActive = true
                stackView.leadingAnchor.constraint(equalTo: maxCpView.leadingAnchor).isActive  = true
                stackView.trailingAnchor.constraint(equalTo: maxCpView.trailingAnchor).isActive = true
                stackView.heightAnchor.constraint(equalToConstant: 36).isActive  = true
                stackView.backgroundColor  = UIColor.red
                if index % 2 == 0 {
                    level_label.backgroundColor  = UIColor(red: 0.5176, green: 0.5098, blue: 0.5059, alpha: 0.5)
                    cp_label.backgroundColor = UIColor(red: 0.5176, green: 0.5098, blue: 0.5059, alpha: 0.5)
                }
                if index == 0 {
                    level_label.backgroundColor  = UIColor(red: 0.1098, green: 0.1059, blue: 0.1059, alpha: 0.5)
                    cp_label.backgroundColor = UIColor(red: 0.1098, green: 0.1059, blue: 0.1059, alpha: 0.5)
                }
                
            }
        }
        
        //customizing the height of mainScroll View
        mainScrollView.bottomAnchor.constraint(equalTo:  maxCpView.bottomAnchor , constant : 8).isActive  = true
        
    }
    
    func createMovesTable(title : String , parentView : UIView , search_field : String ){
        //title of table
        let array_titles = ["",title,"PWR","DPS","EPS","Time"]
        let array_area : [CGFloat] = [10,30,15,15,15,15]
        var array_label : [UILabel] = [UILabel]()
        
        let title_view = UIView()
        title_view.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(title_view)
        title_view.topAnchor.constraint(equalTo: parentView.topAnchor).isActive  = true
        title_view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive  = true
        title_view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive  = true
        title_view.heightAnchor.constraint(equalToConstant: 36).isActive = true
        title_view.backgroundColor = UIColor(red: 0.1098, green: 0.1059, blue: 0.1059, alpha: 0.5)
        
        for index in 0..<array_titles.count {
            let label = UILabel()
            label.text = array_titles[index]
            label.textColor = UIColor.white
            label.font = UIFont(name: "Menlo-Bold", size: 15)
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = NSTextAlignment.center
            title_view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            if index != 0 {
                label.leadingAnchor.constraint(equalTo: array_label[index - 1].trailingAnchor).isActive = true
            }
            else{
                label.leadingAnchor.constraint(equalTo: title_view.leadingAnchor).isActive = true
            }
            label.topAnchor.constraint(equalTo: title_view.topAnchor).isActive = true
            label.widthAnchor.constraint(equalToConstant: (TABLLE_SIZE * array_area[index]/100)).isActive  = true
            label.heightAnchor.constraint(equalToConstant: 36).isActive  = true
            array_label.append(label)
        }
        
     //Getting Moves
        var moves : [[String : Any]] = [[String : Any]]()
        if let moves_string = pokemon[search_field] as? [String]{
           moves_string.forEach({ (name) in
                allmoves.forEach({ (al_m) in
                    if let al_m_name = al_m["name"] as? String{
                        if name == al_m_name{
                            moves.append(al_m)
                        }
                    }
                })
           })
        }
        
        //count for each moves
        var COUNT_FOR_EACH_MOVE : CGFloat = 1
        moves.forEach { (move) in
            let each_move_view = UIView()
            each_move_view.translatesAutoresizingMaskIntoConstraints = false
            parentView.addSubview(each_move_view)
            each_move_view.topAnchor.constraint(equalTo: parentView.topAnchor, constant : COUNT_FOR_EACH_MOVE * 36).isActive  = true
            each_move_view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive  = true
            each_move_view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive  = true
            each_move_view.heightAnchor.constraint(equalToConstant: 36).isActive = true
            
            if Int(COUNT_FOR_EACH_MOVE) % 2 == 0{
                each_move_view.backgroundColor = UIColor(red: 0.5176, green: 0.5098, blue: 0.5059, alpha: 0.5)
            }
            
            let imageView : UIImageView = UIImageView()
            if let move_type = move["type"] as? String{
                var type_detail : [String : Any]  = [String : Any]()
                types.forEach({ (type) in
                    if let name = type["name"] as? String{
                        if name == move_type{
                            type_detail = type
                        }
                    }
                })
                
                if let icon_name = type_detail["icon"] as? String{
                    
                    each_move_view.addSubview(imageView)
                    imageView.contentMode = .scaleAspectFit
                    imageView.image = UIImage(named: icon_name)
                    imageView.translatesAutoresizingMaskIntoConstraints  = false
                    imageView.topAnchor.constraint(equalTo: each_move_view.topAnchor).isActive = true
                    imageView.leadingAnchor.constraint(equalTo: each_move_view.leadingAnchor , constant : (TABLLE_SIZE * array_area[0] / 100)/2).isActive  = true
                    imageView.widthAnchor.constraint(equalToConstant: (TABLLE_SIZE * array_area[0] / 100)/2 ).isActive  = true
                    imageView.heightAnchor.constraint(equalToConstant: 36).isActive  = true
                    
                }
            }
            
            var name_label = UILabel()
            if let name = move["name"] as? String{
                name_label = createTextLabel(title: name)
                name_label.translatesAutoresizingMaskIntoConstraints = false
                each_move_view.addSubview(name_label)
                name_label.topAnchor.constraint(equalTo: each_move_view.topAnchor).isActive = true
                name_label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
                name_label.widthAnchor.constraint(equalTo: array_label[1].widthAnchor).isActive  = true
                name_label.heightAnchor.constraint(equalToConstant: 36).isActive = true
               
            }
            
            var pwr_label = UILabel()
            if let pwr = move["pwr"] as? String{
                pwr_label = createTextLabel(title: pwr)
                pwr_label.translatesAutoresizingMaskIntoConstraints = false
                each_move_view.addSubview(pwr_label)
                pwr_label.topAnchor.constraint(equalTo: each_move_view.topAnchor).isActive = true
                pwr_label.leadingAnchor.constraint(equalTo: name_label.trailingAnchor).isActive = true
                pwr_label.widthAnchor.constraint(equalTo: array_label[2].widthAnchor).isActive  = true
                pwr_label.heightAnchor.constraint(equalToConstant: 36).isActive = true
            }
            
            var dps_label = UILabel()
            if let dps = move["dps"] as? String{
                dps_label = createTextLabel(title: dps)
                dps_label.translatesAutoresizingMaskIntoConstraints = false
                each_move_view.addSubview(dps_label)
                dps_label.topAnchor.constraint(equalTo: each_move_view.topAnchor).isActive = true
                dps_label.leadingAnchor.constraint(equalTo: pwr_label.trailingAnchor).isActive = true
                dps_label.widthAnchor.constraint(equalTo: array_label[3].widthAnchor).isActive  = true
                dps_label.heightAnchor.constraint(equalToConstant: 36).isActive = true
            }
            
            var eps_label = UILabel()
            if let eps = move["eps"] as? String{
                eps_label = createTextLabel(title: eps)
                eps_label.translatesAutoresizingMaskIntoConstraints = false
                each_move_view.addSubview(eps_label)
                eps_label.topAnchor.constraint(equalTo: each_move_view.topAnchor).isActive = true
                eps_label.leadingAnchor.constraint(equalTo: dps_label.trailingAnchor).isActive = true
                eps_label.widthAnchor.constraint(equalTo: array_label[4].widthAnchor).isActive  = true
                eps_label.heightAnchor.constraint(equalToConstant: 36).isActive = true
            }
            
            var time_label = UILabel()
            if let time = move["time"] as? String{
                time_label = createTextLabel(title: time)
                time_label.translatesAutoresizingMaskIntoConstraints = false
                each_move_view.addSubview(time_label)
                time_label.topAnchor.constraint(equalTo: each_move_view.topAnchor).isActive = true
                time_label.leadingAnchor.constraint(equalTo: eps_label.trailingAnchor).isActive = true
                time_label.widthAnchor.constraint(equalTo: array_label[5].widthAnchor).isActive  = true
                time_label.heightAnchor.constraint(equalToConstant: 36).isActive = true
            }
            //increasing count
           COUNT_FOR_EACH_MOVE += 1
            
            
        }
        
        
        
        
    }
    
    func createTextLabel(title : String) -> UILabel{
        let label = UILabel()
        label.text = title
        label.textColor = UIColor.white
        label.font = UIFont(name: "Menlo", size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment  = NSTextAlignment.center
        return label
    }
    
    func createTopBar(parentView : UIView , childView: UIView ,color : UIColor){
        parentView.addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints  = false
        childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive  = true
        childView.topAnchor.constraint(equalTo: parentView.topAnchor).isActive  = true
        childView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        childView.backgroundColor = color
    }
    
    func compareStrongVsWeak(compareThis : [String : Any] ,compareThis_field_name : String, compareTo : [String : Any],compareTo_field_name : String) -> [String]{
        
        var result_types : [String] = [String]()
        
        
        if let first = compareThis[compareTo_field_name] as? [String]{
            if let second = compareTo[compareTo_field_name] as? [String] {
                first.forEach({ (s) in
                    var count = 0
                    second.forEach({ (w) in
                        if s == w{
                            count += 1
                        }
                    })
                    if count == 0{
                        var count2 = 0
                        result_types.forEach({ (st) in
                            if s == st {
                                count2 += 1
                            }
                        })
                        if count2 == 0{
                            result_types.append(s)
                        }
                        
                    }
                })
            }
        }
        return result_types
        
    }
    
    func getStrongOrWeakAgainstFromType(type : [String :Any] , field_name : String) -> [[String : Any]] {
        var tempArray : [[String : Any]] = [[String : Any]]()
        if let temp : [String] = type1[field_name] as? [String] {
            tempArray  = getStrongAgainstOrWeakAgainstFromArray(temp: temp)
        }
        return tempArray
    }
    
    func getStrongAgainstOrWeakAgainstFromArray(temp : [String]) -> [[String : Any]]{
        var tempArray : [[String : Any]] = [[String : Any]]()
        temp.forEach({ (type_name) in
            types.forEach({ (temp_type) in
                if let name_ts = type_name as? String{
                    if let name_tt = temp_type["name"] as? String{
                        if name_ts == name_tt{
                            tempArray.append(temp_type)
                        }
                    }
                }
            })
        })
        return tempArray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTypeLabel(type : [String : Any]) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Menlo-Bold", size: 18)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        if let name = type["name"] {
            label.text = name as? String
        }
        if let color = type["color_code"] as? String{
            label.backgroundColor = UIColor(hex: color)
        }
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
       return label
    }
    
    func createTitleLabel(text : String , parentView : UIView , label : UILabel){
        label.font = UIFont(name: "Menlo-Bold", size: 15)
        label.text = text
        label.textAlignment = NSTextAlignment.center
        parentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: parentView.topAnchor , constant : 5).isActive  = true
        label.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive  = true
        label.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive  = true
        label.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    
}

extension UIColor {
    
    // MARK: - Initialization
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.characters.count
        
        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    // MARK: - Computed Properties
    
    var toHex: String? {
        return toHex()
    }
    
    // MARK: - From UIColor to String
    
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
}
