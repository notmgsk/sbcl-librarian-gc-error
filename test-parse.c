#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "parsejson.h"

void die(char *msg) {
  printf("%s\n", msg);
  exit(1);
}

char *read_isa() {
  FILE *ptr;
  char *ch = malloc(106656 + 1);

  ptr = fopen("aspen-9-isa.json", "r");

  if (NULL == ptr) {
    printf("file can't be opened \n");
  }

  fread(ch, 106656, 1, ptr);
  fclose(ptr);

  ch[106656] = '\0';
  return ch;
}

int main() {
  init("parsejson.core");

  parsejson_json json;

  if (parsejson_parse(read_isa(), &json) != PARSEJSON_ERROR_SUCCESS) {
    char *error;
    parsejson_error(&error);
    printf("error: %s\n", error);
    exit(1);
  }

  return 0;
}
