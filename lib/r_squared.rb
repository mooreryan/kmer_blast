require 'parallel'
require 'linefit'

# r = Pearson's r, equiv. to Spearman's rho if data is ranked
# r is also the sqrt of coefficient of determination R^2
# n = number of data points
def t_test r, n
  r * Math.sqrt( (n-2) / (1-r**2).to_f)
end

def r_squared tud_map1, tud_map2
  line_fit = LineFit.new

  x = []
  y = []
  tud_map1.each do |kmer, tud|
    x << tud
    y << tud_map2[kmer]
  end
  line_fit.setData x, y
  line_fit.rSquared
end

def pearsons_r r_squared
  Math.sqrt r_squared
end

# http://www.danielsoper.com/statcalc3/calc.aspx?id=8
# t values > 1.97 have p < 0.05 w/ 256 pts
def analyze tud_map1, tud_map2
  r2 = r_squared tud_map1, tud_map2
  r = pearsons_r r2
  t = t_test r, tud_map1.count
  if t > 1.97
    significant = true
  else
    significant = false
  end  
  { r_squared: r2, t: t, significant: significant }
end
