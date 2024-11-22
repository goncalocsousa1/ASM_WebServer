# Assembly Web Server

This project is a simple implementation of a web server using x86-64 Assembly, built based on a detailed tutorial. The server accepts client connections and responds with a simple HTML page.

## Features

- Creation of a TCP/IP socket
- Binding the socket to a specific port (3000)
- Listening for incoming client connections
- Sending a simple HTTP response with HTML content
- Closing the connection after sending the response

## How It Works

1. **Socket and Bind:** The server creates a socket and binds it to port 3000 on the local interface.
2. **Listen and Accept:** The server listens for client connections and accepts a connection when a client attempts to connect.
3. **HTTP Response:** The server sends a simple HTTP response with a basic Hello world HTML page.
4. **Closing the Connection:** After sending the response, the server closes the client connection.

## Requirements

    Linux (Ubuntu, for example)
    NASM (for compiling the Assembly code)
    GNU LD (for linking the compiled code)
    Basic knowledge of Assembly and TCP/IP networking

## Running the Project
1. **Clone the repository: **
   ```
   git clone https://github.com/goncalocsousa1/ASM_WebServer.git
   ```
2. **Compile the Assembly code:**
   ```
   nasm -f elf64 live.asm -o live.o
   ```
3. **Link the compiled code:**
   ```
   ld live.o -o live
   ```
4. **Run the server:**
  ```
  ./live
  ```
5. **Open a browser and visit http://localhost:3000 to see the server's response.**

![imagem](https://github.com/user-attachments/assets/3dc6e6ee-6d85-4104-9709-79d8e5179f04)

## Credits
This project was built from the tutorial [Building a Web Server in Assembly x86](https://dev.to/leandronsp/construindo-um-web-server-em-assembly-x86-parte-i-introducao-14p5) by Leandro Nascimento, which provided a detailed explanation of how to create a simple web server in Assembly. 
