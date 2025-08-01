#!/bin/awk -f

BEGIN {
    # Code buffer
    nlines = 0
    
    print "\n████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒\n"
    
    # Main
    while (1) {
        printf "⊹╰(⌣ʟ⌣)╯⊹ Σ "
        
        if ((getline choice < "/dev/stdin") <= 0)
            break
            
        if (choice ~ /^[0-9]+$/) {
            num = int(choice)
            if (num == 1) incr()
            else if (num == 2) decr()
            else if (num == 3) peq()
            else if (num == 4) meq()
            else print "\nλ (-(-_-(-_(-_(-_-)_-)-_-)_-)_-)-)\n"
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
		else if (choice == "X") stt()
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
		else if (choice == "E") editlast()
		else if (choice == "B") buildit()
		else if (choice == "?") printmenu()
		else if (choice == "O") opencode()
        else if (choice == "V") viewcode()
        else if (choice == "S") savecode()
        else if (choice == "A") break
        else print "\nλ ┌П┐ »»»»»»─=≡ΣO)) [¬º-°]¬ ✧\n"
    }
}

function printmenu() {
    print "\no()xxxx[{::::::::::::::::::>\n"
	print " 1 ++ 	2 -- 	3 += 	4 -="
	print " c } 	--line 	_ cls"
	print " s fnc	a fun	d vaf"
	print " x dcl	v var	t ret"
	print " f fol	F fov 	G brk"
	print " W whl	q ifc	w iff"
	print " e els	r elf	g inf"
	print " y swc	h cas	n dft"
	print " u arr	i inc	I def"
	print " p pro	m stst	j typ"
	print " o enu	; strc 	? menu"
	print " »\n B Build\n R Shell\n A Adios\n V View\n O Open\n S Save\n\n███████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒\n"

}

function editlast(newline, oldline) {
    if (nlines == 0) {
        print "\nλ No lines to edit! ✧\n"
        print "\nλ ┌П┐ »»»»»»─=≡ΣO)) [¬º-°]¬ ✧\n"

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

function viewcode(i) {
    print "\n♪♬"
    for (i = 0; i < nlines; i++)
        print lines[i]
    print "▲▲\n"
}

function savecode(filename, i) {
    filename = promptstr("\nλ Output filename: ")
    if (filename == "") {
        print "\nλ Cannot be empty ✧\n"
        return
    }
    for (i = 0; i < nlines; i++)
        print lines[i] > filename
	print "\n" >> filename
    close(filename)
    system("cat " filename "|cb")
    print "\nλ Code saved: '" filename "'☜\n"
}

function shcmd() {
    cmd = promptstr("\nλ rc% ")
	system(cmd)
}

function buildit() {
	name = promptstr("\nλ Building: ")
    print "\nλ ████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒\n"
	cmdc = "6c -FTVw "
	cmdl = "6l -o "
	system(cmdc name".c")
	system(cmdl "6."name" "name".6")
    print "n\λ ██████████████████████████████ ❤\n" 
	 
}

function opencode(fname) {
	fname = promptstr("\nλ File: ")
	if ( fname == "" ) { 
		print "\nλ Enter file! ✧" 
		return
	}
	rmall()
	while (( getline < fname ) > 0) {
		lines[nlines++] = $0
	}
	close(fname)
	printf "\nλ ++%s ☜\n\n", fname
}

function addline(line) {
    lines[nlines++] = line
}

function rmline(line) {
    lines[nlines--] = line
	print "\nλ --line ☜\n"
}

function rmall() {
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

# RCC
function inc(header) {
	while (1) {
    	header = promptstr("\nλ Header: ")
		if (header == "") break

    	if (header != "")
        	addline(sprintf("#include <%s.h>", header))
	}
}

function def(name, value) {
	while (1) {
    	name = promptstr("\nλ Define name: ")
		if (name == "") break
    	value = promptstr("\nλ Define value: ")
    	if (name != "" && value != "")
        	addline(sprintf("#define %s %s", name, value))
	}
}

function dcl(type, name) {
	while (1) {
    	type = promptstr("\nλ Declare type: ")
		if (type == "") break
    	name = promptstr("\nλ Declare name: ")
    	if (type != "" && name != "")
        	addline(sprintf("%s %s;", type, name))
	}
}

function pro(type, name) {
	while (1) {
    	type = promptstr("\nλ Proto type: ")
		if (type == "") break
    	name = promptstr("\nλ Func name: ")
    	args = promptstr("\nλ Args name: ")
    	if (type != "" && name != "" && args !="")
        	addline(sprintf("%s %s(%s);", type, name, args))
	}
}

function fnc(type, name) {
	while (1) {
    	name = promptstr("\nλ Function name: ")
		if (name == "") break
    	args = promptstr("\nλ Arguments: ")
    	if (args == "")
        	addline(sprintf("%s();", name))
		else if (args != "")
			addline(sprintf("%s(%s);", name, args))
	}
}
function var(name, value) {
	while (1) {
		type = promptstr("\nλ Variable type: ")
    	name = promptstr("\nλ Variable name: ")
		if (name == "") break
    	value = promptstr("\nλ Initial value: ")
    	if (type == "")
			addline(sprintf("%s = %s;", name, value))

		else
        	addline(sprintf("%s %s = %s;", type, name, value))
	}
}

function fun(name, rtype, args) {
    name = promptstr("\nλ Function name: ")
    rtype = promptstr("\nλ Return type: ")
    args = promptstr("\nλ Arguments: ")
    if (name != "" && rtype != "" && args != "") {
        addline(sprintf("%s", rtype))
        addline(sprintf("%s(%s)", name, args))
        addline("{")
    }
	print "\nλ ▽\n"
}

function fol(type, iter, start, end) {
    type = promptstr("\nλ Iterator type: ")
    iter = promptstr("\nλ Iterator name: ")
	if (iter == "") return
    start = promptstr("\nλ Start value: ")
    end = promptstr("\nλ End value (exclusive): ")
    if (type != "" && iter != "" && start != "" && end != "")
        addline(sprintf("for(%s %s = %s; %s < %s; %s++) {", type, iter, start, iter, end, iter))
	print "\nλ ▽\n"
}

function fov(type, iter, start, end) {
    type = promptstr("\nλ Iterator type: ")
    iter = promptstr("\nλ Iterator name: ")
    start = promptstr("\nλ Start value: ")
    end = promptstr("\nλ End value (inclusive): ")
    if (type != "" && iter != "" && start != "" && end != "")
        addline(sprintf("for(%s %s = %s; %s >= %s; %s--) {", type, iter, start, iter, end, iter))
	print "\nλ ▽\n"
}

function whl(cond) {
    cond = promptstr("\nλ While condition: ")
    if (cond != "")
        addline(sprintf("while(%s)\n{", cond))
	print "\nλ ▽\n"
}

function loop() {
    addline("for(;;)\n{")
	print "\nλ Infinite Loop\n\nλ ▽\n"
}

function ifc(cond) {
    cond = promptstr("\nλ If condition: ")
    if (cond != "")
        addline(sprintf("if(%s) {", cond))
	print "\nλ ▽\n"
}

function iff(cond, stmt) {
    cond = promptstr("\nλ If condition: ")
    stmt = promptstr("\nλ Statement: ")
    if (cond != "" && stmt != "")
        addline(sprintf("if(%s) %s;", cond, stmt))
}

function els() {
    addline("} else {")
}

function elf(cond) {
    cond = promptstr("\nλ Elif condition: ")
    if (cond != "")
        addline(sprintf("} else if(%s) {", cond))
}

function swc(expr) {
    expr = promptstr("\nλ Switch expression: ")
    if (expr != "")
        addline(sprintf("switch(%s) {", expr))
}

function cas(value) {
    value = promptstr("\nλ Case value: ")
    if (value != "")
        addline(sprintf("case %s:", value))
}

function dft() {
    addline("default:")
}

function ret(value) {
    value = promptstr("\nλ Return value: ")
    if (value != "")
        addline(sprintf("return %s;", value))
    else
        addline("return;")
}

function arr(type, name, vals) {
    type = promptstr("\nλ Array type: ")
    name = promptstr("\nλ Array name: ")
    vals = promptstr("\nλ Initial values: ")
    if (type != "" && name != "" && vals != "")
        addline(sprintf("%s %s[] = {%s};", type, name, vals))
}

function strc(name, field, fname) {
    name = promptstr("\nλ Struct name: ")
    if (name == "") return
    
    addline("typedef struct\n{")
    
    while (1) {
        field = promptstr("\nλ Field type: ")
        if (field == "") break
        
        fname = promptstr("\nλ Field name: ")
        if (fname == "") break
        
        addline(sprintf("    %s %s;", field, fname))
    }
    
    addline(sprintf("} %s;", name))
}

function stst(type, name, field, value) {
    type = promptstr("\nλ Static struct type: ")
    name = promptstr("\nλ Variable name: ")
    if (type == "" || name == "") return
    
    addline(sprintf("static %s %s = {", type, name))
    
    while (1) {
        field = promptstr("\nλ Field name: ")
        if (field == "") break
        
        value = promptstr("\nλ Field value: ")
        if (value != "")
        	addline(sprintf(".%s = %s,", field, value))
		else
        	addline(sprintf(".%s", field))
    }
    
    addline("};")
}

function typ(type, name, field, value) {
    type = promptstr("\nλ Thing type: ")
    name = promptstr("\nλ Variable name: ")
    if (type == "" || name == "") return
    
    addline(sprintf("%s %s = {", type, name))
    
    while (1) {
        field = promptstr("\nλ Field name: ")
        if (field == "") break
        
        value = promptstr("\nλ Field value: ")
        if (value != "")
        	addline(sprintf("%s = %s,", field, value))
		else
        	addline(sprintf("%s", field))
    }
    
    addline("};")
}

function vaf(type, var, funcc, args) {
    type = promptstr("\nλ Variable type: ")
    var = promptstr("\nλ Variable name: ")
	if (var == "") return
    funcc = promptstr("\nλ Function name: ")
    args = promptstr("\nλ Function arguments: ")
    if (type == "")
        addline(sprintf("%s = %s(%s);", var, funcc, args))	
    else if (type != "" && var != "" && funcc != "" && args != "")
        addline(sprintf("%s %s = %s(%s);", type, var, funcc, args))
}

function enu(name, value) {
    addline("enum {")
    
    while (1) {
        name = promptstr("\nλ Enumerator name: ")
        if (name == "") break
        
        value = promptstr("\nλ Enumerator value: ")
        if (value != "")
            addline(sprintf("%s = %s,", name, value))
        else
            addline(sprintf("%s,", name))
    }
    
    addline("};")
}

function peq(var, val) {
    var = promptstr("\nλ Variable name: ")
    val = promptstr("\nλ Value to add: ")
    if (var != "" && val != "")
        addline(sprintf("%s += %s;", var, val))
}

function meq(var, val) {
    var = promptstr("\nλ Variable name: ")
    val = promptstr("\nλ Value to subtract: ")
    if (var != "" && val != "")
        addline(sprintf("%s -= %s;", var, val))
}

function incr(var) {
    var = promptstr("\nλ Increment Variable: ")
    if (var != "")
        addline(sprintf("%s++;", var))
}

function decr(var) {
    var = promptstr("\nλ Decrement Variable: ")
    if (var != "")
        addline(sprintf("%s--;", var))
}

function brkk() {
    addline("break;")
}

function closeblock() {
    addline("}")
	print "\nλ ▲\n"
}
