require("blink.cmp").setup {
	completion = {
		list = {
			selection = { preselect = false, auto_insert = true },
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
			window = {
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
			},
		},
		menu = {
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
			auto_show_delay_ms = 500,
			scrollbar = false,
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind" }
				},
			},
		},
	},
}
