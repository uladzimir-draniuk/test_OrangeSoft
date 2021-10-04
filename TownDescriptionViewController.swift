//
//  TownDescriptionView.swift
//  test_api
//
//  Created by elf on 26.09.2021.
//

import UIKit

class TownDescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var towns = [
        Town(name: "Moscow", code: "RU", temp: 20),
        Town(name: "Minsk", code: "BY", temp: 15),
        Town(name: "Chicago", code: "US", temp: 14),
        Town(name: "Brest", code: "BY", temp: 25),
        Town(name: "Berlin", code: "DE", temp: 19),
        Town(name: "Ottava", code: "CA", temp: 11),
        Town(name: "Oslo", code: "NO", temp: 10),
        Town(name: "Sochi", code: "RU", temp: 21),
        Town(name: "Baghdad", code: "IQ", temp: 16),
        Town(name: "Kiev", code: "UA", temp: 13),
        Town(name: "London", code: "GB", temp: 9),
        Town(name: "Norilsk", code: "RU", temp: 5),
        Town(name: "Paris", code: "FR", temp: 17),
        Town(name: "Rome", code: "IT", temp: 27),
        Town(name: "Helsinki", code: "FI", temp: 18)
    ]
    
    
    let weatherApi = ApiWeatherFunc()
    
   
    @IBOutlet var townDescrView: UIView!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var cityName: UILabel!
    @IBOutlet var cityCode: UILabel!
    @IBOutlet var cityTemp: UILabel!
    @IBOutlet var cityDescription: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    let desc = "Это рандомное описание, подходящее для любого города мира. Город очень красивый, обладает развитой инфраструктурой и планировкой."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TownTableViewCell", bundle: nil), forCellReuseIdentifier: "TownCell")
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        townDescrView.addGestureRecognizer(tapRecognizer)
  
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

        weatherApi.loadCityTemp(cityName: self.towns[indexPath.item].name, code: self.towns[indexPath.item].code)
        cityName.text = towns[indexPath.item].name
        cityCode.text = towns[indexPath.item].code
        cityTemp.text = String(towns[indexPath.item].temp) + "\u{00B0}" + "C"
        cityDescription.text = desc
        townDescrView.setNeedsDisplay()
    }
     
    @IBOutlet var townDescrViewHeightSmall: NSLayoutConstraint!
    
    @IBOutlet var townDescrViewHeightBig: NSLayoutConstraint!
    
    var isTap = false
    
    @IBAction func handleTap(_ gesture: UITapGestureRecognizer) {
 
        UIView.animate(
            withDuration: 1.0,
            animations:
                {
                    if self.isTap
                    {
                        self.view.removeConstraint(self.townDescrViewHeightBig)
                        self.view.addConstraint(self.townDescrViewHeightSmall)
                    }
                    else {
                        self.view.removeConstraint(self.townDescrViewHeightSmall)
                        self.view.addConstraint(self.townDescrViewHeightBig)
                    }
                    self.view.layoutIfNeeded()
                },
            completion: nil)
            
        self.isTap.toggle()
      }

 }


