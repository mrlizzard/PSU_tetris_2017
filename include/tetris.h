/*
** EPITECH PROJECT, 2018
** PSU_tetris_2017
** File description:
** tetris functions (header file)
*/

# ifndef TETRIS_H
# define TETRIS_H

# include "structs.h"

// tetris.c
int 		tetris_main(int ac, char **av);

<<<<<<< HEAD
//error_management
int check_err(int ac, char **av);
=======
// error_management
int 		check_err(int ac, char **av);

// utils/struct_utils.c
void 		free_all(main_t *main);
main_t 		*configure(void);
>>>>>>> 7a5a660aca0e40138bceda078c47f83a6c6da0be

//map_management
void display_map(main_t *main);

# endif