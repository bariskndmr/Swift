// Have a AdvencedLifeSupport certicate
protocol AdvencedLifeSupport {
    func performCPR()
}


class EmergencyCallHandler {
    // Delegate must have data type of "AdvencedLifeSupport"
    var delegate: AdvencedLifeSupport?
    
    func assessSituation() {
        print("Can you tell me what happened?")
    }
    
    func medicalEmergency(){
        delegate?.performCPR()
    }
}

struct Paramedic: AdvencedLifeSupport {
    
    init(handler: EmergencyCallHandler){
        handler.delegate = self
    }
    
    func performCPR() {
        print("The paramedic does chest compressions, 30 per second.")
    }
}

class Doctor: AdvencedLifeSupport{
    
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func performCPR() {
        print("The paramedic does chest compressions, 30 per second.")
    }
    
    func useStethescope() {
        print("Listening for heart sounds")
    }
}

class Surgeon: Doctor{
    override func performCPR() {
        super.performCPR()
        print("Sings staying alive by the BeeGees")
    }
    
    func useElectricDrill(){
        print("Whir...")
    }
}


let emilio = EmergencyCallHandler()
let angela = Surgeon(handler: emilio)
// let pete = Paramedic(handler: emilio)

emilio.assessSituation()
emilio.medicalEmergency()
