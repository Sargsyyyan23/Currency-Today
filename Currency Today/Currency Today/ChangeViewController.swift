//
//  ChangeViewController.swift
//  Currency Today
//
//  Created by Student on 18.07.25.
//

import UIKit

class ChangeOption{
    var name: String
    var backgroundColor: UIColor
    var backgroundImage: UIImage
    var api: String
    
    init(name: String, backgroundColor: UIColor, backgroundImage: UIImage, api: String) {
        self.name = name
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.api = api
    }
}

class ChangeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var models = [ChangeOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChangeTableViewCell.self, forCellReuseIdentifier: ChangeTableViewCell.identifier)
        configure()
        
        
    }
    func configure(){
        models.append(contentsOf: [
            ChangeOption(name: "AMD", backgroundColor: .systemTeal, backgroundImage: UIImage(named:"Armenia")!, api: "https://open.er-api.com/v6/latest/AMD"),
            ChangeOption(name: "RUB", backgroundColor: .systemTeal, backgroundImage: UIImage(named:"Russia")!, api:  "https://open.er-api.com/v6/latest/RUB"),
            ChangeOption(name: "USD", backgroundColor: .systemTeal, backgroundImage: UIImage(named:"USA")!, api:  "https://open.er-api.com/v6/latest/USD"),
            ChangeOption(name: "KRW", backgroundColor: .systemTeal, backgroundImage: UIImage(named:"Korea")!, api:  "https://open.er-api.com/v6/latest/KRW"),
            ChangeOption(name: "UAH", backgroundColor: .systemTeal, backgroundImage: UIImage(named:"Ukraina")!, api:  "https://open.er-api.com/v6/latest/UAH"),
            ChangeOption(name: "GEL", backgroundColor: .systemTeal, backgroundImage: UIImage(named:"Georgia")!, api:  "https://open.er-api.com/v6/latest/GEL"),
            ChangeOption(name: "EUR", backgroundColor: .systemTeal, backgroundImage: UIImage(named:"Euro")!, api:  "https://open.er-api.com/v6/latest/EUR"),
            ChangeOption(name: "DKK", backgroundColor: .systemTeal, backgroundImage: UIImage(named:"Dan")!, api:  "https://open.er-api.com/v6/latest/DKK"),
            ChangeOption(name: "EUR", backgroundColor: .systemTeal, backgroundImage: UIImage(named:"Ispania")!, api:  "https://open.er-api.com/v6/latest/EUR"),
            ChangeOption(name: "KZT", backgroundColor: .systemTeal, backgroundImage: UIImage(named:"KZX")!, api:  "https://open.er-api.com/v6/latest/KZT"),
            ChangeOption(name: "CNY", backgroundColor: .systemTeal, backgroundImage: UIImage(named:"THAIL")!, api:  "https://open.er-api.com/v6/latest/CNY"),
            ChangeOption(name: "EUR", backgroundColor: .systemTeal, backgroundImage: UIImage(named:"Greece")!, api:  "https://open.er-api.com/v6/latest/EUR")

            
            
        ])
    }
    
    
    @IBAction func home(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as?  HomeViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
    @IBAction func settings(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as?  SettingsViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
}

extension ChangeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChangeTableViewCell.identifier, for: indexPath) as? ChangeTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        if models[indexPath.item].name != "" {
            let vc =
            storyboard?.instantiateViewController(withIdentifier: "ConvertViewController") as? ConvertViewController
            vc?.ap = models[indexPath.item].api
            vc?.text = models[indexPath.item].name
            self.present(vc!, animated: true)
        }
    }
}
