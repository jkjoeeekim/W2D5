require_relative "./item.rb"

class List
    attr_accessor :label

    def initialize(label)
        @label = label
        @items = Array.new
    end

    def add_item(title, deadline, *description)
        if Item.valid_date?(deadline)
            new_item = Item.new(title, deadline, description.join(" "))
            @items << new_item
            true
        else
            false
        end
    end

    def size
        @items.length
    end

    def valid_index?(index)
        !@items[index].nil?
    end

    def swap(idx1, idx2)
        if valid_index?(idx1) && valid_index?(idx2)
            first_item = @items[idx1]
            second_item = @items[idx2]
            @items[idx1] = second_item
            @items[idx2] = first_item
            true
        else
            false
        end
    end

    def [](index)
        @items[index]
    end

    def priority
        @items.first
    end

    def print
        puts "\n\n#{'-'*40}\n#{label.upcase.center(40)}\n#{'-'*40}"
        puts "Index | #{'Item'.ljust(20)}| Deadline\n#{'-'*40}"
        @items.each_with_index do |item, idx|
            puts "#{idx.to_s.ljust(6)}| #{item.title.ljust(20)}| #{item.deadline}"
        end
        puts "#{'-'*40}\n\n "
    end

    def print_full_item(index, header="full item")
        item = self[index]
        puts "\n\n#{'-'*40}\n#{header.upcase.center(40)}\n#{'-'*40}"
        puts "#{item.title.ljust(30)}#{item.deadline}\n#{item.description.ljust(40)}"
        puts "#{'-'*40}\n\n "
    end

    def print_priority
        if priority.nil?
            puts "There is nothing on the list"
        else
            print_full_item(0, "priority")
        end
    end

    def up(index, amount=1)
        new_index = index - amount
        if new_index < 0
            return false
        end
        swap(index, new_index)
    end

    def down(index, amount=1)
        new_index = index + amount
        swap(index, new_index)
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end

end

# p new_list = List.new('Groceries')
# p new_list.add_item('cheese', '2019-10-25', 'get sum cheez')
# p new_list.add_item('toothpaste', '2019-09-25', 'for brushing teeth')
# p new_list.add_item('body wash', '2014-03-14')
# p new_list.add_item('pasta', '2019-10-26', 'to make some pasta')
# p new_list.add_item('tomato paste', '2011-05-05', 'for spaghetti')
# p new_list.add_item('cups', '2019-01-02', 'for water')
# p new_list.add_item('water', '2019-01-01', 'to drink')
# p new_list.add_item('orange juice', '2018-12-31')
# p new_list.add_item('apple juice', '2019-12-25')
# p new_list.add_item('rice', '2019-06-25')
# p new_list.add_item('shampoo', '2020-10-25')
# new_list.print
# new_list.print_full_item(5)
# p new_list.up(5, 6)
# p new_list.up(5, 5)
# new_list.print
# new_list.print_full_item(6)
# p new_list.down(6, 5)
# p new_list.down(6, 4)
# new_list.print
# new_list.sort_by_date!
# new_list.print

# p new_list.size
# p new_list.priority
# p new_list[0]
# p new_list[2]
# p new_list[5]
# new_list.print
# new_list.print_priority
# p new_list.swap(1, 7)
# p new_list.swap(0, 2)
# p new_list.priority
# p new_list[0]
# p new_list[2]
# new_list.print
# new_list.print_priority

# new_list.print_full_item(0)
# new_list.print_full_item(1)
# new_list.print_full_item(2)