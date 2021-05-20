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
        if !Item.valid_date?(deadline)
            raise StandardError.new("Invalid date, must in in this format `YYYY-MM-DD`")
        end
    end
end

# p Item.valid_date?('2019-10-25') # true
# p Item.valid_date?('1912-06-23') # true
# p Item.valid_date?('2018-13-20') # false
# p Item.valid_date?('2018-12-32') # false
# p Item.valid_date?('10-25-2019') # false
# item1 = Item.new('Fix login page', '2019-10-25', 'The page loads too slow.')
# p item1.title

# item2 = Item.new(
#     'Buy Cheese',
#     '2019-10-21',
#     'We require American, Swiss, Feta, and Mozzarella cheese for the Happy hour!'
# )
# p item2.title

# Item.new(
#     'Fix checkout page',
#     '10-25-2019',
#     'The font is too small.'
# ) # raises error due to invalid date