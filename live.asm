global _start

%define SYS_socket 41
%define SYS_bind 49
%define SYS_listen 50
%define SYS_accept 288
%define SYS_write 1
%define SYS_close 3

%define AF_INET 2
%define SOCK_STREAM 1
%define SOCK_PROTOCOL 0
%define BACKLOG 2
%define CR 0xD
%define LF 0xA

; Data types in asm
; byte => 1 byte
; word => 2 bytes
; doubleword => 4 bytes
; quadword => 8 bytes
  
  
section .bss
sockfd: resq 1    ; Use `resq` para armazenar o descritor do socket (8 bytes)

section .data
sockaddr: 
    family: dw AF_INET   ; 2 bytes
    port: dw 0xB80B      ; 2 bytes (representa a porta 3000)
    ip_address: dd 0     ; 4 bytes
    sin_zero: dq 0       ; 8 bytes

response: 
    headline: db "HTTP/1.1 200 OK", CR, LF
    content_type: db "Content-Type: text/html", CR, LF
    content_length: db "Content-Length: 22", CR, LF
    crlf: db CR, LF
    body: db "<h1>Hello, World!</h1>"
responseLen: equ $ - response

section .text
_start:
.socket:
    ; int socket(int domain, int type, int protocol)
    mov rdi, AF_INET
    mov rsi, SOCK_STREAM
    mov rdx, SOCK_PROTOCOL
    mov rax, SYS_socket
    syscall
    mov [sockfd], rax  ; Armazena o descritor de socket

.bind:
    ; int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen)
    mov rdi, [sockfd]     ; Descritor de arquivo do socket
    lea rsi, [sockaddr]   ; Endereço do `sockaddr`
    mov rdx, 16           ; Tamanho da estrutura `sockaddr`
    mov rax, SYS_bind
    syscall

.listen:
    ; int listen(int sockfd, int backlog)
    mov rdi, [sockfd]
    mov rsi, BACKLOG
    mov rax, SYS_listen
    syscall

.accept:
    ; int accept(int sockfd, struct *addr, int addrlen, int flags)
    mov rdi, [sockfd]
    mov rsi, 0              ; não precisa estabelecer um addr
    mov rdx, 0              ; não precisa do tamanho uma vez que não há addr
    mov r10, 0
    mov rax, SYS_accept
    syscall
    mov r8, rax 	    ; client socket    
    call .write             ; escreve no socket
    call .close             ; fecha o socket
    jmp .accept             ; mantém o servidor em loop

.write:
    ; int write(int fd, buffer *bf, int bfLen)
    mov rdi, r8
    mov rsi, response
    mov rdx, responseLen
    mov rax, SYS_write
    syscall
    ret

.close:
    ; int close(int fd)
    mov rdi, r8
    mov rax, SYS_close
    syscall
    ret


