//
//  NeededData.swift
//
//  Created by Harun Fazlic on 13. 7. 2022..
//

import Foundation


//Generating weekday

let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    return formatter
}()
    
let date = Date()

let dayZero = formatter.string(from: date)
let dayZeroIndex = dayZero.index(dayZero.startIndex, offsetBy: 3)
let dayZeroResult = String(dayZero[..<dayZeroIndex])

var removeMinutes = date.addingTimeInterval(-1440*60)
let dayMinusOne = formatter.string(from: removeMinutes)
let dayMinusOneIndex = dayMinusOne.index(dayMinusOne.startIndex, offsetBy: 3)
let dayMinusOneResult = String(dayMinusOne[..<dayMinusOneIndex])

let addminutes = date.addingTimeInterval(1440*60)
let dayOne = formatter.string(from: addminutes)
let dayOneIndex = dayOne.index(dayOne.startIndex, offsetBy: 3)
let dayOneResult = String(dayOne[..<dayOneIndex])

let dayTwoAddminutes = date.addingTimeInterval(2880*60)
let dayTwo = formatter.string(from: dayTwoAddminutes)
let dayTwoIndex = dayTwo.index(dayTwo.startIndex, offsetBy: 3)
let dayTwoResult = String(dayTwo[..<dayTwoIndex])

let dayThreeaddminutes = date.addingTimeInterval(4320*60)
let dayThree = formatter.string(from: dayThreeaddminutes)
let dayThreeIndex = dayThree.index(dayThree.startIndex, offsetBy: 3)
let dayThreeResult = String(dayThree[..<dayThreeIndex])


//Collecting data to fill the table view
struct neededData {
    let weekday: String
    let imageName: String
    let weatherAndTemparature: String
}


let data: [neededData] = [
    neededData(weekday: dayMinusOneResult, imageName: "", weatherAndTemparature: "Before" ),
    neededData(weekday: dayZeroResult, imageName: "", weatherAndTemparature: "Current"),
    neededData(weekday: dayOneResult, imageName: "", weatherAndTemparature: "One"),
    neededData(weekday: dayTwoResult, imageName: "", weatherAndTemparature: "Two"),
    neededData(weekday: dayThreeResult, imageName: "", weatherAndTemparature: "Three")
]
