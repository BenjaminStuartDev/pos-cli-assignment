# frozen_string_literal: true

require 'tty-prompt'
require_relative './menu'
require_relative './view_menu_item_menu'
require_relative './place_order_type_menu'

# The PlaceOrderMenu class represents the menu in which users can place an order for a table
class PlaceOrderMenu < Menu
  # initialiseses the @table and @menu_items class instance variables
  # @param table [Table] an object representing a hospitality Table
  def initialize(table)
    @table = table
    @menu_items = @@business.menu_items

    options = [
      { name: 'Place Food Order', value: 'food order' },
      { name: 'Place Drink Order', value: 'drink order' },
      { name: 'Back', value: :break }
    ]
    super('Menu item list', options)
  end

  # handle_selection has been over written to handle the users menu selection.
  #
  # Selection n: menu_item n - > Will launch the ViewMenuItemMenu for the selected menu_item
  # Selection n + 1: Back - > will return the user to the previous Menu
  def handle_selection(selection)
    return :break if selection == :break

    if selection == 'food order'
      menu = PlaceOrderTypeMenu.new(@table, drink: false)
    else
      menu = PlaceOrderTypeMenu.new(@table, drink: true)
    end
    menu.run
  end
end