# Objects

Like other languages, Python has objects. This chapter shows a brief example
of how you can implement some basic classes with inheritance.

```python
class Animal:
    """A organism in the kingdom Animalia."""

    def __init__(self):
        """Create a new animal."""
        self._is_alive = True

    def kill(self):
        """Make the animal not live anymore. Tragic. :("""
        self._is_alive = False

    @property
    def is_alive(self):
        """Return if the animal is alive.

        We don't want people to just be able to bring it back to life
        since that's not how nature works. So this makes the is_alive
        property be read-only.
        """

        return self._is_alive


class Dog(Animal):
    """A member of the genus Canis (canines)."""

    def __init__(self):
        """Create a new dog."""
        super().__init__()

    def bark(self, times=1):
        """Make the characteristic dog sound.

        This only works when the dog is alive. If it isn't, then
        nothing happens. Really this should throw a custom
        DeadDogException or something but w/e.
        """

        if self.is_alive:
            for i in range(0, times):
                print('Woof.')


class Cat(Animal):
    """Pets that are like dogs, but better."""

    def __init__(self, lives_remaining=9):
        """Create a new cat."""
        super().__init__()

        self.lives_remaining = lives_remaining

    def kill(self):
        """Risk the cat's life. It takes a bit to kill a cat."""
        self.lives_remaining -= 1

        if self.lives_remaining == 0:
            # Callthe original kill method for animals.
            super().kill()


# Let's make an orca.
shamu = Animal()

# It should be alive by default.
print(shamu.is_alive)  # True

# Note that we can't do this!
# shamu.is_alive = False

# Rip.
shamu.kill()

# We can also make a dog which can also die like other animals. But,
# dogs can also bark.
spot = Dog()

spot.bark()   # Bark once.
spot.bark(2)  # Bark twice.

# Cats are interesting since they override the default kill method.
cat = Cat()

cat.kill()

print(cat.is_alive)  # True

# Take out the other lives.
for i in range(0, 8):
    cat.kill()

print(cat.is_alive)  # False

# We can provide a number in the constructor for how many lives the
# Cat has. This one isn't as lucky.
cat_2 = Cat(1)

cat_2.kill()

print(cat.is_alive)  # False
```

Some things to note:

- `__init__` serves as the constructor for the class. You can accept parameters
  (including keyword arguments). Note that there can only be one constructor.
- A `self` argument is the first in each method (as well as `__init__`). Though
  `self` is not a keyword, this is a strong convention in the language. `self`
  contains the instance of the class that the method was called on.
- Multiple inheritance is a thing, but for simplicity we just have on here.
- No `new` keyword or the like is required for creating an instance.
- Use `TitleCase` for naming the class.
- Private members of a class should have names that start with an underscore by
  convention.
- Properties allow you to make a function that works like a variable.
  Properties can also have setters though that is not shown here.
- `super()` is a somewhat magic built-in function that returns the super-class.
- Defining the same method name on a sub-class shadows the super-class. Though
  it can still be accessed with `super()`.

> *Note*: A neat way to reason about why `self` is there, is to see a
> de-sugared way of calling methods. In the above, we could actually call the
> methods like this (though it is awkward):
>
> ```python
> fido = Dog()
> 
> Dog.bark(fido, 3)  # The dog will bark three times.
> Dog.kill(fido)     # Now fido can't bark anymore.
>
> Dog.bark(fido)  # Nothing happens. :/
> ```
>
> We can see more explicitly that the instance of `fido` is just being passed
> as the first argument!
