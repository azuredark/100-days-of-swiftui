//
//  ContentView.swift
//  Animation-SwiftUI concepts
//
//  Created by Paul Andri on 07/18/2022.
//

import SwiftUI

/*
// IMPLICIT ANIMATION
struct ContentView: View {
    
   // Program State Property to store 'Double' value for the amount of '.scaleEffect()' animation value
    @State private var scaleAmount = 1.0
    
    var body: some View {
        
        // BUTTON VIEW TO ANIMATE
        Button("Tap") {
            
            // Increase the value of 'scaleAmount' Program State Property on each button tap
            scaleAmount += 0.5
            
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        
        // SCALING FX - using the value of 'scaleAmount' Program State Property
        // Effectively Scale our Button up on every Button Tap (see Button's body code)
        .scaleEffect(scaleAmount)
        
        // GAUSSIAN BLUR FX
        // '(scaleAmount - 1)' is there to make sure there's NO Blur when 'scaleAmount's value is 1
        // The Gaussian Blur FX is more intense on each Scaling FX
        .blur(radius: ((scaleAmount - 1) * 3))
        
        // ANIMATION TO SMOOTHEN OUR SCALING EFFECT
        // '.default' = '.eastInOut' Animation FX
        .animation(.default, value: scaleAmount)
        /* CODE LOGIC:
         Provide 'default' animation to the previous View whenever the value of 'scaleAmount' is changed */
        
    }
}
*/



/*
// CUSTOMISING ANIMATIONS IN SWIFTUI
struct ContentView: View {
    
    @State private var scaleAmount = 1.0
    
    var body: some View {
        
        Button("Tap") {
            scaleAmount += 0.5
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(scaleAmount)
        .blur(radius: ((scaleAmount - 1) * 3))
        
        
        // CUSTOMISING ANIMATION FX TYPEs
        
        // .'default' Animation
        // .animation(.default, value: scaleAmount)
        
        // .'easeOut' Animation
        // .animation(.easeOut, value: scaleAmount)
        
        
        /*
        // .'spring()' Animation
        .animation(
            .spring(
                // How fast the Spring FX releases (LOWER meant FASTER Spring Release FX)
                response: 0.2,
                // Spring Damping FX (HIGHER meant SLOWER Spring damping)
                dampingFraction: 0.3,
                // FX Blend Duration
                blendDuration: 0
            ), value: scaleAmount)
        */
        
        
        /*
        // '.interpolatingSpring()' Animation
        .animation(
            .interpolatingSpring(
                // "Stiffness" of the Spring (LOWER meant GENTLER Spring Release FX)
                stiffness: 100,
                // Spring Damping FX (HIGHER meant FASTER Spring damping)
                damping: 4
            ), value: scaleAmount)
        */
        
        
        /*
        // .'easeInOut' Animation w/ SPECIFIED ANIMATION DURATION
        // '(duration: )' - specify the length of the Animation in second
        .animation(.easeInOut(duration: 10), value: scaleAmount)
        // 'easeInOut' Animation that last for 10secs
        */
        
        
        
        
        // ADDING MODIFIER TO ANIMATION TYPE STRUCT
        /*
        // '.delay()' MODIFIER
        .animation(
            .easeInOut(duration: 3)
                // Delay 1sec before the 'easeInOut' animation starts
                .delay(1),
            value: scaleAmount
        )*/
        
        
        /*
        // '.repeatCount()' MODIFIER
        .animation(
            .easeInOut(duration: 1)
                // Repeat the ''easeInOut' Animation for 3 times, incl. autoreverses (Ease In & Out)
                // BE CAREFUL FOR THE REPEAT COUNT VALUE, IT SHOULD EVENTUALLY MATCH OUR PROGRAM STATE
                .repeatCount(3, autoreverses: true),
            value: scaleAmount
        )*/
        
        
        /*
        // '.repeatForever()' MODIFIER
        .animation(
            .easeInOut(duration: 1)
                // Repeat the ''easeInOut' Animation FOREVER, incl. autoreverses (Ease In & Out)
                .repeatForever(autoreverses: true),
            value: scaleAmount
        )*/
                 
    }
    
}
*/

    
    
/*
// USING '.overlay()' AND '.onAppear()' MODIFIER
// THIS STRUCT VIEW WILL CREATE A LOOPING "BROCASTING SIGNAL" LIKE ANIMATION
struct ContentView: View {
    
    @State private var scaleAmount = 1.0
    
    var body: some View {
        
        Button("AI") {
            // TAPPING THIS BUTTON DOES NOTHING
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        
        // '.overlay()' MODIFIER
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(scaleAmount)
            
            // '.opacity()' MODIFIER FOR 'Circle()' VIEW
            // value 1 = fully OPAQUE
            // value 0 = fully TRANSPARENT
                .opacity(2 - scaleAmount)   // DYNAMIC VALUE (WORKS W/ 'onAppear()' MODIFIER
            // THIS MODIFIER WILL ALTERNATE THE 'Circle()' VIEW OPACITY BETWEEN FULLY OPAQUE & TRANSPARENT
            
            // ANIMATION MODIFIER
                .animation(
                    .easeInOut(duration: 1)
                    // Repeat the ''easeInOut' Animation FOREVER
                        .repeatForever(autoreverses: false),
                    value: scaleAmount
                )
        )
        
        // 'onAppear()' MODIFIER
        // Execute code whenever a View is shown
        .onAppear {
            // Set the value of 'scaleAmount' PROGRAM STATE PROPERTY to '2' everytime the VIew is shown
            scaleAmount = 2
        }
        
    }
}
*/



/*
// ANIMATING BINDINGS
struct ContentView: View {
    
    // PROGRAM STATE PROPERTY TO STORE A VALUE
    @State private var aValue = 1.0
    
    var body: some View {
        
        // VSTACK VIEW
        VStack {
            // A 'Stepper' Input View, bounded to 'aValue' Program State Property
            Stepper(
                // STEPPER TITLE
                "Value",
                
                // 'Stepper' Input bounded to 'aValue' Program State Property
                // '.animation()' MODIFIER added to the Bounded Property
                // ADDING '.animation()' MODIFIER CAUSES SMOOTH '.scaleEffect()' TO BUTTON VIEW WHEN 'aValue' VALUE IS CHANGED USING 'Stepper' INPUT
                value: $aValue.animation(
                    
                    // 'animation()' PARAMETERS FOR BINDINGS
                    // PARAMETERS FOR BINDINGS ARE SIMILAR (NOT ALL THE SAME) TO NORMAL 'animation()' VIEW MODIFIERS
                    .easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
                    
                ),
                
                // Valid Stepper Input range from 1 to 5
                in: 1...5
            )
            
            Spacer()
            
            // BUTTON VIEW
            Button("Tap Me") {
                // ADD '1' to 'aValue' Program State Property everytime the Button is tapped
                aValue += 1
            }
            // BUTTON VIEW MODIFIERS
            .padding(50)
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(aValue)
            // BUTTON VIEW HAVE NOT '.animation() MODIFIER, CAUSES CHOPPY '.scaleEffect()'
            
        }
    }
}
*/




// EXPLICIT ANIMATIONS
struct ContentView: View {
    
    // PROGRAM STATE PROPERTY
    @State private var animationAmount = 0.0
    
    var body: some View {
        
        // BUTTON VIEW
        Button("Bounce") {
            
            // 'withAnimation { }'
            // TRIGGER "Explicit Animation" W/ EACH BODY CODE RAN (MUST TRIGGER ANY ARBITRARY STATE CHANGE)
            /*
            withAnimation {
                // ADD VALUE OF '360' TO 'animationAmount' PROGRAM STATE PROPERTY ON EACH BUTTON TAP
                animationAmount += 360
                // THIS BODY CODE TRIGGERS ARBITRARY STATE CHANGE ON 'animationAmount'
            }
            */
            
            // WE CAN ATTACH ANIMATION PARAMETERS TO 'withAnimation { }'
            withAnimation(.interpolatingSpring(stiffness: 50, damping: 5)) {
                animationAmount += 360
            }
            
        }
        // BUTTON VIEW MODIFIERS
        .padding(50)
        .background(.blue)
        .foregroundColor(.white)
        .clipShape(Circle())
        
        // '.rotation3DEffect()' MODIFIER
        // Spin a View around in 3D axis
        .rotation3DEffect(
            // 3D ROTATION '.degrees' USING 'animationAmount' PROGRAM STATE PROPERTY VALUE
            .degrees(animationAmount),
            
            // ROTATE ON 'X' AXIS (VERTICAL)
            // axis: (x:1, y:0 , z:0)
            // ROTATE ON 'Y' AXIS (HORIZONTAL)
            // axis: (x:0, y:1 , z:0)
            // ROTATE ON 'Z' AXIS (DEPTH)
            // axis: (x:0, y:0 , z:1)
            // ROTATE ON ALL AXIS
            axis: (x:1, y:1 , z:1)
        )
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
