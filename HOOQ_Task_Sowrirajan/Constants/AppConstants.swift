//
//  AppConstants.swift
//  HOOQ_Task_Sowrirajan
//
//  Created by user on 16/04/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import UIKit

let WIDTH = UIScreen.main.bounds.size.width
let HEIGHT = UIScreen.main.bounds.size.height
let apiKey = "api_key=2a05877de88d08b90c4fed3cf806ca35"

let BASEURL = "https://api.themoviedb.org/3/"

let NOWPLAYING = BASEURL + "movie/now_playing?" + apiKey
let VIDEODETAIL = BASEURL + "movie/" + "287947" + "/similar" + apiKey



