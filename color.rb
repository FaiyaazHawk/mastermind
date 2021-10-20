# frozen_string_literal: true

# add on to string class to mod in colors required
class String
  def green
    "\e[32m#{self}\e[0m"
  end

  def blue
    "\e[34m#{self}\e[0m"
  end

  def yellow
    "\e[33m#{self}\e[0m"
  end

  def magenta
    "\e[35m#{self}\e[0m"
  end

  def cyan
    "\e[36m#{self}\e[0m"
  end

  def grey
    "\e[37m#{self}\e[0m"
  end

  def white
    "\e[97m#{self}\e[0m"
  end

  def red
    "\e[31m#{self}\e[0m"
  end
end
