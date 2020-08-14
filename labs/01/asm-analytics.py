log_file = open("log", "r").read()
log_data = [
    line
    for line in log_file.splitlines()
    if line and not "Disassembly of section" in line
][1:]

func_d = dict()
inst_d = dict()
for line in log_data:
    if "\t" in line:
        inst = line.split("\t")[1]
        inst_d[inst] = inst_d.get(inst, 0) + 1
    else:
        address, func = line.split()
        func_d[func.replace("_","").replace(":","")] = address


four_spaces = "    "
eight_spaces = four_spaces * 2
text = "Hi, this is the output of the analysis:\n"


text += four_spaces + "You have " + str(len(inst_d)) + " kind of instructions in this object file\n"
for inst, count in inst_d.items():
    text += "{0}{1}\t: Executed {2} times\n".format(eight_spaces, inst, count)

text += four_spaces + "You have " + str(len(func_d)) + "functions\n"
for func, add in func_d.items():
    text += "{0}{1}\t: Located at {2} addr\n".format(eight_spaces, func, add)


print(text)
