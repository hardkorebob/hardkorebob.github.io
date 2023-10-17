#!/bin/bash
# Let this teach you a lesson
urls_txt="links.txt"
semi_finals_txt="sm.txt"
d="busted-dir"
e="imgs"
rm -rfv "$d"
mkdir -v "$d"
mkdir -v busted-dir/"$e"

for i in {1..12};do 
    echo 'https://bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/' | sed "s/$/$i/g"
done > "$d"/links.txt 
sed -i '0,/page\/1/s///' "$d"/links.txt # have to do it out side the loop???

while read -r url; do
    wget -P "$d" --level=1 --limit-rate=2000K --page-requisites --user-agent=Mozilla --no-parent --adjust-extension --no-clobber -e robots=off "$url" # url is a variable local to loop
done < "$d/$urls_txt"

mv -n busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/8.html busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/08.html
mv -n busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/6.html busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/06.html
mv -n busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/7.html busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/07.html
mv -n busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/2.html busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/02.html
mv -n busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/3.html busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/03.html
mv -n busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/5.html busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/05.html
mv -n busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/4.html busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/04.html
mv -n busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/9.html busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/page/09.html
mv -n busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/index.html busted-dir/bustednewspaper.com/mugshots/virginia/rappahannock-regional-jail/01.html

# Part 1

find "$d" | sort -n | grep -v "/page" | tail -1 > "$d"/x # first-link 01.html

find "$d" | sort -n | grep "/page/" >> "$d"/x # 02..50

for i in {1..12}; do echo "cat"; done > "$d"/c

paste -d ' ' "$d"/c "$d"/x > "$d"/b

bash "$d"/b | grep "read-more" > "$d"/z # charge-detail w/img link
cat "$d"/z | sed 's|<[^>]||g; s|href=|\n|g' | grep http | cut -d'"' -f2 > "$d"/sm.txt 
bash "$d"/b | grep "Read" > "$d"/p1

# Part 2

while read -r url; do
    wget -P busted-dir/imgs --level=1 --limit-rate=2000K --page-requisites --user-agent=Mozilla --no-parent  --adjust-extension --no-clobber -e robots=off "$url" # url is a variable local to loop
done < "$d/$semi_finals_txt"

find busted-dir/imgs/bustednewspaper.com | grep index | tr '/' ' ' |sort -k6r,6 |tr ' ' '/' | sed 's/^/cat /g' > "$d"/zz # sorts by date
#c="$(cat cc | wc -l)" # sub shell!!
# Part 3
cat "$d"/zz | bash | grep img | grep post-image > "$d"/p2
paste -d ' ' "$d"/p2 "$d"/p1 | sed 's|Booking |<br /><p> Booking|g' > "$d"/fi
cat .head "$d"/fi > "$d"/final.html 




