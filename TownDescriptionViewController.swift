//
//  TownDescriptionView.swift
//  test_for_OrangeSoft
//
//  Created by elf on 26.09.2021.
//

import UIKit

class TownDescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var towns = [
        Town(name: "Moscow", code: "RUS", temp: 20),
        Town(name: "Minsk", code: "BY", temp: 15),
        Town(name: "Chickago", code: "USA", temp: 14),
        Town(name: "Brest", code: "BY", temp: 25),
        Town(name: "Berlin", code: "GER", temp: 19),
        Town(name: "Ottava", code: "CAN", temp: 11),
        Town(name: "Oslo", code: "SWE", temp: 10),
        Town(name: "Sochi", code: "RUS", temp: 21),
        Town(name: "Oman", code: "SUA", temp: 22),
        Town(name: "Mogilev", code: "BY", temp: 16),
        Town(name: "Kiev", code: "UKR", temp: 13),
        Town(name: "London", code: "GBR", temp: 9),
        Town(name: "Norilsk", code: "RUS", temp: 5),
        Town(name: "Paris", code: "FRA", temp: 17),
        Town(name: "Rome", code: "ITA", temp: 27),
        Town(name: "Helsinki", code: "FIN", temp: 18)
    ]
    
   
    @IBOutlet var townDescrView: UIView!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var cityName: UILabel!
    @IBOutlet var cityCode: UILabel!
    @IBOutlet var cityTemp: UILabel!
    @IBOutlet var cityDescription: UILabel!
    
    let desc = "Это рандомное описание, подходящее для любого города мира. Город очень красивый, обладает развитой инфраструктурой и планировкой."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TownTableViewCell", bundle: nil), forCellReuseIdentifier: "TownCell")

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return towns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TownCell", for: indexPath) as! TownTableViewCell
   
    cell.cityName.text = towns[indexPath.item].name
    cell.cityCode.text = towns[indexPath.item].code
    
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        cityName.text = towns[indexPath.item].name
        cityCode.text = towns[indexPath.item].code
        cityTemp.text = String(towns[indexPath.item].temp) + "\u{00B0}" + "C"
        cityDescription.text = desc
        townDescrView.setNeedsDisplay()
    }
    
}

