//
//  ContentView.swift
//  Ping
//
//  Created by Colton on 23/05/2020.
//  Copyright © 2020 Colton Bishop. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isHearted = false
    @State private var isActivated = false
    @State private var m = ""
    @State private var s = "Press to activate satellite surveillance."
    @State private var im = "pop"
    var body: some View {
        VStack {
            Text(s)
            Image(im)
            .resizable()
            .scaledToFit()
            .frame(width: 200.0,height:200)
            Button(action: {
                self.isHearted.toggle()
                self.isActivated.toggle()
                if self.isActivated {
                    self.s = "Activated! You are being monitored..."
                    self.m = "activate"
                    self.im = "blow"
                } else {
                    self.s = "Deactivated! You are off the radar."
                    self.m = "deactivate"
                    self.im = "pop"
                }
                
                let url = URL(string: "https://coltcall.azurewebsites.net/api/ColtCall?name=\(self.m)")

                let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                  // your code here
                })

                task.resume()
                
            }) {
                if isHearted {
                    Image(systemName:"heart.fill")
                    
                } else {
                    Image(systemName:"heart")
                }
            }
        }.frame(maxWidth: .infinity)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
