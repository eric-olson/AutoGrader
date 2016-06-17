module UsersHelper
  def self.getValidAceThemes()
    [
      ["Chrome", "chrome"],
      ["Monokai", "monokai"],
      ["Chaos", "chaos"],
      ["Solarized Dark", "solarized_dark"],
      ["Xcode", "xcode"],
      ["Solarized Light", "solarized_light"]
    ]
  end

  def self.getValidAceKeybindings()
    [
      "ace",
      "vim",
      "emacs"
    ]
  end

end
