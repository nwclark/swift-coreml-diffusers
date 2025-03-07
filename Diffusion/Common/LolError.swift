//
//  LolError.swift
//  Diffusion
//
//  Created by Nathan Clark on 2/27/25.
//

import Foundation

enum LolError: Error {
    case inconceivable(String)
    case invalidDownloadURL(String)
    case noPipeline(String)
    case shitsTooOld(String)
}
