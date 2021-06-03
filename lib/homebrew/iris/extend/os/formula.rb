# frozen_string_literal: true

class Formula
  undef prefix
  def prefix(v=nil)
    Pathname.new($target)
  end

  undef rack
  def rack
    Pathname.new($target)
  end

  undef opt_prefix
  def opt_prefix
    $known_packages[name]
  end
end
