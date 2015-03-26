# find_char.asm
#
# String search and compare
# Ref: Coursera | PKU | Computer Organization | Peer Assessments 2
#
#     利用系统功能调用从键盘输入一个字符串，然后输入单个字符，查找该字符串中是否有该字符（区分大小写）。具体要求如下：
#
#     (1)      如果找到，则在屏幕上显示：
#
#     Success! Location: X
#
#     其中，X为该字符在字符串中第一次出现的位置
#
#     (2)      如果没找到，则在屏幕上显示：
#
#     Fail!
#
#     (3)      输入一个字符串后，可以反复输入希望查询的字符，直到按“?”键结束程序
#
#     (4)      每个输入字符独占一行，输出查找结果独占一行，位置编码从1开始。
#
#     提示：为避免歧义，字符串内不包含"?"符号
#
#     格式示例如下：
#
#     abcdefgh
#
#     a
#
#     Success! Location: 1
#
#     x
#
#     Fail!
#
# :copyright: (c) 2015 by Stephen Zhuang.
#
#

        .data
store:  .space  64
msg_success:    .asciiz "Success! Location: "
msg_fail:       .asciiz "Fail!\n"

        .text
        .globl main
main:
        li  $v0, 8
        la  $a0, store
        li  $a1, 64
        syscall

read_char:
        li  $v0, 12
        syscall

        beq $v0, '?', end

        # Reset status
        la  $t0, store
        li  $t3, 1
search:
        lb  $t1, ($t0)  # Read one char from string
        beq $t1, $v0, print_found
        beq $t1, '\0', not_found
        addi    $t0, $t0, 1 # Address offset +1
        addi    $t3, $t3, 1 # Counter +1
        j   search

print_found:
        la  $a0, msg_success
        li  $v0, 4
        syscall

        add $a0, $t3, $zero
        li  $v0, 1
        syscall

        la  $a0, '\n'
        li  $v0, 11
        syscall

        j   read_char

not_found:
        la  $a0, msg_fail
        li  $v0, 4
        syscall
        j   read_char

end:
