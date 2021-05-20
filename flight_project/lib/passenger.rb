class Passenger
    attr_reader :name

    def initialize(name)
        @name = name
        @flight_numbers = Array.new
    end

    def has_flight?(flight_number)
        @flight_numbers.include?(flight_number.upcase)
    end

    def add_flight(flight_number)
        @flight_numbers << flight_number.upcase unless has_flight?(flight_number)
    end
end