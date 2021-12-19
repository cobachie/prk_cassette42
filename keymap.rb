# Initialize a Keyboard
kbd = Keyboard.new

kbd.init_direct_pins(
  [ 8, 27, 28, 29, 9, 26 ]
)

# default layer should be added at first
kbd.add_layer :default, %i[
  KC_SPC KC_MUTE PREV NEXT KC_MUTE KC_ENT
]

#
#                   Your custom     Keycode or             Keycode (only modifiers)      Release time      Re-push time
#                   key name        Array of Keycode       or Layer Symbol to be held    threshold(ms)     threshold(ms)
#                                   or Proc                or Proc which will run        to consider as    to consider as
#                                   when you click         while you keep press          `click the key`   `hold the key`
kbd.define_mode_key :PREV,          [ %i(KC_LGUI KC_LEFT),  :KC_NO,                       300,              nil ]
kbd.define_mode_key :NEXT,          [ %i(KC_LGUI KC_RIGHT), :KC_NO,                       300,              nil ]


#define ENCODERS_PAD_A { B6, B3 }
#define ENCODERS_PAD_B { B2, B1 }
encoder_left = RotaryEncoder.new(21, 23)
encoder_left.configure :left
encoder_left.clockwise do
  kbd.send_key :KC_VOLUP
end
encoder_left.counterclockwise do
  kbd.send_key :KC_VOLDOWN
end
kbd.append encoder_left

encoder_right = RotaryEncoder.new(20, 22)
encoder_right.configure :right
encoder_right.clockwise do
  kbd.send_key :KC_PGDOWN
end
encoder_right.counterclockwise do
  kbd.send_key :KC_PGUP
end
kbd.append encoder_right

rgb = RGB.new(
  0,    # pin number
  5,    # size of underglow pixel
  0,    # size of backlight pixel
  false # 32bit data will be sent to a pixel if true while 24bit if false
)

rgb.effect     = :breath
rgb.speed      = 20  # 1-31  / default: 22
rgb.hue        = 30  # 0-100 / default: 0
rgb.saturation = 50  # 0-100 / default: 100
rgb.max_value  = 10  # 1-31  / default: 13

kbd.append rgb

kbd.before_report do
  kbd.invert_sft if kbd.keys_include?(:KC_SCOLON)
  # You'll be also able to write `invert_ctl`, `invert_alt` and `invert_gui`
end

kbd.start!
