class Item
    class << self
        def valid_date?(date_string)
            date_array = date_string.split("-")
            year = date_array[0]
            month = date_array[1].to_i
            day = date_array[2].to_i
            year.length == 4 && (1..12).to_a.include?(month) && (1..31).to_a.include?(day)
        end
    end

    attr_accessor :title, :deadline, :description

    def initialize(title, deadline, description)
        @title = title
        @deadline = deadline
        @description = description
        @done = false
        if !Item.valid_date?(deadline)
            raise StandardError.new("Invalid date, must in in this format `YYYY-MM-DD`")
        end
    end

    def complete?
        @done ? "✅" : "  "
    end

    def toggle
        @done ? (@done = false) : (@done = true)
    end
end