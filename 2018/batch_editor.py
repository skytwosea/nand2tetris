# import re
# from __future__ import nested_scopes
import re


def searchandreplace():

    file = "./projects/03/incomplete/a/RAM8.hdl"  # input("filename:")
    editfile = file + ".edit"
    editstring = re.compile(r"^    PARTS:$")
    editpart = re.compile(r"\[16\]")
    linecount = 16  # int(input("numsber of lines to edit: "))
    edit_flag = 0
    value_counter = 0


    with open(file, "r") as f, open(editfile, "w") as e:

        # adict = {"editpartA": f"[{str(value_counter)}]",
        #          "editpartB": f"[{str(value_counter-1)}]"}

        # def multireplace(adict, text):
        #     reg = re.compile("|".join(map(re.escape, adict.keys())))
        #     return reg.sub(lambda match: adict[match.group(0)], text)

        for line in f:

            if edit_flag == 0:
                if re.search(editstring, line):
                    edit_flag = 1
                    print(f"::EDIT_FLAG TIED HIGH ON LINE {line}")
                e.write(line)
                continue

            elif edit_flag == 1:
                newline = re.sub(editpart, f"[0..15]", line)
                # newline = multireplace(adict, line)
                print("CHNG: ", newline.strip())
                e.write(newline)
                value_counter += 1
                if value_counter == linecount:
                    print(f"{value_counter} lines changed.")
                    edit_flag = 0


if __name__ == '__main__':
    searchandreplace()
