
import SwiftUI

struct DatePickerView: View {
    
    @State private var sleepAmount = 8.0
    
    @State private var wakeUp = Date()
    
    var body: some View {
        
//        let now = Date()
//        let tomorrow = Date().addingTimeInterval(86400)
//        let range = now...tomorrow
        
 //        var components = DateComponents()
//        components.hour = 8
//        components.minute = 0
//        let date = Calendar.current.date(from: components) ?? Date()
        
//        let components = Calendar.current.dateComponents([.hour, .minute], from: Date())
//        let hour = components.hour ?? 0
//        let minute = components.minute ?? 0
        
//        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        let dateString = formatter.string(from: Date())
        
        
        VStack {
            Stepper(value: $sleepAmount, in: 4...12, step: 0.5) {
                Text("\(sleepAmount, specifier: "%g") hours")
                // %g - automatically remove insignificant zeros
            }
            
            DatePicker("Please enter a date", selection: $wakeUp,
                       displayedComponents: .hourAndMinute)
                .labelsHidden()
            
            DatePicker("Please enter a date", selection: $wakeUp,
                       in: Date()...)
                .labelsHidden()
        }
        .padding()
    
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}

