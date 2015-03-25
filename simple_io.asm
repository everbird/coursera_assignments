# test.asm

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

        la  $t0, '?'
        move  $t1, $v0
        beq $t0, $t1, end

        # check_lowers:
        move $t0, $v0
        la  $t1, 'z'
        bgt $t0, $t1, print_default
        la  $t1, 'a'
        bge $t0, $t1, find_lower

        # check_capitals:
        move $t0, $v0
        la  $t1, 'Z'
        bgt $t0, $t1, print_default
        la  $t1, 'A'
        bge $t0, $t1, find_capitals

        # check_numbers:
        move $t0, $v0
        la  $t1, '0'
        blt $t0, $t1, print_default
        la  $t1, '9'
        bgt $t0, $t1, print_default

find_numbers:
        la $s1, numbers
        li  $t3, 48
        j   print

find_capitals:
        la $s1, capitals
        li  $t3, 65
        j   print

find_lower:
        la $s1, lowers
        li  $t3, 97
        j   print

print:
        move  $t2, $v0
        sub $t1, $t2, $t3
        mul $t0, $t1, 4
        la  $t3, ($s1)
        add $t1, $t0, $t3
        lw  $t2, ($t1)
        la  $a0, 0($t2)

        li  $v0, 4
        syscall
        j   main

print_default:
        la  $a0, star
        li  $v0, 4
        syscall
        j   main

end:
