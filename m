Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94240753E32
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbjGNO4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbjGNOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:55:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAEC30FC;
        Fri, 14 Jul 2023 07:55:37 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.15]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MDgxt-1qCs4B330p-00Aqpq; Fri, 14 Jul 2023 16:54:52 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 1C8F13E8B6; Fri, 14 Jul 2023 16:54:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1689346489; bh=9SBx+6DitAvBfqKdQ3mIQDbBGQuj0uRqTboPv0OMpb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N1xryw6UYWfAsC7ggiLVWbAuteSX/ud0dZ5CQJNALGCibjQpQowDMGH0jdtC9GCS0
         ewOIF1nRD/E5P3FJPf3fCpLOJcGSbKOHs7dXzFYjGEqbIBEL1NpxgeHkQES2USXDeU
         r4S6ug3IJDcmiE2Xm0hamE4JjOEhJ1Fk1JWEzsww=
Date:   Fri, 14 Jul 2023 16:54:49 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Michal =?utf-8?Q?Such=EF=BF=BDnek?= <msuchanek@suse.de>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?utf-8?B?S291dG7vv70=?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] depmod: Handle installing modules under a prefix
Message-ID: <ZLFhuf95srX2wvJc@fjasle.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mfoKlNUZR6w/MbrO"
Content-Disposition: inline
In-Reply-To: <20230714143002.GL9196@kitsune.suse.cz>
X-Provags-ID: V03:K1:M0zQXyytWpq15DFeDxHX9TI4m9bUGxU3J6PM1EjSsos/hDxTXOH
 PkhEZLg7pZT2Qc+sZB9N4N33+2viHKGKPYuzj647HfMfFiP8KlVIRKZbmou6v03wAnpMJDR
 DzFN6l4w1IGuXI98y0tl/oeyCZxpHjfz4/0/xIVXt580QK23xEOZ0F9I+HUPQE1Q0sWJJqE
 cBOmgfLJFHk2xB2eEwOVw==
UI-OutboundReport: notjunk:1;M01:P0:y4Dx1EyoPzI=;wbSEiaVjDihK96Ytv+cFxJMvb3K
 xuO7D7hx6vwO7THuHA7RgpZJDdlfpHk8+7KvcfFgUpml+l721XTIu8b4nNbNQEZXMqbWuJZfE
 fUYqIoaXfMYx5gUIaJhGtCuWg56GiXML3G6e8/2qAhqomHRMoDZW0LV/t6L1M2c7f9h9EZEf0
 4KS/RhhYH/8fIgr4BcBFnG9TZiSB8qWBmiwh7HX4khzYh1N10wVZWM1TszhebJ8Qs2YB+y24C
 2IcqfKay7RONMOX9tGNkqofi8bNcnFeJGX4A+C0AMz2MsnPD5TjHuX6fWSo726bq8pS+2hLa1
 6XjtMzEchwxk0U8mvjrdOkqS9KYwZE/vQdQ2ZYex5Y4a92GPmGCDTDHycOHEhtCDbdNNfvqqv
 swVODOmTTN9yRIV+6g2XP/98iI3feP0JpfwQP3DkhIhyMbABAH4j+1BNZeWePe1yRLux8+0eR
 7nos/Rc3pEoMXR2kQXVCu/Q4nM4AntTFpZogfnwE5kXn7tX9PWHnLrZxkA4oevf5pOt88Utqi
 zX9HdxwMDvsJedNWBvvy7nJ2C19muIDsuPYu2a8vrT02ORAbSK9SunsvcA1AhFsKtYaC7498s
 cT/ZoPY5q43030gO7ZqGmh/oLmNCyCx8uWFlagyl5sD0TgL7ApSfhBI3gmFlzpkWsCawS+eIo
 I8jJMYlcA4p0Vgxr66oKurJXtIa11FCw0Pmbhc39BA==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mfoKlNUZR6w/MbrO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 04:30:02PM +0200, Michal Such=EF=BF=BDnek wrote:
> Hello,
>=20
> On Fri, Jul 14, 2023 at 04:05:10PM +0200, Nicolas Schier wrote:
> > On Fri, Jul 14, 2023 at 02:21:08PM +0200 Michal Suchanek wrote:
> > > Some distributions aim at not shipping any files in / outside of usr.
> >=20
> > For me, preventing negation often makes things easier, e.g.: "... aim at
> > shipping files only below /usr".
> >=20
> > >=20
> > > The path under which kernel modules are installed is hardcoded to /lib
> > > which conflicts with this goal.
> > >=20
> > > When kmod provides the config command, use it to determine the correct
> > > module installation prefix.
> > >=20
> > > This is a prefix under which the modules are searched by kmod on the
> > > system, and is separate from the temporary staging location already
> > > supported by INSTALL_MOD_PATH.
> > >=20
> > > With kmod that does not provide the config command empty prefix is us=
ed
> > > as before.
> > >=20
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > > v2: Avoid error on systems with kmod that does not support config
> > > command
> > > v3: More verbose commit message
> > > ---
> > >  Makefile          | 4 +++-
> > >  scripts/depmod.sh | 8 ++++----
> > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/Makefile b/Makefile
> > > index 47690c28456a..b1fea135bdec 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?=3D $(INSTALL_PATH)/d=
tbs/$(KERNELRELEASE)
> > >  # makefile but the argument can be passed to make if needed.
> > >  #
> > > =20
> > > -MODLIB	=3D $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> > > +export KERNEL_MODULE_PREFIX :=3D $(shell kmod config &> /dev/null &&=
 kmod config | jq -r .module_prefix)
> >=20
> > All other calls of `jq` that I could find are located at tools/; as thi=
s here
> > is evaluated on each invocation, this should probably be documented in
> > Documentation/process/changes.rst?
> >=20
> > (Absence of `jq` will cause error messages, even with CONFIG_MODULES=3D=
n.)
>=20
> That's a good point.
>=20
> >=20
> > > +
> > > +MODLIB	=3D $(INSTALL_MOD_PATH)$(KERNEL_MODULE_PREFIX)/lib/modules/$(=
KERNELRELEASE)
> > >  export MODLIB
> > > =20
> > >  PHONY +=3D prepare0
> > > diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> > > index 3643b4f896ed..88ac79056153 100755
> > > --- a/scripts/depmod.sh
> > > +++ b/scripts/depmod.sh
> > > @@ -27,16 +27,16 @@ fi
> > >  # numbers, so we cheat with a symlink here
> > >  depmod_hack_needed=3Dtrue
> > >  tmp_dir=3D$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
> > > -mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
> > > +mkdir -p "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE"
> > >  if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
> > > -	if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
> > > -		-e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
> > > +	if test -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEAS=
E/modules.dep" -o \
> > > +		-e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/modul=
es.dep.bin"; then
> > >  		depmod_hack_needed=3Dfalse
> > >  	fi
> > >  fi
> >=20
> > I'd like to come back to the statement from Masahiro: Is the check abov=
e,
> > against some very old versions of depmod [1], the only reason for this =
patch? =20
> >=20
> > If we could remove that, would
> >=20
> >     make INSTALL_MOD_PATH=3D"$(kmod config | jq -r .module_prefix)" mod=
ules_install
> >=20
> > be sufficient?
>=20
> No, the INSTALL_MOD_PATH is passed as the -b argument to depmod while
> the newly added part is not because it's integral part of where the
> modules are installed on the system, and not the staging area path.

Ah, thanks.  So just for my understanding, could this be a (non-gentle)
alternative version of your patch, w/o modifying top-level Makefile?

diff --git a/scripts/depmod.sh b/scripts/depmod.sh
index 3643b4f896ed..72c819de0669 100755
--- a/scripts/depmod.sh
+++ b/scripts/depmod.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 #
 # A depmod wrapper used by the toplevel Makefile
@@ -23,6 +23,8 @@ if [ -z $(command -v $DEPMOD) ]; then
        exit 0
 fi
=20
+kmod_version=3D$(( $(kmod --version | sed -rne 's/^kmod version ([0-9]+).*=
$/\1/p') ))
+
 # older versions of depmod require the version string to start with three
 # numbers, so we cheat with a symlink here
 depmod_hack_needed=3Dtrue
@@ -35,6 +37,13 @@ if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; t=
hen
        fi
 fi
 rm -rf "$tmp_dir"
+
+if [ "${kmod_version}" -gt 32 ]; then
+       kmod_prefix=3D"$(kmod config | jq -r .module_prefix)"
+       INSTALL_MOD_PATH=3D"${INSTALL_MOD_PATH#${kmod_prefix}"
+       depmod_hack_needed=3Dfalse
+fi
+
 if $depmod_hack_needed; then
        symlink=3D"$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
        ln -s "$KERNELRELEASE" "$symlink"

(untested, and assuming that kmod module prefix is in kmod >=3D 32)

Or are I am still missing something?

> Was busybox ever fixed to not require the hack?

I haven't checked that, yet.

Kind regards,
Nicolas

--mfoKlNUZR6w/MbrO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmSxYbgACgkQB1IKcBYm
Emky/w/8CMs2Qbg7YBCBb4Nw/bnCSKtD7J/at2AHkgRV/X5t8r7pXJ19UMbdahjK
zbBSj6VNhrhTGa/xXlrTYNpT/dCAMOw7FGy0eridQ9y0eHuc4HDyl2L+iy1p7+JF
rmg0Zd1wYZ1AirukHNdfc0aerlFSzLJd6ilnhh6+O3+v8rkcUF2rT0SgqhP78GMW
ujqqj7DTcRCVUN1xqcUhw/veUxh96jp0at76mIlOGs/mSaja8201SPfyqQ+9CiUX
yWpZCmdpf3IFXDLzg4TNPfasTDDLIBHIs+cGpqSpQRhN+gwowTy2EHJ75QjfLZvy
R8mg4CHQVxklDUSFXmywfi/eQ0Eu8Vim2yhH1d8/JupUKcu6ZoiertbfAv85nUPK
AOZ5Bb7XdTRCjp7FYcG78vVkf/VIyA+ukuWtGputWk5ckEimBOdOZqLG4D1aJYQz
KPRlIkqtcg9X9bMCCPizCuuTZPAUXXWGuw5R9bgVdzGRRV6S+0mH0/5zaa4/MWlM
mlVM1nzJ0lEbxtNhwOmpOFkNm1jkXo56GRyzG/FK1IipY9UL6w9swMKzNqhOjRpa
UrakFJHnk60nutQ+OWeZjHZ6x7qFV+j6hCRGXC/HHbnO4bijSydqMMQrHmL+8okh
ePCvY91QlTt2oMXBb4l5oxQXxgkJu9qRYVoJb6pbabwbLFYnito=
=UB7N
-----END PGP SIGNATURE-----

--mfoKlNUZR6w/MbrO--
