# encoding: utf-8
require 'tk'

def packing(padx, pady, side=:left, anchor=:n)
	{ "padx"=>padx, "pady"=>pady, 
		"side"=>side.to_s, "anchor"=>anchor.to_s}
end

root = TkRoot.new {title "Telnet сессия"}

top = TkFrame.new(root)
fr1 = TkFrame.new(top)
fr1a = TkFrame.new(fr1)
fr1b = TkFrame.new(fr1)
fr2 = TkFrame.new(top)
fr3 = TkFrame.new(top)
fr4 = TkFrame.new(top)

LabelPack = packing(5,5,:top,:w)
EntryPack = packing(5,2,:top)
ButtonPack = packing(15,5,:left,:center)
FramePack = packing(2,2,:top)
Frame1Pack = packing(2,2,:left)

var_host = TkVariable.new
var_port = TkVariable.new
var_user = TkVariable.new
var_pass = TkVariable.new

lab_host = TkLabel.new(fr1a) do
	text "Имя сервера"
	pack LabelPack
end

ent_host = TkEntry.new(fr1a) do
	width 15
	textvariable var_host
	font "{Arial} 10"
	pack EntryPack
end

lab_port = TkLabel.new(fr1b) do
	text "Порт"
	pack LabelPack
end
ent_port = TkEntry.new(fr1b) do
	width 4
	textvariable var_port
	font "{Arial} 10"
	pack EntryPack
end

lab_user = TkLabel.new(fr2) do
	text "Имя пользователя"
	pack LabelPack
end
ent_user = TkEntry.new(fr2) do
	width 23
	textvariable var_user
	font "{Arial} 10"
	pack EntryPack
end

lab_pass = TkLabel.new(fr3) do
	text "Пароль"
	pack LabelPack
end
ent_pass = TkEntry.new(fr3) do
	width 23
	show "*"
	textvariable var_pass
	font "{Arial} 10"
	pack EntryPack
end

btn_signon = TkButton.new(fr4) do
	text "Войти"
	command proc {}
	pack ButtonPack
end

btn_cancel = TkButton.new(fr4) do
	text "Cancel"
	command proc {exit}
	pack ButtonPack
end


top.pack FramePack
fr1.pack FramePack
fr1a.pack Frame1Pack
fr1b.pack Frame1Pack
fr2.pack FramePack
fr3.pack FramePack
fr4.pack FramePack

var_host.value = "127.0.0.1"
var_user.value = "Cema"
var_port.value = 23

ent_pass.focus

Tk.mainloop