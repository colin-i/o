
printf '%s' $(objdump -h a | grep .data | tr -s ' ' | cut -d ' ' -f 4) > temp

objcopy ${1} --update-section .text=text.bin --update-section .data=data.bin
