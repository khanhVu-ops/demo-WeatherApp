//
//  WeatherTableViewCell.swift
//  DemoFullWeatherApp
//
//  Created by KhanhVu on 2/24/22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var DayLabel: UILabel!
    
    @IBOutlet weak var IconImage: UIImageView!
    
    @IBOutlet weak var MaxTempLabel: UILabel!
    
    @IBOutlet weak var MinTempLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    func configure(with model: List) {
        DayLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.dt)))
        IconImage.image = UIImage(named: "\(model.weather[0].icon)")
        MaxTempLabel.text = "\(Int(model.main.temp_max-273))°C"
        MinTempLabel.text = "\(Int(model.main.temp_min-273))°C"
    }
    func getDayForDate(_ date: Date?) -> String {
        guard let input = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: input)
        
    }
    func confi() {
        DayLabel.text = "alo"
        
        MaxTempLabel.text = "max"
        MinTempLabel.text = "min"
    }
    
}
