require 'gtk2'
require 'gtksourceview2'
require 'yaml'
require_relative('lib/yaml.rb')
require_relative('lib/file.rb')
load_commands

window = Gtk::Window.new "Keyboard Shortcuts"
window.set_default_size(300, 200)
window.signal_connect("destroy") do |w|
  Gtk.main_quit
end
window.signal_connect('key_press_event') do |w, e|
  if !toggle_button(shortcut(e), true)
    shortcut = shortcut(e)
    help = command_for(key_from_event(e)).last
    $help.buffer.text = help if help
  end
end

window.signal_connect('key_release_event') do |w, e|
  toggle_button shortcut(e), false
end

def toggle_button modifier, active
  if %w(CTRL ALT SHIFT).include?(modifier)
    $modifiers.each do |button|
      button.active = active if button.children.first.text.split("\n").first == modifier
    end
    render_keys
    true
  else
    false
  end
end

def render_keys
  $rows.children[0..-2].each do |row|
    row.children.each do |button|
      next if button.is_a?(Gtk::Label)
      label = button.children.first
      key = label.text.split("\n").first
      command = command_for(key).first
      button.sensitive = !command.nil? unless %w(CTRL SHIFT ALT).include?(key)
      label.markup = "<small><b>#{key}</b>\n#{command}</small>"
    end
  end
end

def shortcut shortcut
  keys = []
  key = key_from_event(shortcut)
  return key if %w(CTRL SHIFT ALT).include?(key)
  keys << "CTRL" if shortcut.state.control_mask?
  keys << "ALT" if shortcut.state.mod1_mask?
  keys << "SHIFT" if shortcut.state.shift_mask?
  keys << key
  keys.join('+')
end

def key_from_event e
  unmodified_keyval = Gdk::Keymap.default.lookup_key(e.hardware_keycode, 0, 0)
  key = Gdk::Keyval.to_name(unmodified_keyval).upcase
  {'RETURN' => 'ENTER', 'ESCAPE' => 'ESC',
    'CONTROL_L' => 'CTRL', 'ALT_L' => 'ALT', 'SHIFT_L' => 'SHIFT',
    'CONTROL_R' => 'CTRL', 'ALT_R' => 'ALT', 'SHIFT_R' => 'SHIFT'
  }[key] || key
end

keys = [
  %w(ESC F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12),
  %w(` 1 2 3 4 5 6 7 8 9 0 - = BACK),
  %w(TAB Q W E R T Y U I O P [ ] ENTER),
  %w(CAPS A S D F G H J K L ; ' #),
  %w(SHIFT \\ Z X C V B N M , . / SHIFT),
  %w(CTRL WIN ALT SPACE ALT FN CTRL)
]

$modifiers = []
$rows = Gtk::VBox.new

keys.each do |row|
  hbox = Gtk::HBox.new
  $rows.pack_start(hbox, false, false, 1)
  row.each do |key|
    command = @commands[key].first if @commands[key]
    if %w(CTRL SHIFT ALT).include?(key)
      button = Gtk::ToggleButton.new
      $modifiers << button
      button.signal_connect('toggled') do |w, e|
        modifier = w.children.first.text.split("\n").first
        toggle_button modifier, w.active?
      end

    else
      button = Gtk::Button.new
      button.signal_connect('clicked') do |w, e|
        key = w.children.first.text.split("\n").first
        $help.buffer.text = command_for(key).last
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
$help.buffer.text = "Use the keyboard or mouse to press (or click) on modifiers and keys to see more information."
$help.height_request = 60
$help.wrap_mode = Gtk::TextTag::WRAP_WORD
$help.sensitive = false
$help.modify_font Pango::FontDescription.new('FreeSans Normal 11')
$rows.pack_start(Gtk::Frame.new.add($help), true, true, 2)
window.add($rows)

def command_for key
  modifiers = ''
  modifiers << 'CTRL+' if $modifiers[2].active?
  modifiers << 'ALT+' if $modifiers[3].active?
  modifiers << 'SHIFT+' if $modifiers[0].active?
  @commands[modifiers + key] || []
end

window.show_all

Gtk.main

