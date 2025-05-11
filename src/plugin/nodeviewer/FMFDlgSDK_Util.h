#define SHORTSTRING_SETTEXT(p,q) p->Size=strlen(q); memcpy(p->Text,q,strlen(q));
#define SHORTSTRING_SETTEXTZ(p,q) p->Size=strlen(q); memcpy(p->Text,q,strlen(q)+1);
