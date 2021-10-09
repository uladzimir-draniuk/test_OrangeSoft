//
//  TownDescriptionView.swift
//  test_api
//
//  Created by elf on 26.09.2021.
//

import UIKit
import RealmSwift
import Kingfisher

class TownDescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /*
     Здесь ранее было выражение:
     var towns = try! [Town](withFile: "town1s")
     Именно так нам показывал на уроке преподователь, хотя и добавил при этом,
     что это неправильно и хороший программист не должен использовать форс анрап.
     Но времени у него было мало и поэтому он решил не искать выход из ситуации...
     А я вроде нашел выход, пусть и не элегантный, но всё приходит с опытом )
     */
    
    let defaultTown = Town(city: "", code: "")
    private var defaultTowns: [Town] {
        get
        {
           return [ defaultTown ]
        }
    }
    
    var towns = try? [Town](withFile: "towns")

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
        return towns?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TownCell", for: indexPath) as! TownTableViewCell
        
        cell.cityName.text = towns?[indexPath.item].city
        cell.cityCode.text = towns?[indexPath.item].code
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let casheTowns = try? Realm(configuration: RealmAdds.deleteIfMigration).objects(TownNew.self)
        {
            if let town = casheTowns.filter("city = %@", towns?[indexPath.item].city ?? "empty").first
            {
                if !checkIsNeedToUpdateWeather(date: town.date)
                {
                    configureTownView(town: town)
                }
                else
                {
                    downloadWeather(forTown: self.towns?[indexPath.item] ?? defaultTown)
                }
            }
            else
            {
                downloadWeather(forTown: self.towns?[indexPath.item] ?? defaultTown)
            }
        }
        else
        {
            print("There are any troubles with opening Realm base")
        }
    }
    
    func checkIsNeedToUpdateWeather(date: Date) -> Bool
    {
        let delta = date.distance(to: Date())
        print("delta = \(delta)")
        return delta > 3600
    }
    
    func downloadWeather(forTown: Town )
    {
        weatherApi.loadCity(cityName: forTown.city, code: forTown.code, completion: { [self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(loadedTown):
                try? RealmAdds.save(item: loadedTown, configuration: RealmAdds.deleteIfMigration, update: .modified)
                configureTownView(town: loadedTown)
            }
        })
    }
    
    func configureTownView(town: TownNew) {
        
        cityName.text = town.city
        cityCode.text = town.code
        cityTemp.text = String(Int(town.temperature)) + "\u{00B0}" + "C"
        cityDescription.text = desc
        weatherImage.kf.setImage(with: town.iconUrl)
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
                    else
                    {
                        self.view.removeConstraint(self.townDescrViewHeightSmall)
                        self.view.addConstraint(self.townDescrViewHeightBig)
                    }
                    self.view.layoutIfNeeded()
                },
            completion: nil)
        
        self.isTap.toggle()
    }
}


