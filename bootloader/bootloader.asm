bits 16             ; 16-битный режим
org 0x7c00        ; Адрес загрузки загрузчика

; Инициализация
mov ax, 0x0003      ; Режим видео 80x25 
int 0x10           ; Вызов BIOS для установки режима видео

; Загрузка ядра
mov ax, 0x0201      ; Функция загрузки сектора
mov bx, 0x0000      ; Номер диска (0 - жесткий диск)
mov cx, 0x0001      ; Номер сектора (первый сектор)
mov dx, 0x0000      ; Номер головки (не используется)
mov es, 0x0000      ; Сегмент памяти для загрузки
int 0x13           ; Вызов BIOS для загрузки сектора

; Передача управления ядру
jmp 0x0000:0x7c00  ; Передача управления на адрес ядра

; Заполняем оставшуюся часть сектора нулями
times 510 - ($ - $$) db 0
dw 0xaa55            