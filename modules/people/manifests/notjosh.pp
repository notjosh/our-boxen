class people::notjosh {
include adium
	include brewcask
	include chrome
	include firefox::beta
	include iterm2::dev
	#include sublime_text_3
	#include vlc
	#include zsh

	include osx::global::disable_key_press_and_hold
	include osx::global::disable_autocorrect
	include osx::global::enable_keyboard_control_access
	include osx::global::enable_standard_function_keys
	include osx::global::tap_to_click
	include osx::dock::autohide
	include osx::dock::clear_dock
	include osx::finder::enable_quicklook_text_selection
	include osx::universal_access::ctrl_mod_zoom

	osx::dock::hot_corner { 'Bottom Right':
		action => 'Start Screen Saver'
	}

	class { 'osx::sound::interface_sound_effects':
		enable => false
	}

	# caps to nothing: see https://github.com/boxen/puppet-osx/pull/92
	$keyboard_ids = 'ioreg -n IOHIDKeyboard -r | grep -E \'VendorID"|ProductID\' | awk \'{ print $4 }\' | paste -s -d\'-\n\' -'
	$check = 'xargs -I{} sh -c \'defaults -currentHost read -g "com.apple.keyboard.modifiermapping.{}-0" | grep "Dst = -1" > /dev/null\''
	$remap = 'xargs -I{} defaults -currentHost write -g "com.apple.keyboard.modifiermapping.{}-0" -array "<dict><key>HIDKeyboardModifierMappingDst</key><integer>-1</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>"'
	exec { 'Remap capslock to no action on all keyboards':
		command => "${keyboard_ids} | ${remap}",
		unless  => "${keyboard_ids} | ${check}"
	}

	include seil
	include seil::login_item
	seil::map { 'capslock': value => 51 }

	package {
		[
			'archey',
			'heroku-toolbelt',
			'zsh',
		]:
	}

	package { 'caskroom/versions/sublime-text3': provider => 'brewcask' }
	package { '1password': provider => 'brewcask' }
	package { 'base': provider => 'brewcask' }
	package { 'cloud': provider => 'brewcask' }
	package { 'nvalt': provider => 'brewcask' }
	package { 'rowanj-gitx': provider => 'brewcask' }
	package { 'sketch': provider => 'brewcask' }
	package { 'slack': provider => 'brewcask' }
	package { 'telegram': provider => 'brewcask' }
	package { 'textual': provider => 'brewcask' }
	package { 'whatsize': provider => 'brewcask' }

	# App Store:
	# - GIFs
	# - Tweetbot
	# - JSON Validator

}
