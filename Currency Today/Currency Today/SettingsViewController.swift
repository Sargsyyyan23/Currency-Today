//
//  SettingsViewController.swift
//  Currency Today
//
//  Created by Student on 18.07.25.
//

import UIKit

class SettingsOption {
    var name:String
    var backgroundColor: UIColor
    var backgroundImage: UIImage
    
    init(name: String, backgroundColor: UIColor, backgroundImage: UIImage) {
        self.name = name
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
    }
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var models = [SettingsOption]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        configure()
    }
    func configure(){
        models.append(contentsOf: [
            SettingsOption(name: "About program", backgroundColor: .systemTeal, backgroundImage:UIImage(systemName: "info.circle")!),
            SettingsOption(name: "Share", backgroundColor: .systemTeal, backgroundImage:UIImage(systemName: "square.and.arrow.up")!),
            SettingsOption(name: "Author", backgroundColor: .systemTeal, backgroundImage:UIImage(systemName: "person.crop.circle")!),
            SettingsOption(name: "Contact", backgroundColor: .systemTeal, backgroundImage:UIImage(systemName: "person.and.background.striped.horizontal")!),
            
            
        ])
    }
    
    @IBAction func home(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as?  HomeViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
    
    @IBAction func change(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChangeViewController") as? ChangeViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell
        else{
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
        if models[indexPath.item].name == "About program" {
            let alert = UIAlertController(title: "About", message: "Put simply, programming is giving a set of instructions to a computer to execute. If you’ve ever cooked using a recipe before, you can think of yourself as the computer and the recipe’s author as a programmer. The recipe author provides you with a set of instructions that you read and then follow. The more complex the instructions, the more complex the result!", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            self.present(alert, animated: true)
        }else if models[indexPath.item].name == "Author"{
            let alert = UIAlertController(title: "Author", message: "BY Seda Sargsyan", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            self.present(alert, animated: true)
        }else if models[indexPath.item].name == "Contact"{
            let actionSheet = UIAlertController(title: "Contact", message: nil, preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Facebook", style: .default, handler: { (action) in
                UIApplication.shared.open(URL(string: "https://www.facebook.com/")! as URL)
            }))
            actionSheet.addAction(UIAlertAction(title: "Instagram", style: .default, handler: { (action) in
                UIApplication.shared.open(URL(string: "https://www.instagram.com/")! as URL)
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(actionSheet, animated: true)
        }else if models[indexPath.item].name == "Share" {
            let activityVC = UIActivityViewController(activityItems: [""], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true)
        }
    }
}
