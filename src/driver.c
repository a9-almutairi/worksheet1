// /src/driver.c
// Shared C driver that calls asm_main() from each assembly program.
#ifdef _MSC_VER
#define CDECL __cdecl
#else
#define CDECL __attribute__((cdecl))
#endif

int CDECL asm_main(void);

int main(void) {
    return asm_main();
}
