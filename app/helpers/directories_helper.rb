module DirectoriesHelper
  #
  # 3132
  # =>
  # "00:52:12"
  #
  def string_from_second(length)
    h = length / 3600
    m = (length % 3600) / 60
    s = (length % 3600) % 60
    format('%<h>02d:%<m>02d:%<s>02d', h: h, m: m, s: s)
  end
end
