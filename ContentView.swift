//
//  ContentView.swift
//  swift ui practice
//
//  Created by cameron baird on 12/30/19.
//  Copyright © 2019 cameron baird. All rights reserved.
//

import SwiftUI

struct ContentView: View
{
    @State var r_target = Double.random(in: 0..<1)
    @State var g_target = Double.random(in: 0..<1)
    @State var b_target = Double.random(in: 0..<1)
    
    @State var r_guess: Double
    @State var g_guess: Double
    @State var b_guess: Double
    
    @State var show_score = 0
    
    @State var dark_mode = false
    
    func compute_score() -> Int
    {
        let r_diff = r_guess - r_target
        let g_diff = g_guess - g_target
        let b_diff = b_guess - b_target
        
        let total_diff = sqrt((r_diff * r_diff) + (g_diff * g_diff) + (b_diff * b_diff))
        
        return Int((1.0 - total_diff) * 100.0 + 0.5)
    }
    
    var body: some View
    {
        ZStack
        {
            if dark_mode
            {
                Color.black
                .edgesIgnoringSafeArea(.all)
            }
            else
            {
                Color.white
                .edgesIgnoringSafeArea(.all)
            }
            
            VStack
            {
                if dark_mode
                {
                    Text("Match the color on the right with the color on the left using the sliders!")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .font(.custom("Cochin", size: 20))
                    .padding([.top])
                }
                else
                {
                    Text("Match the color on the right with the color on the left using the sliders!")
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .font(.custom("Cochin", size: 20))
                    .padding([.top])
                }
                
                Toggle(isOn: $dark_mode)
                {
                    Text("Dark Mode: ")
                        .font(.custom("Cochin", size: 20))
                        .foregroundColor(.purple)
                        .padding()
                }
                .padding([.leading, .trailing], 90)
                
                HStack
                {
                    //target color block
                    VStack
                    {
                        HStack
                        {
                            if show_score == 0
                            {
                                Text("R: ?")
                                    .foregroundColor(.red)
                                    .font(.custom("Cochin", size: 14))
                                Text("G: ?")
                                    .foregroundColor(.green)
                                    .font(.custom("Cochin", size: 14))
                                Text("B: ?")
                                    .foregroundColor(.blue)
                                    .font(.custom("Cochin", size: 14))
                            }
                            else
                            {
                                Text("R: \(Int(r_target * 255.0))")
                                    .foregroundColor(.red)
                                    .font(.custom("Cochin", size: 14))
                                Text("G: \(Int(g_target * 255.0))")
                                    .foregroundColor(.green)
                                    .font(.custom("Cochin", size: 14))
                                Text("B: \(Int(b_target * 255.0))")
                                    .foregroundColor(.blue)
                                    .font(.custom("Cochin", size: 14))
                            }
                        } .padding([.leading, .trailing])
                        Rectangle().foregroundColor(Color(red: r_target, green: g_target, blue: b_target, opacity: 1.0))
                    }
                    //guess color block
                    VStack
                    {
                        HStack
                        {
                            Text("R: \(Int(r_guess * 255.0))")
                                .foregroundColor(.red)
                                .font(.custom("Cochin", size: 14))
                            Text("G: \(Int(g_guess * 255.0))")
                                .foregroundColor(.green)
                                .font(.custom("Cochin", size: 14))
                            Text("B: \(Int(b_guess * 255.0))")
                                .foregroundColor(.blue)
                                .font(.custom("Cochin", size: 14))
                        } .padding([.leading, .trailing])
                        Rectangle().foregroundColor(Color(red: r_guess, green: g_guess, blue: b_guess, opacity: 1.0))
                    }
                } .padding([.leading, .trailing], 20)
                
                if show_score == 0
                {
                    Text("")
                }
                else
                {
                    if dark_mode
                    {
                        Text("Your score is \(compute_score())")
                        .padding()
                        .foregroundColor(.white)
                        .font(.custom("Cochin", size: 15))
                    }
                    else
                    {
                        Text("Your score is \(compute_score())")
                        .padding()
                        .foregroundColor(.black)
                        .font(.custom("Cochin", size: 15))
                    }
                }
                
                VStack
                {
                    Button(action: {
                        if self.show_score == 0
                        {
                            self.show_score = 1
                        }
                    }) {
                        Button_Effects(button_text: "Get My Score!", gradient_color_left: Color.black, gradient_color_right: Color.yellow, button_text_color: Color.white, corner_radius: 20.0)
                    }.padding()
                    
                    Button(action: {
                        if self.show_score == 1
                        {
                            self.show_score = 0
                        }
                        
                        self.r_guess = 0.5
                        self.g_guess = 0.5
                        self.b_guess = 0.5
                        
                        self.r_target = Double.random(in: 0..<1)
                        self.g_target = Double.random(in: 0..<1)
                        self.b_target = Double.random(in: 0..<1)
                    }) {
                        Button_Effects(button_text: "Reset Color", gradient_color_left: Color.blue, gradient_color_right: Color.red, button_text_color: Color.white, corner_radius: 20.0)
                    }
                } .padding()
                
                VStack
                {
                    Color_Slider(value: $r_guess, text_color: .red)
                    Color_Slider(value: $g_guess, text_color: .green)
                    Color_Slider(value: $b_guess, text_color: .blue)
                }
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView(r_guess: 0.5, g_guess: 0.5, b_guess: 0.5)
    }
}

struct Color_Slider: View
{
    @Binding var value: Double
    var text_color: Color
    
    var body: some View
    {
        HStack
        {
            Text("0").foregroundColor(text_color)
            Slider(value: $value)
                .accentColor(text_color)
            Text("255").foregroundColor(text_color)
        } .padding(7)
    }
}


struct Button_Effects: View
{
    var button_text: String
    var gradient_color_left: Color
    var gradient_color_right: Color
    var button_text_color: Color
    var corner_radius: CGFloat
    
    var body: some View
    {
        Text(button_text)
            .font(.custom("Cochin", size: 15))
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [gradient_color_right, gradient_color_left]), startPoint: .trailing, endPoint: .leading))
            .foregroundColor(button_text_color)
            .cornerRadius(corner_radius)
            .padding([.leading, .trailing], 70)
    }
}
