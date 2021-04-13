require "minitest/autorun"

class ExpandTest < Minitest::Test
  def test_it_resolves_binomial_expansion
    assert_equal "x^2+2x+1", expand("(x+1)^2")
    assert_equal "p^3-3p^2+3p-1", expand("(p-1)^3")
    assert_equal "64f^6+768f^5+3840f^4+10240f^3+15360f^2+12288f+4096", expand("(2f+4)^6")
    assert_equal "1", expand("(-2a-4)^0")
    assert_equal "144t^2-1032t+1849", expand("(-12t+43)^2")
    assert_equal "r^203", expand("(r+0)^203")
    assert_equal "x^2+2x+1", expand("(-x-1)^2")
    assert_equal "-8k^3-36k^2-54k-27", expand('(-2k-3)^3')
  end
end

def expand(expresion)
  expresion = expresion.split(/(\()([-+]?(\d*?.))([-+]?(\d?.))(\))(\^)([0-9]*)/)
  a, b, n = expresion[2], expresion[4].to_i, expresion[-1].to_i

  n.zero? && (return "1")

  (0..n).each_with_object("") do |k, memo|
    nf = (1..n).inject(:*)
    knkf = (1..k).inject(:*).to_i * (1..(n - k)).inject(:*).to_i
    nk = knkf.zero? ? 1 : nf / knkf

    na, ca = a.split(/([-+]?\d*)?([-+]?.)/)[1..-1]
    na.empty? && (na = 1)
    na == "-" && (na = -1)
    na = na.to_i

    (n-k) > 0 && (exp_a = "#{ca}")
    (n-k) > 1 && (exp_a << "^#{(n-k)}")

    nk_exp_a_exp_b = (nk * (na ** (n-k)) * (b ** k))
    nk_exp_a_exp_b.zero? && next

    if nk_exp_a_exp_b.positive? && k != 0
      nk_exp_a_exp_b = "+#{nk_exp_a_exp_b}"
    elsif nk_exp_a_exp_b.to_s == "-1" && k.zero?
      nk_exp_a_exp_b = "-"
    elsif nk_exp_a_exp_b == 1
      nk_exp_a_exp_b = ""
    end

    memo << "#{nk_exp_a_exp_b}#{exp_a}"
  end
end
