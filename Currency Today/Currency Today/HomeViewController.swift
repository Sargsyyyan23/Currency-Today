//
//  HomeViewController.swift
//  Currency Today
//
//  Created by Student on 18.07.25.
//

import UIKit

class CourseOption {
    var name: String
    var currency: String
    var backgroundimage: UIImage
    var backgroundcolor: UIColor
    var course: String
    
    init(name: String, currency: String, backgroundimage: UIImage, backgroundcolor: UIColor, course: String) {
        self.name = name
        self.currency = currency
        self.backgroundimage = backgroundimage
        self.backgroundcolor = backgroundcolor
        self.course = course
    }
}

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    var models = [CourseOption]()
    var currencyCode: [String] = []
    var volues: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        getCurrentDate()
        configure()
        fetchJson()
    }
    
    func fetchJson(){
            guard let url = URL(string: "https://open.er-api.com/v6/latest/AMD") else {return}
            URLSession.shared.dataTask(with: url) {[self] (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                guard let safeData = data else {return}
                do{
                    let rezults = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
                    self.currencyCode.append(contentsOf: rezults.rates.keys)
                    self.volues.append(contentsOf: rezults.rates.values)
                    rezults.rates.forEach { (key, value) in
                        self.models = self.models.map {
                            if $0.name == key {
                                let courseKey = (Double(models[0].course) ?? 0)/value
                                $0.course = "\(Double(round(100 * courseKey) / 100))"
                            }
                            return $0
                        }

                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                catch {
                    print(error)
                }
            }.resume()
        }
    
    func configure(){
        models.append(contentsOf: [
            CourseOption(name: "AMD", currency: "Armenia", backgroundimage: UIImage(named: "Armenia")!, backgroundcolor: .systemTeal, course: "1"),
            CourseOption(name: "RUB", currency: "Russia", backgroundimage: UIImage(named: "Russia")!, backgroundcolor: .systemTeal, course: "1"),
            CourseOption(name: "USD", currency: "USA", backgroundimage: UIImage(named: "USA")!, backgroundcolor: .systemTeal, course: "1"),
            CourseOption(name: "KRW", currency: "Korea", backgroundimage: UIImage(named: "Korea")!, backgroundcolor: .systemTeal, course: "1"),
            CourseOption(name: "UAH", currency: "Ukraine", backgroundimage: UIImage(named: "Ukraina")!, backgroundcolor: .systemTeal, course: "1"),
            CourseOption(name: "GEL", currency: "Georgia", backgroundimage: UIImage(named: "Georgia")!, backgroundcolor: .systemTeal, course: "1"),
            CourseOption(name: "EUR", currency: "Europe", backgroundimage: UIImage(named: "Euro")!, backgroundcolor: .systemTeal, course: "1"),
            CourseOption(name: "DKK", currency: "Danish", backgroundimage: UIImage(named: "Dan")!, backgroundcolor: .systemTeal, course: "1"),
            CourseOption(name: "EUR", currency: "Spain", backgroundimage: UIImage(named: "Ispania")!, backgroundcolor: .systemTeal, course: "1"),
            CourseOption(name: "KZT", currency: "Kazakhstan", backgroundimage: UIImage(named: "KZX")!, backgroundcolor: .systemTeal, course: "1"),
            CourseOption(name: "CNY", currency: "Thaliand", backgroundimage: UIImage(named: "THAIL")!, backgroundcolor: .systemTeal, course: "1"),
            CourseOption(name: "EUR", currency: "Greece", backgroundimage: UIImage(named: "Greece")!, backgroundcolor: .systemTeal, course: "1"),
        ])
    }
    
    func getCurrentDate(){
        var now = Date()
        var nowComponents = DateComponents()
        let calendar = Calendar.current
        nowComponents.year = Calendar.current.component(.year, from: now)
        nowComponents.month = Calendar.current.component(.month, from: now)
        nowComponents.day = Calendar.current.component(.day, from: now)
        nowComponents.timeZone = NSTimeZone.local
        now = calendar.date(from: nowComponents)!
        navBar.topItem?.title = "\(nowComponents.day!).\(nowComponents.month!).\(nowComponents.year!)"
    }
    
    @IBAction func change(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"ChangeViewController") as? ChangeViewController
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


extension HomeViewController: UITableViewDelegate,
    UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell =
                tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
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
    }
}
