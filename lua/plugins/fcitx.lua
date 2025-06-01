return {
	"drop-stones/im-switch.nvim",
	event = "VeryLazy",
	opts = {
		linux = {
			enabled = true,
			default_im = "keyboard-us-dvp",
			get_im_command = { "fcitx5-remote", "-n" },
			set_im_command = { "fcitx5-remote", "-s" },
		},
	}
}
