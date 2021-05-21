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

    def toggle_item(index)
        self[index].toggle
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
        puts "\n\n#{'-'*50}\n#{label.upcase.center(50)}\n#{'-'*50}"
        puts "Index | #{'Item'.ljust(20)}| #{'Deadline'.ljust(10)}| Complete\n#{'-'*50}"
        @items.each_with_index do |item, idx|
            puts "#{idx.to_s.ljust(6)}| #{item.title.ljust(20)}| #{item.deadline.ljust(10)}|  [ #{item.complete?} ]"
        end
        puts "#{'-'*50}\n\n "
    end

    def print_full_item(index, header="full item")
        item = self[index]
        puts "\n\n#{'-'*50}\n#{header.upcase.center(50)}\n#{'-'*50}"
        puts "#{item.title.ljust(30)}#{item.deadline.ljust(10)}   [ #{item.complete?} ]\n#{item.description.ljust(50)}"
        puts "#{'-'*50}\n\n "
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

    def remove_item(index)
        @items.delete_at(index)
    end

    def purge
        @items.select! { |item| item.complete? == "  " }
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end
end