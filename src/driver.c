// file: src/driver.c
// Shared C driver that calls asm_main in each NASM program


#ifdef __cplusplus
extern "C" {
#endif
int asm_main(void); // cdecl
#ifdef __cplusplus
}
#endif


int main(void) {
int ret_status = asm_main();
return ret_status;
}
