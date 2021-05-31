require 'byebug'
require_relative './list'

class TodoBoard
  def initialize
    @labels = {}
  end

  def get_command
    puts 'Enter a command, or `-help` for a list of commands'
    cmd, list_label, *args = gets.chomp.split(' ')
    list = @labels.values_at(list_label).first
    case cmd
    when 'mklist'
      @labels[list_label] = List.new(list_label)
    when 'ls'
      list_labels
    when 'showall'
      show_all
    when 'mktodo'
      list.add_item(*args)
    when 'toggle'
      list.toggle_item(*args.map(&:to_i))
    when 'up'
      list.up(*args.map(&:to_i))
    when 'down'
      list.down(*args.map(&:to_i))
    when 'swap'
      list.swap(*args.map(&:to_i))
    when 'sort'
      list.sort_by_date!
    when 'priority'
      list.print_priority
    when 'print'
      # debugger
      if args.empty?
        list.print
      else
        list.print_full_item(*args.map(&:to_i))
      end
    when 'rm'
      list.remove_item(*args.map(&:to_i))
    when 'purge'
      list.purge
    when '-help'
      raise StandardError, "mktodo\ntoggle\nup\ndown\nswap\nsort\npriority\nprint\nquit"
    when 'quit'
      false
    else
      raise StandardError, 'Command not recognized. -help to get all available commands'
    end
  rescue StandardError => e
    puts e.message
    retry
  end

  def list_labels
    puts "\n\n Available to-do lists:"
    @labels.keys.each do |list_name|
      puts "#{list_name}\n "
    end
  end

  def show_all
    puts "\n\n All lists created:"
    @labels.values.each do |list|
      list.print
    end
  end

  def run
    get_command until get_command == false
  end
end

my_board = TodoBoard.new
my_board.run

# mktodo rails 2021-12-31 testing a description out
# mktodo regexp 2021-07-21 test this description out
# mktodo ruby 2021-04-15 "another type of description here"
