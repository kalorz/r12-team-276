class String
  NON_WHITESPACE_REGEXP	=	%r![^\s#{[0x3000].pack("U")}]!

  def blank?
    self !~ NON_WHITESPACE_REGEXP
  end

end