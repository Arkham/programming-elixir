b = << 1, 2, 3 >>
# <<1, 2, 3>>
byte_size b
# 3
bit_size b
# 24
b = << 1::size(2), 1::size(3) >>
# <<9::size(5)>>
byte_size b
# 1
bit_size b
# 5
int = << 1 >>
# <<1>>
float = << 2.5 :: float >>
# <<64, 4, 0, 0, 0, 0, 0, 0>>
<< sign::size(1), exp::size(11), mantissa::size(52) >> = << 3.14159::float >>
# <<64, 9, 33, 249, 240, 27, 134, 110>>
(1 + mantissa / :math.pow(2, 52)) * :math.pow(2, exp-1023)
# 3.14159
