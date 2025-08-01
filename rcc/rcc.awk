#!/bin/awk -f

BEGIN {
    
	nlines = 0 # Code buffer
	openblk = 0
	currentfunc = ""    
	currentdir = "."     
	rootdir = "."

	print "\n\n████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒\n"
	print "λ (-(-_-(-_(-_(-_-)_-)-_-)_-)_-)-) ❤ [¬º-°]¬ ✧ Σ = 0\n\n"
    
	# Main
	while (1) {
        if (currentfunc != "")
            printf "⊹╰(⌣ʟ⌣)╯⊹ [%s] Σ ", currentfunc
        else
            printf "⊹╰(⌣ʟ⌣)╯⊹ Σ "
        
        if ((getline choice < "/dev/stdin") <= 0)
            break
            
        if (choice ~ /^[0-9]+$/) {
            num = int(choice)

            if (num == 1) incr()
			else if (num == "0") startnew() 
            else if (num == 2) decr()
            else if (num == 3) peq()
            else if (num == 4) meq()
            else print "\nλ (-(-_-(-_(-_(-_-)_-)-_-)_-)_-)-) [¬º-°]¬ ✧\n"
        }
		else if (choice == "R") shcmd()
		else if (choice == "s") fnc()
		else if (choice == "i") inc()
		else if (choice == "I") def()
		else if (choice == "x") dcl()
		else if (choice == "v") var()
		else if (choice == "a") fun()
		else if (choice == "f") fol()
		else if (choice == "F") fov()
		else if (choice == "W") whl()
		else if (choice == "c") closeblock()
		else if (choice == "q") ifc()
		else if (choice == "w") iff()
		else if (choice == "e") els()
		else if (choice == "r") elf()
		else if (choice == "y") swc()
		else if (choice == "h") cas()
		else if (choice == "n") dft()
		else if (choice == "t") ret()
		else if (choice == "u") arr()
		else if (choice == ";") strc()
		else if (choice == "p") pro()
		else if (choice == "m") stst()
		else if (choice == "j") typ()
		else if (choice == "d") vaf()
		else if (choice == "o") enu()
		else if (choice == "G") brkk()
		else if (choice == "g") loop()
		else if (choice == "-") rmline()
		else if (choice == "_") rmall()
		else if (choice == "B") buildit()
		else if (choice == "?") printmenu()
		else if (choice == "O") opencode()
		else if (choice == "V") viewcode()
		else if (choice == "S") savecode()
		else if (choice == "E") editlast()
		else if (choice == "L") listfuncs()
		else if (choice == "X") exitfunction()
		else if (choice == "T") projecttree()
		else if (choice == "vf") viewfunc()
		else if (choice == "A") goodbye()
 		else if (choice == ":)") yay()
        else print "\nλ ┌П┐ »»»»»»─=≡ΣO)) [¬º-°]¬ ✧\n"
    }
}




function startnew(dir) {
	dir = promptstr("\nλ [¬º-°]¬ Name ye creation: ")
	if (dir == "") return
	rootdir = dir
    system("mkdir -p " rootdir "/functions")
    system("mkdir -p " rootdir "/includes") 
    system("mkdir -p " rootdir "/globals")
    currentdir = rootdir
	print "\nλ ❤ ♪♬\n"
	system("troll")
}

function yay() {
	print "\nλ ❤ ※\(^o^)/※ ❤ λ\n"
}

function goodbye() {
	print "\n✧ Adios... [¬º-°]¬ (-_-) (•_•) ( •_•)>⌐■-■ (⌐■_■) λ\n"
	exit
}

function printmenu() {
    print "\n o()xxxx[{::::::::::::::::::>\n"
	print " 0 new	1 ++"
	print " 2 -- 	3 += 	4 -="
	print " c } 	--line 	_ cls"
	print " s fnc	a fun	d vaf"
	print " x dcl	v var	t ret"
	print " f fol	F fov 	G brk"
	print " W whl	q ifc	w iff"
	print " e els	r elf	g inf"
	print " y swc	h cas	n dft"
	print " u arr	i inc	I def"
	print " p pro	m stst	j typ"
	print " o enu	; strc 	? menu\n"
    print " »»\n T  Tree\n L  List()\n X  Exit()\n vf View()\n"
	print " »\n B Build\n R Shell\n A Adios\n V View\n O Open\n S Save"

	print "\n███████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒\n"
}

function editlast(newline, oldline) {
    if (nlines == 0) {
        print "\nλ nil ✧\n"
        return
    }
    
    oldline = lines[nlines-1]
    print "\nλ Current line: " oldline
    
    newline = promptstr("\nλ Edit to: ")
    
    if (newline == "") {
        print "\nλ Edit cancelled ✧\n"
        return
    }
    
    lines[nlines-1] = newline
    print "\nλ Line updated ☜\n"
}

function viewcode(tmp, i) {
	tmp = rootdir"/program.c.tmp"
	print "Current project: " rootdir
    print "\n♪♬♪"
    for (i = 0; i < nlines; i++)
        print lines[i] > tmp
	close(tmp)
	system("cat " tmp ">[2] /dev/null|cb; rm " tmp ">[2] /dev/null")
    print "▲▲\n"
}

function savecode(filename, i) {
    filename = rootdir"/program.c"
    for (i = 0; i < nlines; i++)
        print lines[i] > filename
	print "\n" >> filename
    close(filename)
    print "\nλ Code saved: '" filename "'☜\n"
}

function shcmd() {
    cmd = promptstr("\nλ rc% ")
	system(cmd)
}

function buildit(name) {
	name = promptstr("\nλ Building: ")
    print "\nλ ████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒\n"
	cmdc = "6c -FTVw "
	cmdl = "6l -o "
	system(cmdc rootdir"/"name".c")
	system(cmdl "6."name" "name".6")
	print "\nλ ██████████████████████████████\n"
	yay() 

}

function opencode(fname, pname) {
	pname = promptstr("\nλ Project: ")
	if ( pname == "" ) { 
		print "\nλ Nombre projecto? ✧" 
		return
	}
	openblk = 0
	rootdir = pname
	fname = pname"/program.c"
	rmall()
	printf "\nλ ++%s ☜\n\n", pname
    print "\n♪♬♪"
	system("cat " fname "|cb")
    print "▲▲\n"
	while (( getline < fname ) > 0) {
		lines[nlines++] = $0
	}
	close(fname)
}

function addline(line) {
    lines[nlines++] = line
}

function rmline(line) {
    lines[nlines--] = line
	print "\nλ --line ☜\n"
}

function rmall(i,f) {
    for (i in lines)
		delete lines[i]
	nlines = 0
	print "\nλ --*lines ☜\n"
}

function promptstr(prompt, input) {
    printf "%s", prompt
    if ((getline input < "/dev/stdin") > 0)
        return input
    return ""
}

function viewfunc(name) {
    if (currentfunc == "") 
        name = promptstr("\nλ View function: ")
        if (name == "") return
    else 
        name = currentfunc
    funcdir = rootdir "/functions/" name
    system("for(f in `{walk -f " funcdir "}){ echo '  '$f; sed 5q $f; echo }")

}

function sendline(filepath, line) {
    print line >> filepath
    close(filepath)
}

function enterfunction(name) {
    currentfunc = name
    currentdir = rootdir "/functions/" name
}

function exitfunction() {
    if (currentfunc == "") {
        print "\nλ nil No funciona ✧\n"
        return
    }
    currentfunc = ""
    currentdir = rootdir
    print "\nλ [] Exited function ☜\n"
}

function listfuncs() {
    print "\nλ Functions in project:\n"
    system("ls " rootdir "/functions")
    print ""
}


function projecttree() {
    print "\nλ Project structure:\n"
    system("walk " rootdir " | sort")
}


# RCC functions
function inc(header) {
	while (1) {
    	header = promptstr("\nλ Header: ")
		if (header == "") break

    	if (header != "") 
        	addline(sprintf("#include <%s.h>", header))
            sendline(rootdir "/includes.h", sprintf("#include <%s.h>", header))
        
	}
}

function def(name, value) {
	while (1) {
    	name = promptstr("\nλ Define name: ")
		if (name == "") break
    	value = promptstr("\nλ Define value: ")
    	if (name != "" && value != "") {
        	addline(sprintf("#define %s %s", name, value))
            sendline(rootdir "/defines.h", sprintf("#define %s %s", name, value))
        }
	}
}
function dcl(type, name) {
	while (1) {
    	type = promptstr("\nλ Declare type: ")
		if (type == "") break
    	name = promptstr("\nλ Declare name: ")
    	if (type != "" && name != "") {
        	addline(sprintf("%s %s;", type, name))
            sendline(rootdir "/globals/declarations.c", sprintf("%s %s;", type, name))
        }
	}
}

function pro(type, name) {
	while (1) {
    	type = promptstr("\nλ Proto type: ")
		if (type == "") break
    	name = promptstr("\nλ Func name: ")
    	args = promptstr("\nλ Args name: ")
    	if (type != "" && name != "" && args !="") {
        	addline(sprintf("%s %s(%s);", type, name, args))
            sendline(rootdir "/prototypes.h", sprintf("%s %s(%s);", type, name, args))
        }
	}
}

function fnc(type, name) {
	while (1) {
    	name = promptstr("\nλ Function name: ")
		if (name == "") break
    	args = promptstr("\nλ Arguments: ")
    	if (args == "") {
        	addline(sprintf("%s();", name))
            if (currentfunc != "")
                sendline(currentdir "/body.c", sprintf("%s();", name))
        } else if (args != "") {
			addline(sprintf("%s(%s);", name, args))
            if (currentfunc != "")
                sendline(currentdir "/body.c", sprintf("%s(%s);", name, args))
        }
	}
}

function var(name, value, type) {
	while (1) {
		type = promptstr("\nλ Variable type: ")
    	name = promptstr("\nλ Variable name: ")
		if (name == "") break
    	value = promptstr("\nλ Initial value: ")
    	
        if (type == "") {
			addline(sprintf("%s = %s;", name, value))
            if (currentfunc != "")
                sendline(currentdir "/vars.c", sprintf("%s = %s;", name, value))
            else
                sendline(rootdir "/globals/vars.c", sprintf("%s = %s;", name, value))
        } else {
        	addline(sprintf("%s %s = %s;", type, name, value))
            if (currentfunc != "")
                sendline(currentdir "/vars.c", sprintf("%s %s = %s;", type, name, value))
            else
                sendline(rootdir "/globals/vars.c", sprintf("%s %s = %s;", type, name, value))
        }
	}
}

function fun(name, rtype, args) {
    name = promptstr("\nλ Function name: ")
    rtype = promptstr("\nλ Return type: ")
    args = promptstr("\nλ Arguments: ")
    
    if (name != "" && rtype != "") {
        funcdir = rootdir "/functions/" name
        system("mkdir -p " funcdir)
        
        addline(sprintf("%s", rtype))
        addline(sprintf("%s(%s)\n{", name, args))
        sendline(funcdir "/signature.c", rtype)
        sendline(funcdir "/signature.c", sprintf("%s(%s)", name, args))
        sendline(funcdir "/signature.c", "{")
        
        system("touch " funcdir "/vars.c")
        system("touch " funcdir "/body.c")
        
        enterfunction(name)
        
        print "\nλ " name " ▽ {\n"
		openblk++
    }
}

function fol(type, iter, start, end) {
    type = promptstr("\nλ Iterator type: ")
    iter = promptstr("\nλ Iterator name: ")
	if (iter == "") return
    start = promptstr("\nλ Start value: ")
    end = promptstr("\nλ End value (exclusive): ")
    if (type != "" && iter != "" && start != "" && end != "") {
        addline(sprintf("for(%s %s = %s; %s < %s; %s++)\n{", type, iter, start, iter, end, iter))
		openblk++
		print "\nλ ▽ {\n"
        if (currentfunc != "")
            sendline(currentdir "/body.c", sprintf("for(%s %s = %s; %s < %s; %s++)\n{", type, iter, start, iter, end, iter))
    }
}

function fov(type, iter, start, end) {
    type = promptstr("\nλ Iterator type: ")
    iter = promptstr("\nλ Iterator name: ")
    start = promptstr("\nλ Start value: ")
    end = promptstr("\nλ End value (inclusive): ")
    if (type != "" && iter != "" && start != "" && end != "") {
        addline(sprintf("for(%s %s = %s; %s >= %s; %s--)\n{", type, iter, start, iter, end, iter))
		print "\nλ ▽ {\n"
		openblk++
        if (currentfunc != "")
            sendline(currentdir "/body.c", sprintf("for(%s %s = %s; %s >= %s; %s--)\n{", type, iter, start, iter, end, iter))
    }
}

function iff(cond, stmt) {
    cond = promptstr("\nλ If ; condition: ")
    stmt = promptstr("\nλ Statement: ")
    if (cond != "" && stmt != "") {
        addline(sprintf("if(%s) %s;", cond, stmt))
        if (currentfunc != "")
            sendline(currentdir "/body.c", sprintf("if(%s) %s;", cond, stmt))
    }
}

function whl(cond) {
    cond = promptstr("\nλ While condition: ")
    if (cond != "") 
        addline(sprintf("while(%s)\n{", cond))
		print "\nλ ▽ {\n"
		openblk++
        if (currentfunc != "")
            sendline(currentdir "/body.c", sprintf("while(%s)\n{", cond))   


}

function loop() {
    addline("for(;;)\n{")
    if (currentfunc != "") {
        sendline(currentdir "/body.c", "for(;;)")
        sendline(currentdir "/body.c", "{")
    }
	print "\nλ Infinite Loop ▽ {\n"
	openblk++
}


function ifc(cond) {
    cond = promptstr("\nλ If {} condition: ")
	if (cond == "") return
    if (cond != "") {
        addline(sprintf("if(%s) {", cond))
		print "\nλ ▽ {\n"
		openblk++
        if (currentfunc != "")
            sendline(currentdir "/body.c", sprintf("if(%s) {", cond))
    }


}

function els() {
    addline("} else {")
	print "\nλ ▲ ▽ {\n"
    if (currentfunc != "")
        sendline(currentdir "/body.c", "} else {")
}

function elf(cond) {
    cond = promptstr("\nλ Elif condition: ")
    if (cond != "") {
        addline(sprintf("} else if(%s) {", cond))
		print "\nλ ▲ ▽ {\n"
        if (currentfunc != "")
            sendline(currentdir "/body.c", sprintf("} else if(%s) {", cond))
    }
}

function swc(expr) {
    expr = promptstr("\nλ Switch expression: ")
    if (expr != "") {
        addline(sprintf("switch(%s) {", expr))
		print "\nλ ▽ {\n"
		openblk++
        if (currentfunc != "")
            sendline(currentdir "/body.c", sprintf("switch(%s) {", expr))
    }
}

function cas(value) {
    value = promptstr("\nλ Case value: ")
    if (value != "") {
        addline(sprintf("case %s:", value))
        if (currentfunc != "")
            sendline(currentdir "/body.c", sprintf("case %s:", value))
    }
}

function dft() {
    addline("default:")
    if (currentfunc != "")
        sendline(currentdir "/body.c", "default:")
}

function ret(value) {
    value = promptstr("\nλ Return value: ")
    if (value != "") {
        addline(sprintf("return %s;", value))
        if (currentfunc != "")
            sendline(currentdir "/body.c", sprintf("return %s;", value))
    } else {
        addline("return;")
        if (currentfunc != "")
            sendline(currentdir "/body.c", "return;")
    }
}

function arr(type, name, vals) {
    type = promptstr("\nλ Array type: ")
    name = promptstr("\nλ Array name: ")
    vals = promptstr("\nλ Initial values: ")
    if (type != "" && name != "" && vals != "") {
        addline(sprintf("%s %s[] = {%s};", type, name, vals))
        if (currentfunc != "")
            sendline(currentdir "/vars.c", sprintf("%s %s[] = {%s};", type, name, vals))
        else
            sendline(rootdir "/globals/vars.c", sprintf("%s %s[] = {%s};", type, name, vals))
    }
}

function strc(name, field, fname) {
    name = promptstr("\nλ Struct name: ")
    if (name == "") return
    
    addline("typedef struct\n{")
    sendline(rootdir "/globals/structs.c", "typedef struct")
    sendline(rootdir "/globals/structs.c", "{")
    
    while (1) {
        field = promptstr("\nλ Field type: ")
        if (field == "") break
        
        fname = promptstr("\nλ Field name: ")
        if (fname == "") break
        
        addline(sprintf("    %s %s;", field, fname))
        sendline(rootdir "/globals/structs.c", sprintf("    %s %s;", field, fname))
    }
    
    addline(sprintf("} %s;", name))
    sendline(rootdir "/globals/structs.c", sprintf("} %s;", name))
}

function stst(type, name, field, value) {
    type = promptstr("\nλ Static struct type: ")
    name = promptstr("\nλ Variable name: ")
    if (type == "" || name == "") return
    
    addline(sprintf("static %s %s = {", type, name))
    if (currentfunc != "")
        sendline(currentdir "/vars.c", sprintf("static %s %s = {", type, name))
    else
        sendline(rootdir "/globals/vars.c", sprintf("static %s %s = {", type, name))
    
    while (1) {
        field = promptstr("\nλ Field name: ")
        if (field == "") break
        
        value = promptstr("\nλ Field value: ")
        if (value != "") {
        	addline(sprintf(".%s = %s,", field, value))
            if (currentfunc != "")
                sendline(currentdir "/vars.c", sprintf(".%s = %s,", field, value))
            else
                sendline(rootdir "/globals/vars.c", sprintf(".%s = %s,", field, value))
        } else {
        	addline(sprintf(".%s", field))
            if (currentfunc != "")
                sendline(currentdir "/vars.c", sprintf(".%s", field))
            else
                sendline(rootdir "/globals/vars.c", sprintf(".%s", field))
        }
    }
    
    addline("};")
    if (currentfunc != "")
        sendline(currentdir "/vars.c", "};")
    else
        sendline(rootdir "/globals/vars.c", "};")
}

function typ(type, name, field, value) {
    type = promptstr("\nλ Thing type: ")
    name = promptstr("\nλ Variable name: ")
    if (type == "" || name == "") return
    
    addline(sprintf("%s %s = {", type, name))
    if (currentfunc != "")
        sendline(currentdir "/vars.c", sprintf("%s %s = {", type, name))
    else
        sendline(rootdir "/globals/vars.c", sprintf("%s %s = {", type, name))
    
    while (1) {
        field = promptstr("\nλ Field name: ")
        if (field == "") break
        
        value = promptstr("\nλ Field value: ")
        if (value != "") {
        	addline(sprintf("%s = %s,", field, value))
            if (currentfunc != "")
                sendline(currentdir "/vars.c", sprintf("%s = %s,", field, value))
            else
                sendline(rootdir "/globals/vars.c", sprintf("%s = %s,", field, value))
        } else {
        	addline(sprintf("%s", field))
            if (currentfunc != "")
                sendline(currentdir "/vars.c", sprintf("%s", field))
            else
                sendline(rootdir "/globals/vars.c", sprintf("%s", field))
        }
    }
    
    addline("};")
    if (currentfunc != "")
        sendline(currentdir "/vars.c", "};")
    else
        sendline(rootdir "/globals/vars.c", "};")
}

function vaf(type, var, funcc, args) {
    type = promptstr("\nλ Variable type: ")
    var = promptstr("\nλ Variable name: ")
	if (var == "") return
    funcc = promptstr("\nλ Function name: ")
    args = promptstr("\nλ Function arguments: ")
    if (type == "") {
        addline(sprintf("%s = %s(%s);", var, funcc, args))
        if (currentfunc != "")
            sendline(currentdir "/body.c", sprintf("%s = %s(%s);", var, funcc, args))
    } else if (type != "" && var != "" && funcc != "" && args != "") {
        addline(sprintf("%s %s = %s(%s);", type, var, funcc, args))
        if (currentfunc != "")
            sendline(currentdir "/vars.c", sprintf("%s %s = %s(%s);", type, var, funcc, args))
        else
            sendline(rootdir "/globals/vars.c", sprintf("%s %s = %s(%s);", type, var, funcc, args))
    }
}

function enu(name, value) {
    addline("enum {")
    sendline(rootdir "/globals/enums.c", "enum {")
    
    while (1) {
        name = promptstr("\nλ Enumerator name: ")
        if (name == "") break
        
        value = promptstr("\nλ Enumerator value: ")
        if (value != "") {
            addline(sprintf("%s = %s,", name, value))
            sendline(rootdir "/globals/enums.c", sprintf("%s = %s,", name, value))
        } else {
            addline(sprintf("%s,", name))
            sendline(rootdir "/globals/enums.c", sprintf("%s,", name))
        }
    }
    
    addline("};")
    sendline(rootdir "/globals/enums.c", "};")
}

function peq(var, val) {
    var = promptstr("\nλ Variable name: ")
    val = promptstr("\nλ Value to add: ")
    if (var != "" && val != "") {
        addline(sprintf("%s += %s;", var, val))
        if (currentfunc != "")
            sendline(currentdir "/body.c", sprintf("%s += %s;", var, val))
    }
}

function meq(var, val) {
    var = promptstr("\nλ Variable name: ")
    val = promptstr("\nλ Value to subtract: ")
    if (var != "" && val != "") {
        addline(sprintf("%s -= %s;", var, val))
        if (currentfunc != "")
            sendline(currentdir "/body.c", sprintf("%s -= %s;", var, val))
    }
}

function incr(var) {
    var = promptstr("\nλ Increment Variable: ")
    if (var != "") {
        addline(sprintf("%s++;", var))
        if (currentfunc != "")
            sendline(currentdir "/body.c", sprintf("%s++;", var))
    }
}

function decr(var) {
    var = promptstr("\nλ Decrement Variable: ")
    if (var != "") {
        addline(sprintf("%s--;", var))
        if (currentfunc != "")
            sendline(currentdir "/body.c", sprintf("%s--;", var))
    }
}

function brkk() {
    addline("break;")
    if (currentfunc != "")
        sendline(currentdir "/body.c", "break;")
}

function closeblock(num, i, closeblk) {
	if (openblk != 0) {
		print "\nλ " openblk " { open ✔"
		num = promptstr("Close: ")
		if (num == "") return
        if (num ~ /^[0-9]+$/) {
            closeblk = int(num)
			for(i = 0; i < closeblk; i++) {
				printf "} ▲ "
				addline("}\n")
				openblk--
    			if (currentfunc != "")
        			sendline(currentdir "/body.c", "}\n")
			}
		}
			print "\n\nλ " num " { closed ☜\n"
	}
	else
		print "\nλ 0 { genius ✧\n"
		return
}
