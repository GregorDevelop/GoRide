//
//  UserModel.swift
//  GoRide
//
//  Created by Egor  on 05.07.2020.
//  Copyright © 2020 Gregor Kramer. All rights reserved.
//

import Foundation


struct User {
  
    var id: String

    var name: String
    var phone: String
    var mot: String
    
    var userSex: Sex = Sex.notSelected
    var userType: UserType = UserType.notSelected
    var lookingForSex: Sex = Sex.notSelected
    var lookingHours: Int = 1
    
    var hasEquip: Bool = false
    var hasExtraEquip: Bool = false
    
    
    var lat: Double = 55.753215
    var lon: Double = 37.622504
    
//    var expDate: Long = 0L
//    var token: String
    
    enum Sex {
        case male
        case female
        case both
        case notSelected
    }
    
    enum UserType {
           case pilot
           case female
           case both
           case notSelected
       }
    

    
}



