extends Node

func open_link(link : String, mobile_link : String = ""):
	var link_to_open : String
	if mobile_link.is_empty(): link_to_open = link
	else:
		link_to_open = mobile_link if OS.has_feature("mobile") else link
	OS.shell_open(link_to_open)
