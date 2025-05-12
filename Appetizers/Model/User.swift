//
//  User.swift
//  Appetizers
//
//  Created by Michael Ramirez
//
import Foundation
struct User: Codable {
    var firstName       = ""
    var lastName        = ""
    var email           = ""
    var birthdate       = Date()
    var extraNapkins    = false
    var frequentRefills = false
}
