//
//  ViewController.swift
//
//  Created by Harun Fazlic on 22. 6. 2022..
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet var backgroundImage: UIView!
    @IBOutlet private var weatherImage: UIImageView!
    @IBOutlet private var cityName: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        }
    }
    static var response : Welcome?{
        didSet{
            NotificationCenter.default.post(name: .init(rawValue: "result"), object: ViewController.response)
        }
    }
    
    @objc func didReieveData(){
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(didReieveData), name: .init(rawValue: <#T##String#>), object: <#T##Any?#>)
        
        
        
        
        tableView.dataSource = self
        //let myCurrentLocation = "Berlin"
        //var newMyCurrentLocation = myCurrentLocation
        //newMyCurrentLocation = newMyCurrentLocation.replacingOccurrences(of: " ", with: "%20")

        getData(from: CustomTableViewCell.url)

       

    }
    

    func getData(from url: String){
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data,  response, error in
            guard let data = data, error == nil else {
                print("error ")
                return
            }
            //have data
            var result: Welcome?
            do{
                result = try JSONDecoder().decode(Welcome.self, from: data)
            }catch{
                print("fail occured: \(error.localizedDescription)")
            }
            guard let json = result else {
                
                return
                
            }
            
            ViewController.response = json

            
            DispatchQueue.main.async { [self] in
             // json is type of Welcome...
            
                self.view.backgroundColor = UIColor.white
                self.cityName.textColor = .white
                self.temperatureLabel.textColor = .white
                self.statusLabel.textColor = .white
                
                self.cityName.text = json.location.name
                self.temperatureLabel.text = "\(json.current.tempC)°C"
                //line below to changed upon API code change
              //self.statusLabel.text = json.current.condition.text.description
              self.statusLabel.text = Text.clear.rawValue
                let isDay = json.current.isDay
                if isDay == 0 {
                    self.backgroundImage.backgroundColor = UIColor(patternImage: UIImage(named: "night.png")!)
                } else {
                    self.backgroundImage.backgroundColor = UIColor(patternImage: UIImage(named: "day.png")!)
                }
                //line below to changed upon API code change
                let testVar = String(json.current.condition.icon.dropFirst(2))
             // let testVar = Icon.cdnWeatherapiCOMWeather64X64Day113PNG.rawValue.dropFirst(2)
                do  {
                    let data = try Data.init(contentsOf: URL.init(string: "https://\(testVar)")!)
                    DispatchQueue.main.async {
                        let image: UIImage = UIImage(data: data)!
                        self.weatherImage.image = image
                    }
                } catch {
                    print(error)
                }
            }
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let neededData = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        
        cell.myLabel.text = neededData.weekday
        cell.temperatureLabel.text = neededData.weatherAndTemparature

        // once NeededData contains data for image myImageView and temperatureLabel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        76
    }
    
}









