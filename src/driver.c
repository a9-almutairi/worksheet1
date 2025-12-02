// src/driver.c
// Simple C driver that calls the assembler function asm_main
int __attribute__((cdecl)) asm_main(void);

int main(void) {
int ret_status;
ret_status = asm_main();
return ret_status;
}