         ;代码清单7-1
         ;文件名：c07_mbr.asm
         ;文件说明：硬盘主引导扇区代码
         ;创建日期：2011-4-13 18:02
         
         jmp near start
	
 message db '1+2+3+...+100='
        
 start:
         mov ax,0x7c0           ;设置数据段的段基地址 
         mov ds,ax

         mov ax,0xb800          ;设置附加段基址到显示缓冲区
         mov es,ax

         ;以下显示字符串 
         mov si,message          
         mov di,0
         mov cx,start-message
     @g:
         mov al,[si]
         mov [es:di],al
         inc di
         mov byte [es:di],0x07
         inc di
         inc si
         loop @g                ;loop 和 rep 都是根据CX寄存器的值递减到0 从而决定循环次数

         ;以下计算1到100的和 
         xor ax,ax
         mov cx,1
     @f:
         add ax,cx
         inc cx
         cmp cx,100
         jle @f

         ;以下计算累加和的每个数位 
         xor cx,cx              ;设置堆栈段的段基地址
         mov ss,cx
         mov sp,cx

         mov bx,10
         xor cx,cx
     @d:
         inc cx
         xor dx,dx
         div bx
         or dl,0x30            ;dl中存的是除10后的余数,所以dl高4位一定为0,这里 or dl,0x30 和 add dl,0x30是相同的结果
         push dx               ;CS和SS都设置为0, 且sp也设置为0, push dx 导致SP减2, 栈向下增长,导致SP指向了高字节地址,而CS是向上增长,代码段和栈段不会重叠
         cmp ax,0              ;div后ax存储的是商值
         jne @d

         ;以下显示各个数位 
     @a:
         pop dx
         mov [es:di],dl        ;push 和 pop 不能以字节为单位,最小都得是字,所以push的时候是push dx而不能push dl
         inc di
         mov byte [es:di],0x07
         inc di
         loop @a
       
         jmp near $ 
       

times 510-($-$$) db 0
                 db 0x55,0xaa
