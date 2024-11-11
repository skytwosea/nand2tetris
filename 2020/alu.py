class ALU:

    def __init__(self, data=('0', '0'), ctrl='000000', output=('0', '0', '0')):
        self.data = data
        self.x = self.data[0]
        self.y = self.data[1]
        self.ctrl = ctrl
        self.output = output

    def z(self, binary):
        return '000000'

    def n(self, binary):
        flipped = ''
        for i in binary:
            flipped += '0' if i == '1' else '1'
        return flipped

    def f(self, a, b, flag):
        funcd = ''
        if flag:        # 2s complement add
            carry = 0
            for k, i in enumerate(reversed(list(zip(a, b)))):
                s = carry + 1 if i.count("1") == 1 else carry
                carry = 1 if i.count("1") == 2 else 0
                funcd = str(s) + funcd
        else:           # bitwise and
            for i in reversed(list(zip(a, b))):
                funcd += '1' if i[0] == '1' and i[1] == '1' else '0'
        return funcd

    def run(self):
        a, b, ctrl = self.x, self.y, self.ctrl
        flags = {flag: True if ctrl[k] == '1' else False
                 for k, flag in enumerate(['zx', 'zy', 'nx', 'ny', 'f', 'no'])}
        if flags['zx']:
            a = self.z(a)
        if flags['zy']:
            b = self.z(b)
        if flags['nx']:
            a = self.n(a)
        if flags['ny']:
            b = self.n(b)
        out = self.f(a, b, flags['f'])
        if flags['no']:
            out = self.n(out)
        return out

    def logicmap(self, ctrl=None):
        ctrl = self.ctrl if ctrl is None else ctrl
        deltax = {'00': 'x',
                  '10': '0',
                  '01': '!x',
                  '11': '-1'}
        deltay = {'00': 'y',
                  '10': '0',
                  '01': '!y',
                  '11': '-1'}
        deltaf   = {'0': '&',
                    '1': '+'}
        deltaout = {'0': '',
                    '1': '!'}
        return f'{deltax[ctrl[0:2]]:>2} {deltaf[ctrl[4]]:>2} {deltay[ctrl[2:4]]:>3} --> {deltaout[ctrl[5]]:>1}out'

    @property
    def logictable(self):
        print(f'| zx | nx | zy | ny | f  | no |       logic        |')
        for i in range(64):
            j = bin(i)[2:].zfill(6)
            print(f'| {j[0:1]:2} | {j[1:2]:2} | {j[2:3]:2} | {j[3:4]:2} | {j[4:5]:1}  | {j[5:6]:2} | {self.logicmap(j):17} |')




# test = ALU()
# print(test.logictable)

x = '101110'
y = '001101'
ctrl = '000001'
# print(f'x:   {x}\ny:   {y}\nout: {f(x,y,"1")}')

test = ALU(data=(x, y), ctrl=ctrl)
print(f'  x: {test.x}\n  y: {test.y}')
print(f'run: {test.run()}')
print(test.logictable)
