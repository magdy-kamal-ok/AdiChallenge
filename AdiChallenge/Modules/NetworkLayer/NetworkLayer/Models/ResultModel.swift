//
//  ResultModel.swift
//  NetworkLayer
//
//  Created by Magdy Kamal on 29/01/2021.
//

import Foundation

public enum ResultModel {
    case success(Data)
    case faliure (Error?, Data?)
}
