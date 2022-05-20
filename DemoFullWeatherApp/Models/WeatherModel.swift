//
//  WeatherModel.swift
//  DemoFullWeatherApp
//
//  Created by KhanhVu on 2/24/22.
//

import Foundation

struct WeatherModel: Codable {
    let cod : String
    let cnt: Int
    let message: Int
    let list : [List]
    let city : City
}
struct Main: Codable {
    let temp : Double
    let feels_like : Double
    let temp_min : Double
    let temp_max : Double
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
    let humidity : Int
    let temp_kf: Double
}
struct Weather: Codable {
    let id : Int
    let main : String
    let description : String
    let icon : String
}
struct Wind: Codable {
    let speed : Double
    let deg : Int
    let gust : Double
}
struct City: Codable {
    let id : Int
    let name : String
    struct Coord: Codable {
        let lat: Float
        let lon: Float
    }
    let coord : Coord
    let country : String
    let population : Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}
struct List : Codable {
    let dt : Int
    let main : Main
    let weather : [Weather]
    struct Clouds: Codable {
        let all: Int
    }
    let clouds: Clouds
    let wind : Wind
    let visibility: Int
    let pop: Double
    struct Sys: Codable {
        let pod: String
    }
    let sys: Sys
    let dt_txt : String
}
