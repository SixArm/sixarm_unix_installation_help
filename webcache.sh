# Create webcache of items we want to donwload to our local system.
#
# We use the directory ~/webcache, the curl program,
# and our own wget-mirror script which calls wget.

## Conf

top=~/webcache
mirror="wget --mirror -p --convert-links"

## Test for prereqs

cd $top || echo "Please mkdir $top" && exit 1
which curl 1>/dev/null || echo "Please install curl" && exit 2
which wget 1>/dev/null || echo "Please install wget" && exit 3


## Make directories

mkdir -p $top/{audio,books,calibre,fonts,movies,music,musicvideos,read,software,tv,videos}

# Country codes
mkdir -p $top/read/at/{af,al,dz,as,ad,ao,ai,aq,ag,ar,am,aw,au,at,az,bs,bh,bd,bb,by,be,bz,bj,bm,bt,bo,ba,bw,bv,br,io,bn,bg,bf,bi,kh,cm,ca,cv,ky,cf,td,cl,cn,cx,cc,co,km,cg,cd,ck,cr,ci,hr,cu,cy,cz,dk,dj,dm,do,ec,eg,sv,gq,er,ee,et,fk,fo,fj,fi,fr,gf,pf,tf,ga,gm,ge,de,gh,gi,gr,gl,gd,gp,gu,gt,gg,gn,gw,gy,ht,hm,va,hn,hk,hu,is,in,id,ir,iq,ie,im,il,it,jm,jp,jo,kz,ke,ki,kp,kr,kw,kg,la,lv,lb,ls,lr,ly,li,lt,lu,mo,mk,mg,mw,my,mv,ml,mt,mh,mq,mr,mu,yt,mx,fm,md,mc,me,mn,ms,ma,mz,mm,na,nr,np,nl,an,nc,nz,ni,ne,ng,nu,nf,mp,no,om,pk,pw,ps,pa,pg,py,pe,ph,pn,pl,pt,pr,qa,re,ro,ru,rw,sh,kn,lc,pm,vc,ws,sm,st,sa,sn,rs,cs,sc,sl,sg,sk,si,sb,so,za,gs,es,lk,sd,sr,sj,sz,se,ch,sy,tw,tj,tz,th,tl,tg,tk,to,tt,tn,tr,tm,tc,tv,ug,ua,ae,gb,us,um,uy,uz,vu,ve,vn,vg,vi,wf,eh,ye,zm,zw}

# US state codes
mkdir -p $top/read/at/us/{ak,al,ar,as,az,ca,co,ct,dc,de,fl,ga,gu,hi,ia,id,il,in,ks,ky,la,ma,md,me,mi,mn,mo,mp,ms,mt,nc,nd,ne,nh,nj,nm,nv,ny,oh,ok,or,pa,pr,ri,sc,sd,tn,tx,um,ut,va,vi,vt,wa,wi,wv,wy}

# Cities of interest
mkdir -p $top/read/at/{ca/{toronto,montreal,vancouver}},{uk/{london}},{us/{ca/{carmel,santaclara,santacruz,sandiego,sf,sanjose,la}},{ga/{athens,atlanta,savannah},{la/{neworleans}},{ma/{boston}},{mo/{saintlouis}},{ny/{nyc}},{vt/{brattleboro,burlington}}}

mkdir -p $top/{cooking,fun,ideas,notes,vendors}
mkdir -p $top/education/{adult,k12/{nclb},uni}
mkdir -p $top/business/{hr,it,marketing,pm,sales,startups}
mkdir -p $top/cs/{algorithms,c,databases,elixir,erlang,forth,fortran,go,graphs,java,perl,php,python,ruby}
mkdir -p $top/cs/ruby/{minitest,cucumber,mocha,rails,rspec}
mkdir -p $top/math/{logic}
mkdir -p $top/law/{hr,ip}
mkdir -p $top/philosophy/{analytic,continental}
mkdir -p $top/religion/{buddhism,christianity,judaism,hinduism,zen}
mkdir -p $top/science/{anthropology,biology,physics,sociology}

# Mutt email reader
mkdir -p $top/cs/mutt && cd $_ 
wget http://www.mutt.org/doc/manual.txt \
     http://www.mutt.org/doc/man_page.html \
     http://www.mutt.org/changes.html 

# Ruby
mkdir -p $top/cs/ruby && cd $_
curl -s http://www.ruby-doc.org/downloads/ruby_2_0_core_rdocs.tgz | tar zxf -
curl -s http://www.ruby-doc.org/downloads/ruby_2_0_stdlib_rdocs.tgz | tar zxf -
curl -s http://www.ruby-doc.org/downloads/learning-ruby.tar.gz | tar zxf -

# Ruby Mocha testing framework
mkdir -p $top/cs/ruby/mocha && cd $_ && 
$mirror docs http://gofreerange.com/mocha/docs/

# Ruby On Rails documentation
mkdir -p $top/cs/ruby/rails && cd $_ 
$mirror apidock http://apidock.com/rails/
$mirror guides http://guides.rubyonrails.org

# Ruby Minitest
mkdir -p $top/cs/ruby/minitest && cd $_ 
curl -s http://mattsears.com/articles/2011/12/10/minitest-quick-reference -o minitest-quick-reference-by-matt-sears.html
