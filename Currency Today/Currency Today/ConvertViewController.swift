//
//  ConvertViewController.swift
//  Currency Today
//
//  Created by Student on 26.07.25.
//

import UIKit


class Picker{
    var name: String
    var count: Double
    
    init(name: String, count: Double) {
        self.name = name
        self.count = count
    }
}


class ConvertViewController: UIViewController {
    
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var currencyText: UITextField!
    
    @IBOutlet weak var pickerV: UIPickerView!
    
    @IBOutlet weak var firstCount: UILabel!
    
    var dataSource: [Picker] = []
    var activeCurrency = 0.0
    var ap:String = ""
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyText.delegate = self
        currencyText.isUserInteractionEnabled = false
        currencyText.placeholder = "Your Money"
        firstCount.minimumScaleFactor = 0.2
        pickerV.delegate = self
        pickerV.dataSource = self
        firstLabel.text = text
        currencyText.addTarget(self, action: #selector(updateViews), for: .editingChanged)
        fetchJson()
    }
    
    @IBAction func backView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteNum(_ sender: Any) {
        currencyText.text = String(currencyText.text!.dropLast())
    }
    
    @IBAction func enterNum(_ sender: Any) {
        guard let amount = currencyText.text, let theAmountText = Double(amount) else {return}
        if currencyText.text != "" {
            let total = theAmountText * activeCurrency
            firstCount.text = String(format: "%.2f" , total)
        }
    }
    
    @objc func updateViews(input: Double){
        guard let amount = currencyText.text, let theAmountText =
            Double(amount) else {return}
        if currencyText.text != "" {
            let total = theAmountText * activeCurrency
            firstCount.text = String(format: "%.2f" , total)
        }
    }
    
    @IBAction func getNum(_ sender: Any) {
        currencyText.text = currencyText.text! + String((sender as AnyObject).tag)
    }
    
    
    func fetchJson() {
        guard let url = URL(string: ap) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            guard let safeData = data else { return }
            do {
                let rezults = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
                
                self.dataSource = rezults.rates.map {
                    Picker(name: $0.key, count: $0.value)
                }.sorted(by: {$0.name < $1.name})
                DispatchQueue.main.async {
                    self.pickerV.reloadAllComponents()
                    self.activeCurrency = self.dataSource[0].count
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
}
    extension ConvertViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return dataSource.count
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return dataSource[row].name
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            activeCurrency = dataSource[row].count
            updateViews(input: activeCurrency)
        }
    }

