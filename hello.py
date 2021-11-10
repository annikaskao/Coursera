# Annika Kao
# 5987847

def hello( name ):
    """ Given an input parameter called name
        Check if the name is empty
        If name is empty,
        then return "Hello, World!"
        If name is not empty,
        then retirn "Hello, <name>!"
    """
    if len(name) == 0:  #check if name is empty
        return("Hello, World!")
    else:   # the name is not empty
        return("Hello, "+ name + "!")
