require 'gtk2'
require 'gtksourceview2'
require 'yaml'
require_relative 'command_dispatcher'
include CommandDispatcher
load_commands

window = Gtk::Window.new "Box"
window.set_default_size(300, 200)
window.signal_connect("destroy") do |w|
  Gtk.main_quit
end

keys = [
  %w(ESC F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12),
  %w(` 1 2 3 4 5 6 7 8 9 0 - = BACK),
  %w(TAB Q W E R T Y U I O P [ ] ENTER),
  %w(CAPS A S D F G H J K L ; ' #),
  %w(LSHIFT \\ Z X C V B N M , . / RSHIFT),
  %w(LCTRL WIN LALT SPACE RALT FN RCTRL)
]

$modifiers = {}
$rows = Gtk::VBox.new
keys.each do |row|
  hbox = Gtk::HBox.new
  $rows.pack_start(hbox, false, false, 1)
  row.each do |key|
    command = @commands[key].first if @commands[key]
    if %w(LCTRL LSHIFT LALT RCTRL RSHIFT RALT).include?(key)
      button = Gtk::ToggleButton.new
      $modifiers[key] = button
      button.signal_connect('toggled') do |w, e|
        key = w.children.first.text.split("\n").first
        $modifiers[(key[1..1] == 'L' ? 'R' : 'L') + key[1..-1]].active = w.active?
        render_keys
      end
    else
      button = Gtk::Button.new
      button.signal_connect('clicked') do |w, e|
        $help.buffer.text = command_for(w.children.first).last
      end
      button.sensitive = false unless command
    end
    label = Gtk::Label.new
    label.markup = "<small><b>#{key}</b>\n#{command}</small>"
    button.add(label)
    button.width_request = key.length * 10 + 40
    button.width_request = 300 if key == 'SPACE'
    hbox.pack_start(button, true, true, 1)

    hbox.pack_start(Gtk::Label.new.set_width_request(50), true, true, 1) if key == '#'
  end
end

$help = Gtk::TextView.new
$help.height_request = 60
$help.wrap_mode = Gtk::TextTag::WRAP_WORD
$help.sensitive = false
$help.modify_font Pango::FontDescription.new('FreeSans Normal 11')
$rows.pack_start(Gtk::Frame.new.add($help), true, true, 2)
window.add($rows)

def render_keys
  $rows.children[0..-2].each do |row|
    row.children.each do |button|
      label = button.children.first
      command = command_for(label).first
      key = label.text.split("\n").first
      button.sensitive = !command.nil? unless %w(LCTRL LSHIFT LALT RCTRL RSHIFT RALT).include?(key)
      label.markup = "<small><b>#{key}</b>\n#{command}</small>"
    end
  end
end

def command_for label
  key = label.text.split("\n").first
  modifiers = ''
  modifiers += 'CTRL+' if $modifiers['LCTRL'].active?
  modifiers += 'SHIFT+' if $modifiers['LSHIFT'].active?
  modifiers += 'ALT+' if $modifiers['LALT'].active?
  @commands[modifiers + key] || []
end

window.show_all

Gtk.main

