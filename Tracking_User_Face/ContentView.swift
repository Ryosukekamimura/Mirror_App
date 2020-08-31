//
//  ContentView.swift
//  Tracking_User_Face
//
//  Created by 神村亮佑 on 2020/08/31.
//  Copyright © 2020 神村亮佑. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        ZStack{
            CameraViewController()
                .edgesIgnoringSafeArea(.top)
            Spacer()
            
            Button(action: {
                
            }, label: {
                Text("Stop")
                    .background(Color(.white))
                    .foregroundColor(Color(.black))
                    .cornerRadius(20)
            })
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
