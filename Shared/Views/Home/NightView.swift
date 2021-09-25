//
//  NightView.swift
//  ShellHacksApp
//
//  Created by Andreas on 9/25/21.
//

import SwiftUI

struct NightView: View {
    @StateObject var musicManager = MusicManager()
    @StateObject var healthManager = HealthManager()
    @State var currentDate = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
        Color.black
                .ignoresSafeArea()
            VStack {
            Text("Place Your Phone Near You As You Sleep To Experiment")
                .font(.custom("Poppins-Bold", size: 24, relativeTo: .headline))
                .padding(.vertical)
            Text("- If you have an Apple Watch or Fitbit, please wear it.\n\n - The music you played as you studied will play during Slow Wave Sleep (SWS).\n\n -In the morning please take the test to see your results")
                .font(.custom("Poppins", size: 18, relativeTo: .headline))
                .padding(.vertical)
                
            }.multilineTextAlignment(.leading)
                .foregroundColor(.Dark)
                .padding()
            .onReceive(timer) { value in
                currentDate = value
               
                if value.get(.hour) == 1 {
                    healthManager.backgroundDelivery()
                    for artist in musicManager.getArtists().map({$0.items}) {
                        let filteredToComposer = artist.filter{$0.artist == "Lone"}
                        if let artist = filteredToComposer.first {
                            musicManager.playArtistsSongs(artist: artist)
                    } else {
                        print("OOOOF")
                    }
                }
                }
            }
        }
    }
}

struct NightView_Previews: PreviewProvider {
    static var previews: some View {
        NightView()
    }
}
