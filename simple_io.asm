# test.asm

        .data
a:      .asciiz "Alpha\n"
b:      .asciiz "Bravo\n"
c:      .asciiz "China\n"
star:   .asciiz "*\n"

        .text
        .globl  main
main:
loop:   li  $v0, 12
        syscall

        la  $t0, '?'
        move  $t1, $v0
        beq $t0, $t1, end

        la  $t0, 'a'
        move  $t1, $v0
        beq $t0, $t1, printa

        la  $t0, 'b'
        move  $t1, $v0
        beq $t0, $t1, printb

        la  $t0, 'c'
        move  $t1, $v0
        beq $t0, $t1, printc

        j   printstar

printa: la  $a0, a
        li  $v0, 4
        syscall
        j   loop

printb: la  $a0, b
        li  $v0, 4
        syscall
        j   loop

printc: la  $a0, c
        li  $v0, 4
        syscall
        j   loop

printstar:
        la  $a0, star
        li  $v0, 4
        syscall
        j   loop

end:
