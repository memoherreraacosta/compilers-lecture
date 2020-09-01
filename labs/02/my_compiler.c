#include <stdio.h>

int lexical_analysis(FILE *file);

int main(int argc, char *argv[])
{
	if (argc == 2){
		FILE *file = fopen(argv[1], "r");
		if (file == NULL){
			printf("Invalid file, try again.\n");
			return 0;
		}
		int has_errors = lexical_analysis(file);
		if (!has_errors)
			printf("There are no errors\n");

	}
	else{
		printf("Invalid arguments.\n");
	}
	return 0;
}

int lexical_analysis(FILE *file)
{
	char currentC;
	int current_index = 0,
		current_line = 0,
		dqErrLine = 0,
		sqErrLine = 0,
		sqErrChar = 0,
		dqErrChar = 0,
		parErrLine = 0,
		parErrChar = 0,
		bracesErrLine = 0,
		bracesErrChar = 0,
		bracketsErrLine = 0,
		bracketsErrChar = 0,
		braces = 0,
		brackets = 0,
		par = 0,
		dquotes = 0,
		squotes = 0,
		dqOpened = 0,
		sqOpened = 0,
		comments = 0;

	while ((currentC = getc(file)) != EOF)
	{
		if (comments && currentC == '\n'){
			current_index = 0;
			current_line++;
			comments = 0;
		}

		if (currentC == '/'){
			currentC = getc(file);
			if (currentC == '/'){
				comments = 1;
			}
		}

		if (!comments){
			switch (currentC){

			case '\n':
				current_index = 0;
				current_line++;
				break;
			case '\"':
				if (dquotes == 0){
					dqOpened = 1;
					dquotes++;
					dqErrLine = current_line;
					dqErrChar = current_index;
					break;
				}
				dquotes--;
				dqOpened = 0;
				break;
			case 39: // " ' "
				if (squotes == 0){
					sqOpened = 1;
					squotes++;
					sqErrLine = current_line;
					sqErrChar = current_index;
					break;
				}
				squotes--;
				sqOpened = 0;
				break;
			case '(':
				if (par == 0){
					parErrLine = current_line;
					parErrChar = currentC;
				}
				par++;
				break;
			case ')':
				if (par == 0){
					printf("There is a missing '%c' error in this line : '%d', char position '%d'\n", currentC, current_line, current_index);
				}
				par--;
				break;
			case '[':
				if (braces == 0){
					bracesErrLine = current_line;
					bracesErrChar = currentC;
				}
				braces++;
				break;
			case ']':
				if (braces == 0){
					printf("There is a missing '%c' error in this line : '%d', char position '%d'\n", currentC, current_line, current_index);
				}
				braces--;
				break;
			case '{':
				if (brackets == 0){
					bracketsErrLine = current_line;
					bracketsErrLine = currentC;
				}
				brackets++;
				break;
			case '}':
				if (brackets == 0){
					printf("There is a missing '%c' error in this line : '%d', char position '%d'\n", currentC, current_line, current_index);
				}
				brackets--;
				break;
			default:
				break;
			}
		}
		current_index++;
	}

	if (par){
		printf("There is a missing parenthesis error in this line : '%d', char position '%d'\n", parErrLine, parErrChar);
	}

	if (brackets){
		printf("There is a missing brackets error in this line : '%d', char position '%d'\n", bracketsErrLine, bracketsErrChar);
	}

	if (braces){
		printf("There is a missing braces error in this line : '%d', char position '%d'\n", bracketsErrLine, bracketsErrChar);
	}

	if (dqOpened){
		printf("There is a missing double quotes at line %d, character position %d\n", dqErrLine, dqErrChar);
	}

	if (sqOpened){
		printf("There is a missing single quote at line %d, character position %d\n", sqErrLine, sqErrChar);
	}
	if (par || brackets || braces || dqOpened || sqOpened)
		return 1;

	return 0;
}