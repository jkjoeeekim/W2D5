require_relative './list.rb'

class TodoBoard
    def initialize(label)
        @label = List.new(label)
    end

    def get_command
        begin
            # command = gets.chomp
            cmd, *args = gets.chomp.split(' ')
            case cmd
            when "mktodo"
                @label.add_item(*args)
            when "up"
                @label.up(*args.map(&:to_i))
            when "down"
                @label.down(*args.map(&:to_i))
            when "swap"
                @label.swap(*args.map(&:to_i))
            when "sort"
                @label.sort_by_date!
            when "priority"
                @label.print_priority
            when "print"
                if args.length == 0
                    @label.print
                else
                    @label.print_full_item(*args.map(&:to_i))
                end
            when "-help"
                raise StandardError.new("mktodo\nup\ndown\nswap\nsort\npriority\nprint\nquit")
            when "quit"
                return false
            else
                raise StandardError.new("Command not recognized. -help to get all available commands")
            end
            
        rescue => error
            puts error.message
            retry
        end
    end

    def run
        get_command until get_command == false
    end
end

my_board = TodoBoard.new("things i need to learn")
my_board.run