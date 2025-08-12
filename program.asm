lwi $1 4
lwi $2 1
lwi $3 1
lwi $4 1
lwi $7 7
add $1 $3 $1
add $2 $4 $2
ls $5 $1 3
add $6 $5 $2
sw $6 $31 0
beq $1 $7 4
beq $1 $31 3
beq $2 $7 4
beq $2 $31 3
j 18
sub $3 $31 $3
j 12
sub $4 $31 $4
lwi $12 2
lwi $13 10
lwi $14 200
lwi $11 0
lwi $10 0
lwi $9 0
adi $9 $9 1
bne $9 $14 -2
adi $10 $10 1
bne $10 $13 -5
adi $11 $11 1
bne $11 $12 -8
j 5