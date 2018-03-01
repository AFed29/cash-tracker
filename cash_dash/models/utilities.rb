class Utilities
  def self.display_pounds_pence( amount )
    pounds = amount/100
    pence = amount - (pounds*100)
    pence = pence.to_s.rjust(2, "0")
    return "£#{pounds}.#{pence}"
  end
end
