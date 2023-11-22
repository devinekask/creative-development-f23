import SwiftUI

func generateRandomIntExcept(range:ClosedRange<Int>, except: Int) -> Int {
    var random:Int
    repeat {
        random = Int.random(in: range)
    } while random == except
    return random
}

struct ContentView: View {
    
    @State var collega1Index:Int = 1
    @State var collega2Index:Int = 2
    @State var percentage:Int = 50
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Image("logo_love_calculator")
                Spacer()
                HStack {
                    Image("lecturer\(collega1Index)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image("lecturer\(collega2Index)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                Text("\(percentage)% match")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                Button("Shuffle") {
                    collega1Index = Int.random(in: 1...15)
                    collega2Index = generateRandomIntExcept(range: 1...15, except: collega1Index)
                    percentage = Int.random(in: 0...100)
                }
                .padding()
                .background(.black)
                .foregroundStyle(.white)
                .bold()
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
