##
## EPITECH PROJECT, 2018
## PSU_navy_2017
## File description:
## Makefile for navy project
##

## VARIABLES

NAME 		=	tetris

UNITS 		= 	units

SRC_DIR 	= 	src/

TEST_DIR	= 	tests/

SRC_FILES	= 	main.c		\
			tetris.c	\
			managers/errors/check_err.c	\
			managers/map/display_game.c	\
			managers/map/display_map.c	\
			managers/map/create_tetris_title.c	\
			managers/map/tetris_letter/letter_1.c	\
			managers/map/tetris_letter/letter_2.c	\
			managers/map/tetris_letter/letter_3.c	\
			managers/map/tetris_letter/letter_4.c	\
			managers/map/tetris_letter/letter_5.c	\
			managers/map/tetris_letter/letter_6.c	\
			managers/tetriminos/directory_reader.c 	\
			managers/tetriminos/fill_struct.c 		\
			utils/get_next_line.c 	\
			utils/struct_utils.c

SRC		= 	$(addprefix $(SRC_DIR), $(SRC_FILES))

TESTS_FILES	=	$(filter-out main.c, $(SRC_FILES))

TESTS_FILES	+=	""

INCLUDE		= 	include/

LIBRARY_DIR	= 	lib/

CC		=	gcc

CFLAGS		= 	-Wall -Wextra -I $(INCLUDE) -g3

LFLAGS		= 	-L $(LIBRARY_DIR) -lmy -lncurses

UNITS_LFLAGS	= 	$(LFLAGS) -lgcov -lcriterion

## BUILD VARIABLES

BUILD_DIR		= 	build/

BUILD_TESTS_DIR		= 	tests/build/

BUILD_OBJ		= 	$(addprefix $(BUILD_DIR), $(SRC_FILES:.c=.o))

BUILD_TESTS_OBJ		= 	$(addprefix $(BUILD_TESTS_DIR), $(TESTS_FILES:.c=.o))

BUILD_SD		= 	$(shell find $(SRC_DIR) -mindepth 1 -type d -printf '%p\n' | sed -e 's/^src\///')

## RULES

all:			library $(BUILD_DIR) $(NAME)

library:
			make -C $(LIBRARY_DIR)

$(BUILD_DIR):
			mkdir -p $(BUILD_DIR)
			$(foreach SUB_DIR, $(BUILD_SD), $(shell mkdir -p $(BUILD_DIR)$(SUB_DIR)))

$(BUILD_DIR)%.o:	$(SRC_DIR)%.c
			$(CC) $(CFLAGS)   -c -o $@ $<

$(NAME):		$(BUILD_OBJ)
			$(CC) $(CFLAGS)   -o $(NAME) $(BUILD_OBJ) $(LFLAGS)

tests_run:		fclean library $(UNITS)
			find $(BUILD_TESTS_DIR) -name '*.gc*' -exec mv -t ./ {} +
			./$(UNITS)

$(UNITS):		$(BUILD_TESTS_DIR) $(BUILD_TESTS_OBJ)
			$(CC) $(CFLAGS)   -o $(UNITS) $(BUILD_TESTS_OBJ) --coverage $(UNITS_LFLAGS)

$(BUILD_TESTS_DIR):
			mkdir -p $(BUILD_TESTS_DIR)$(TEST_DIR)
			$(foreach SUB_DIR, $(BUILD_SD), $(shell mkdir -p $(BUILD_TESTS_DIR)$(SUB_DIR)))

$(BUILD_TESTS_DIR)%.o:	$(SRC_DIR)%.c
			$(CC) $(CFLAGS) --coverage   -c -o $@ $<

$(BUILD_TESTS_DIR)%.o:	$(TEST_DIR)%.c
			$(CC) $(CFLAGS) --coverage   -c -o $@ $<

clean:
			rm -rf $(BUILD_DIR)
			rm -rf $(BUILD_TESTS_DIR)
			find -name '*.gc*' -delete -or -name 'vgcore.*' -delete -o -name '*.o' -delete
			make clean -C $(LIBRARY_DIR)

fclean:			clean
			rm -rf $(NAME)
			rm -rf $(UNITS)
			make fclean -C $(LIBRARY_DIR)

re:			fclean all

# Just in case those files exist in the root dir
.PHONY			: all library clean fclean re tests_run
