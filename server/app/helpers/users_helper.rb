module UsersHelper
  def self.getValidAceThemesOptionArray
    [
      ["Chrome", "chrome"],
      ["Monokai", "monokai"],
      ["Chaos", "chaos"],
      ["Solarized Dark", "solarized_dark"],
      ["Xcode", "xcode"],
      ["Solarized Light", "solarized_light"]
    ]
  end

  def self.getValidAceKeybindingsOptionArray
    [
      ["Default", "ace"],
      ["Vim", "vim"],
      ["Emacs", "emacs"]
    ]
  end

  private

end
