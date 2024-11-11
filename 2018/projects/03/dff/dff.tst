load dff.hdl,
output-file dff.out,
compare-to dff.cmp,
output-list in%B3.1.3 out%B3.1.3;

set in 0,
tick,
output;

tock,
output;

set in 1,
tick,
output;

tock,
output;

set in 1,
tick,
output;

tock,
output;

set in 0,
tick,
output;

tock,
output;

set in 0,
tick,
output;

tock,
output;
