#-*- coding: utf-8

Plugin.create(:tanzaku) do
  UserConfig[:tanzaku_ni_suru] ||= true

  settings "短冊" do
    boolean '短冊にする', :tanzaku_ni_suru
  end 
  filter_gui_postbox_post do |gui_postbox|
    buf = Plugin.create(:gtk).widgetof(gui_postbox).widget_post.buffer
    text = buf.text
    if UserConfig[:tanzaku_ni_suru]
      to = nil
      if /^@[a-zA-Z0-9_]* / =~ text
         tmp = text.split(" ", 2)
         to = tmp[0]
         text = tmp[1]
      end
      str = ""
      str = to unless to.nil?
      str += "\n" unless to.nil?
      str += ["┏┷┓\n┃　┃\n┃", "★┷┓\n┃　┃\n┃"].choice
      text.each_char {|char| str += char + "┃\n┃"}
      str += ["　┃\n┗━┛\n", "　┃\n┗━★\n"].choice
      buf.text = str
    end
    [gui_postbox]
  end
end
