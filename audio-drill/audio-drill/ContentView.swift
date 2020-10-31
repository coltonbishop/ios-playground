//
//  ContentView.swift
//  audio-drill
//
//  Created by Colton on 28/05/2020.
//  Copyright © 2020 Colton Bishop. All rights reserved.
//

import SwiftUI
import AVFoundation

struct Phrase: Identifiable {
    var id = UUID()
    var en: String
    var es: String
    var fr: String
}

struct PhraseRow: View {
    var phrase: Phrase
    var body: some View {
        Text("\(phrase.fr)")
    }
}


func readJSONFromFile() -> [Phrase]
{
    var phrases_list = [Phrase]()
    var json: Any?
    // Reads JSON Object in
    if let path = Bundle.main.path(forResource: "phrases", ofType: "json") {
        do {
            let fileUrl = URL(fileURLWithPath: path)
            // Getting data from JSON file using the file URL
            let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            json = try? JSONSerialization.jsonObject(with: data)
        } catch {
        }
    } else {
    }
    
    if  let object = json as? [Any] {
        for anItem in object as! [Dictionary<String, String>] {
            let english = anItem["en"]!
            let spanish = anItem["es"]!
            let french = anItem["fr"]!
            let phrase = Phrase(en: english, es: spanish, fr : french)
            phrases_list.append(phrase)
        }
    } else {

    }
    return phrases_list
}

let phrases = readJSONFromFile()

let speechSynthesizer = AVSpeechSynthesizer()

struct ContentView: View {
     @State private var selection = 0
     @State private var i = 0
     @State private var text = "Select Option"
     @State private var speech = "Select Option"
    var body: some View {
        TabView(selection: $selection){
            VStack {
                Image("add")
                Text("Add Words")
                
            }
                .font(.title)
                .tabItem {
                    VStack {
                        Image("add")
                        Text("Add Words")
                    }
                }
                .tag(0)
            
            VStack {
                Text(text)
                
                // ENGLISH BUTTONS
                HStack {
                Button(action: {
                    self.text = phrases[self.i].en
                }) {
                        Image("usa")
                    .renderingMode(.original)
                }
                    Button(action: {
                        self.speech = phrases[self.i].en
                        let utterance = AVSpeechUtterance(string: self.speech)
                        utterance.voice  = AVSpeechSynthesisVoice(language: "en-US")
                        speechSynthesizer.speak(utterance)
                    }) {
                            Image("audio")
                        .renderingMode(.original)
                    }
                }
                // SPANISH BUTTONS
                HStack {
                Button(action: {
                    self.text = phrases[self.i].es
                }) {
                        Image("spain")
                    .renderingMode(.original)
                }
                    Button(action: {
                        self.speech = phrases[self.i].es
                        let utterance = AVSpeechUtterance(string: self.speech)
                        utterance.voice  = AVSpeechSynthesisVoice(language: "es-ES")
                        speechSynthesizer.speak(utterance)
                    }) {
                            Image("audio")
                        .renderingMode(.original)
                    }
                }
                
                // FRENCH BUTTONS
                HStack {
                Button(action: {
                    self.text = phrases[self.i].fr
                }) {
                        Image("france")
                    .renderingMode(.original)
                }
                    Button(action: {
                        self.speech = phrases[self.i].fr
                        let utterance = AVSpeechUtterance(string: self.speech)
                        utterance.voice  = AVSpeechSynthesisVoice(language: "fr-FR")
                        speechSynthesizer.speak(utterance)
                    }) {
                            Image("audio")
                        .renderingMode(.original)
                    }
                }
                
                // NEXT BUTTON
                Button(action: {
                    self.text = "Select option."
                    self.i = self.i + 1
    
                    if self.i > phrases.count - 1 {
                        self.i = 0
                    }
                    
                }) {
                        Image("next")
                    .renderingMode(.original)
                }
                
                
            }.frame(maxWidth: .infinity)
            
                .font(.title)
                .tabItem {
                    VStack {
                        Image("practice")
                        Text("Practice")
                    }
                }
                .tag(1)
            
            VStack {
                Image("all")
                Text("See All")
                List(phrases) { phrase in
                    PhraseRow(phrase: phrase)
                }
            }
            
                .font(.title)
                .tabItem {
                    VStack {
                        Image("all")
                        Text("See All")
                    }
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
