# Wastelanders

Wastelanders is a console RPG with elements from DnD/Fallout/Pokemon.
It is a turn-based game with the goal of scoring the best score you can.

## Start

Wastelanders are intended to run on the PIPBOI system([GitHub here](https://github.com/MurasakiAki/pipboi)), it can be run as a standalone game, but it requires additional steps.

### For PIPBOI

If you have PIPBOI installed, simply move `wastelanders` folder into `pipboi/mods` folder. Run PIPBOI and then you can run Wastelanders via commands.

### Standalone game

You can try running the `main.sh` script with a `username` input.
It may not work. **Running Wastelnders outside of PIPBOI system is not recommended nor supported.**

## How it works?

Even tho Wastelanders are mainly written in Bash script, simple classes are used to create items and characters in the game.

Such example would be, Characters - Player and Enemy, or Items, such as Syringes, Weapons or Display Weapons.

The method of having classes in Bash script is very simple and interesting, here is a sum up of how i did it with Item class:

- **Class file**
  First we will create a class file of an object we want to create, Item for example, this class has property array, and names of variables this class has, each of those variables has assigned ID from 0 to _n_. In Item class these variables are `name` with ID _0_, `stm_per_use` with ID _1_ and `quantity` with ID value of _2_.

  You can then create this `item.property` function:

  ```bash
      item.property() {
        if [ "$2" == "=" ]
        then
          item_properties[$1]=$3
        else
          echo ${item_properties[$1]}
        fi
      }
  ```

  This function `item.property` will either assign or return a value of variable, for example:

  ```bash
      item.property name = "Jonas"
  ```

  Will set the variable `name` to _"Jonas"_, which is silly because Items are not named like this.

  You can also return the assigned value of the `name` variable with:

  ```bash
      item.property name
  ```

  With these two functionalities of the `property` function you can create getters and setters for class variables.

  ```bash
    item.name() {
      if [ "$1" == "=" ]
      then
          item.property name = "$2"
      else
          item.property name
      fi
    }
  ```

- **Header file**

  Now we have the class file, we want to also create different items, not just one, we can accomplish this with header file.

  ```header
    item(){
        . <(sed "s/item/$1/g" "$SRC_PATH/item.class")
    }
  ```

  This `item` function will take the first argument given to it, and using `<` and `sed` command will create a copy of the `item.class` file, but each word _item_ will be replaced by the given argument. Thus creating separate Item for us to use.

  In our bash script we can _source_ the header file, and use its `item` function to create new item, like so:

  ```bash
    . item.h

    item Sword

    Sword.name = "Excalibur"
    echo "$(Sword.name)"
  ```
