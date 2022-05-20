//
//  ViewController.swift
//  DemoFullWeatherApp
//
//  Created by KhanhVu on 2/24/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var myTopView: UIView!
    
    var models = [List]()
    var hourModels = [List]()

    @IBOutlet weak var myTable: UITableView!
    var currentLocation = CLLocation()
    var locationManager = CLLocationManager()
    let API_KEY = "7e80f62f7f6458aadf823826999bb96b"
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        print("viewWillAppear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        initLocation()
        
        
        myTable.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        myTable.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        
        myTable.delegate = self
        myTable.dataSource = self
        myTopView.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        myTable.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    func initLocation() {
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first!
        
        locationManager.stopUpdatingLocation()
        requestApi()
       
    }
    func requestApi() {
        let lat = currentLocation.coordinate.latitude
        let long = currentLocation.coordinate.longitude
        print("lat: \(lat) long: \(long)")
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&appid=\(API_KEY)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
                guard let data = data, error == nil else{
                    print( "Data error")
                    return
                }
                var json : WeatherModel?
                do {
                    
                    json = try JSONDecoder().decode(WeatherModel.self, from: data)
                    
                    
                }catch  {
                    print("error: \(error)")
                }
                guard let result = json else {
                    return
                }
                print(result.list[0].main.temp_max)
                self.models.append(contentsOf: result.list)
            self.hourModels.append(contentsOf: result.list)
            DispatchQueue.main.async {
              
                self.myTable.reloadData()
                self.myTable.tableHeaderView = self.createTableHeader(result)
                self.myTopView = self.creatTopView(result)
                
            }
        }
        task.resume()
    }
    func creatTopView(_ item: WeatherModel) -> UIView{
        let locationLabel = UILabel(frame: CGRect(x: 10, y:30, width: view.frame.size.width-20, height: myTopView.frame.size.height/3))
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 10+locationLabel.frame.size.height, width: view.frame.size.width-20, height: myTopView.frame.size.height/3))
        myTopView.addSubview(locationLabel)
        myTopView.addSubview(summaryLabel)
        locationLabel.textAlignment = .center
        summaryLabel.textAlignment = .center
        locationLabel.text = "\(item.city.name)"
        summaryLabel.text = "\(item.list[0].weather[0].description)"
        locationLabel.font = UIFont(name: "Helvetica-Bold", size: 20)
        return myTopView
    }
    
    func createTableHeader(_ item: WeatherModel) -> UIView {
        
        let headerView = UIView(frame:CGRect(x: 0, y: 0, width: view.frame.size.width, height: myTable.frame.size.height/4))
        
        headerView.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        
        
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width, height: headerView.frame.size.height/2))
        
        headerView.addSubview(tempLabel)
        
        tempLabel.textAlignment = .center
        
        
        tempLabel.text = "\(Int(item.list[0].main.temp)-273)°C"
        tempLabel.font = UIFont(name: "Helvetica-Bold", size: 60)
        
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = myTable.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            cell.configur(with: hourModels)
            cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
            return cell
        }else {
            let cell = myTable.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
            cell.configure(with: models[indexPath.row])
            
            cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTable.deselectRow(at: indexPath, animated: true)
    }
    

}

