#include<stdio.h>
#include<string.h>

int main(void) {
   char s[5][20], t[20];
   int i, j;

   printf("\nEnter any five strings : ");
   for (i = 0; i < 5; i++)
      scanf("%s", s[i]);

   for (i = 1; i < 5; i++) {
      for (j = 1; j < 5; j++) {
         if (strcmp(s[j - 1], s[j]) > 0) {
            strcpy(t, s[j - 1]);
            strcpy(s[j - 1], s[j]);
            strcpy(s[j], t);
         }
      }
   }

   printf("\nStrings in order are : ");
   for (i = 0; i < 5; i++)
      printf("\n%s", s[i]);

   return (0);
}
