//
//  CustomTableViewCell.swift
//
//  Created by Harun Fazlic on 29. 6. 2022..
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    static let identifier = "CustomTableViewCell"
    static let url = "https://api.weatherapi.com/v1/forecast.json?key=56e83888c32945628cc192400221107&q=London&days=5&aqi=no&alerts=no"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myImageView)
        contentView.addSubview(myLabel)
        contentView.addSubview(temperatureLabel)
    }
    
        var myLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            return label
        }()
        
       var myImageView: UIImageView = {
            let imageView = UIImageView()
           // imageView.image = UIImage(named: "day.png")
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            return imageView
        }()
        
          var temperatureLabel: UILabel = {
            let label = UILabel()
           // label.text = "26 / 32"
            label.textColor = .black
            return label
        }()

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //layoutSubviews is new viewDidLoad
//        let myCurrentLocation = "Berlin"
//        var newMyCurrentLocation = myCurrentLocation
//        newMyCurrentLocation = newMyCurrentLocation.replacingOccurrences(of: " ", with: "%20")
       
        getData(from: CustomTableViewCell.url)
        
            let imageSize = contentView.frame.size.height-6
            myLabel.frame = CGRect(x: 20,
                                   y: 5,
                                   width: 100,
                                   height: contentView.frame.size.height-10)
            myImageView.frame = CGRect(x: 10+myLabel.frame.size.width,
                                       y: 0,
                                       width: contentView.frame.size.width - 10 - myLabel.frame.size.width - imageSize,
                                       height: contentView.frame.size.height)
            temperatureLabel.frame = CGRect(x: contentView.frame.size.width-imageSize-30,
                                            y: 5,
                                            width: contentView.frame.size.width-20,
                                            height: contentView.frame.size.height-10)
    }
    
    private func getData(from url: String){
       let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
        //have data
            var result: Welcome?
            do {
                result = try JSONDecoder().decode(Welcome.self, from: data)
            }
            catch {
                print("failed to convert \(error.localizedDescription)")
            }
            guard let json = result else {
                return
            }
           DispatchQueue.main.async {
               //1st column defined in NeededData.swift file
               //2nd column images, code below
              let testVar = String(json.forecast.forecastday[1].day.condition.icon.dropFirst(2))
            //let testVar = String(Icon.cdnWeatherapiCOMWeather64X64Day113PNG.rawValue.dropFirst(2))
            do  {
                let data = try Data.init(contentsOf: URL.init(string: "https://\(testVar)")!)
                             DispatchQueue.main.async {
                                let image: UIImage = UIImage(data: data)!
                                 self.myImageView.image = image
                             }
                       } catch {
                             print(error)
                        }
               //3th column, code below
               self.temperatureLabel.text = String(Int(json.forecast.forecastday[0].day.mintempC)) + ("°") + (" / ") + String(Int(json.forecast.forecastday[0].day.maxtempC)) + (" °C")
           }
       })
            task.resume()
    }
}


