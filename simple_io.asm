# simple_io.asm
#
# Simple i/o using syscall
# Ref: Coursera | PKU | Computer Organization | Peer Assessments 1
#
# 利用系统功能调用从键盘输入，转换后在屏幕上显示，具体要求如下：
#
# (1)     如果输入的是字母（A~Z，区分大小写）或数字（0~9），则将其转换成对应的英文单词后在屏幕上显示，对应关系见下表
#
# (2)     若输入的不是字母或数字，则在屏幕上输出字符“*”，
#
# (3)     每输入一个字符，即时转换并在屏幕上显示，
#
# (4)     支持反复输入，直到按“?”键结束程序。
#
# :copyright: (c) 2015 by Stephen Zhuang.
#

        .data
_A:     .asciiz "Alpha\n"
_B:     .asciiz "Bravo\n"
_C:     .asciiz "China\n"
_D:     .asciiz "Delta\n"
_E:     .asciiz "Echo\n"
_F:     .asciiz "Foxtrot\n"
_G:     .asciiz "Golf\n"
_H:     .asciiz "Hotel\n"
_I:     .asciiz "India\n"
_J:     .asciiz "Juliet\n"
_K:     .asciiz "Kilo\n"
_L:     .asciiz "Lima\n"
_M:     .asciiz "Mary\n"
_N:     .asciiz "November\n"
_O:     .asciiz "Oscar\n"
_P:     .asciiz "Paper\n"
_Q:     .asciiz "Quebec\n"
_R:     .asciiz "Research\n"
_S:     .asciiz "Sierra\n"
_T:     .asciiz "Tango\n"
_U:     .asciiz "Uniform\n"
_V:     .asciiz "Victor\n"
_W:     .asciiz "Whisky\n"
_X:     .asciiz "X-ray\n"
_Y:     .asciiz "Yankee\n"
_Z:     .asciiz "Zulu\n"
_a:     .asciiz "alpha\n"
_b:     .asciiz "bravo\n"
_c:     .asciiz "china\n"
_d:     .asciiz "delta\n"
_e:     .asciiz "echo\n"
_f:     .asciiz "foxtrot\n"
_g:     .asciiz "golf\n"
_h:     .asciiz "hotel\n"
_i:     .asciiz "india\n"
_j:     .asciiz "juliet\n"
_k:     .asciiz "kilo\n"
_l:     .asciiz "lima\n"
_m:     .asciiz "mary\n"
_n:     .asciiz "november\n"
_o:     .asciiz "oscar\n"
_p:     .asciiz "paper\n"
_q:     .asciiz "quebec\n"
_r:     .asciiz "research\n"
_s:     .asciiz "sierra\n"
_t:     .asciiz "tango\n"
_u:     .asciiz "uniform\n"
_v:     .asciiz "victor\n"
_w:     .asciiz "whisky\n"
_x:     .asciiz "x-ray\n"
_y:     .asciiz "yankee\n"
_z:     .asciiz "zulu\n"
_0:     .asciiz "zero\n"
_1:     .asciiz "First\n"
_2:     .asciiz "Second\n"
_3:     .asciiz "Third\n"
_4:     .asciiz "Fourth\n"
_5:     .asciiz "Fifth\n"
_6:     .asciiz "Sixth\n"
_7:     .asciiz "Seventh\n"
_8:     .asciiz "Eighth\n"
_9:     .asciiz "Ninth\n"
star:   .asciiz "*\n"

capitals:   .word   _A, _B, _C, _D, _E, _F, _G, _H, _I, _J, _K, _L, _M, _N, _O, _P, _Q, _R, _S, _T, _U, _V, _W, _X, _Y, _Z
lowers:     .word   _a, _b, _c, _d, _e, _f, _g, _h, _i, _j, _k, _l, _m, _n, _o, _p, _q, _r, _s, _t, _u, _v, _w, _x, _y, _z
numbers:    .word   _0, _1, _2, _3, _4, _5, _6, _7, _8, _9

        .text
        .globl  main
main:
        li  $v0, 12
        syscall

        beq $v0, '?', end

        # Ref: http://en.wikipedia.org/wiki/ASCII#ASCII_printable_code_chart
        bgt $v0, 'z', print_default # ascii[z:]
        bge $v0, 'a', find_lower    # ascii[a:z]
        bgt $v0, 'Z', print_default # ascii[Z:a]
        bge $v0, 'A', find_capitals # ascii[A:Z]
        bgt $v0, '9', print_default # ascii[9:A]
        blt $v0, '0', print_default # ascii[:0]
        # ascii[0:9]

find_numbers:
        la $s0, numbers
        li  $t3, '0'
        j   print

find_capitals:
        la $s0, capitals
        li  $t3, 'A'
        j   print

find_lower:
        la $s0, lowers
        li  $t3, 'a'
        j   print

print:
        sub $t1, $v0, $t3   # Caculate index
        mul $t0, $t1, 4     # Caculate address offset for string array
        la  $t3, ($s0)
        add $t1, $t0, $t3   # Find address in string array for symbolic address
        lw  $t2, ($t1)      # Load symbolic address as content from found address

        la  $a0, ($t2)      # Output the found symbloic address content
        li  $v0, 4
        syscall
        j   main

print_default:
        la  $a0, star
        li  $v0, 4
        syscall
        j   main

end:
