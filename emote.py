import random

# normal 0-2
# love 3-5
# surprise 6-8
# disappointment 9-11
# sad 12-14
# angry 15-17
emotions = ["'V'", ">v<", "◠‿◠", "¬‿¬✿", "◕ω◕✿", "｡♥‿♥｡", "☉_☉", "'o'", "⊙△⊙", "<_<", "¬_¬", "⌣_⌣”", "QvQ", "ಥ﹏ಥ", "╥﹏╥", "╬ Ò﹏Ó", "=_=", "⋋▂⋌"]
farewells = ["Bye", "Bye bye!", "Have a good day!", "See you soon!", "See ya!"]

# Emotions
def gen_random():
     
    return random.choice(emotions)

def gen_normal():

    return emotions[random.randint(0, 2)]
