Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E47754349
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbjGNThn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbjGNThl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:37:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5749F12D;
        Fri, 14 Jul 2023 12:37:33 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.15]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MbAxU-1pnGht47ZI-00bZ20; Fri, 14 Jul 2023 21:37:06 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 34E563E8B2; Fri, 14 Jul 2023 21:37:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1689363424; bh=DF9WMmGar+ZheiuKDUkhgAu8RFrRTM9vdhQ/1Hi/CSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uifja3/sGf7QObsPY4mLQAv3okoHesBhr4S4G60t/+sYuv6ePpDTdzKQHGCWdgBxq
         DjK2dlt+BQKO1hDvGQjO50NeVMNUUzcnie0e9WPKs2JhyHa9WdcjptpZfXO5p+EgvU
         yBXYdUlLMXA8EJ17Z1ibpGjR6HjB2iN+7AjEi+wI=
Date:   Fri, 14 Jul 2023 21:37:04 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?utf-8?B?S291dG7vv70=?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] depmod: Handle installing modules under a prefix
Message-ID: <ZLGj4Bl9bsQ1g1Cu@fjasle.eu>
References: <20230714143002.GL9196@kitsune.suse.cz>
 <ZLFhuf95srX2wvJc@fjasle.eu>
 <20230714151042.GN9196@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L+jXb+jvUuYTyyMG"
Content-Disposition: inline
In-Reply-To: <20230714151042.GN9196@kitsune.suse.cz>
X-Provags-ID: V03:K1:PLr6ysETAAx1E1Tul2BthhMdl8AzqLisIhRegFsU0DwlzgWZJPI
 CiAVjmD4VEhCtqtrdS5vP1S0FvB5paFgcDU6gM2xeNYWEP9T/qYueFV3aQ43haBr9wRdITC
 LJ+TzqSJon5y4JsLIDbN9FDVgB8ZvpQU/BcL+2CaQgQJvQgJDjNsvx/UHdWHK/ItM216Toj
 P17duA53NRp67JBh3rQug==
UI-OutboundReport: notjunk:1;M01:P0:W2fR4uCIL2o=;1TYlYO5a0ifoDfaITApVfSjL/E1
 kWCtxW7hOaEjeoxmh7JijLwrFs9uKvYbYvMNYG07Yztko490xRXdMp5Lmv91hS55dbAflOOrP
 fpfxTdSVGxESYvVkUp8yTrEwzhvPPSmnvRbj87L72cSWfG8wMGm4aItPpral3vuOuiMiPwAKn
 md37r8LxE90il8DvqxeEIp2XUsrJrmYa3jgF4LoUfoQ/YZGoFivWpZbdMcQU+pgf3+36XO/lz
 oFntRQc0oGaM1L5VSyt0VS3nvZU150dRIWQ8dHzRZ3C/O8HSpD0PfZ/tbObiroK12lOlKLTpe
 zExUbgrj3dkGKWpzmzFjyrcajTmCEPPDcyWkyAqAXvcSQjOp5KlRdPz1qXffqw//tyE3MBnvB
 b7LgIRLjQX+r6Qw8QkTB3WdXbNs2JUn1wirDnyqQJcodkjnziyAq1ayLyU1lyl5hjdkUHkELP
 Hi5oCVDBqx/9cx7qN+/0b1sDtEOafBMLJtYt1xdEZYrmte6GMepQj0dfuzri/a5QJcBdbeu7p
 NMINh9cVjtCMhWsthDU050MRzOUI3+JMffViI9vgWP0vg992fsSgc3fTXOWFGET9/XRoj56bL
 KcqznAxWnE9iSvTHXKwpwqv72hKxx5lnMAHTMaem5H6hNXvjvrjLLFW2u+9TI1QutZZJE/3s+
 pnA3wl7ZkFaJD5FMbNRM+ywb7o4kGuiO3DVaRHpV7w==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L+jXb+jvUuYTyyMG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 05:10:42PM +0200 Michal Such=C3=A1nek wrote:
> On Fri, Jul 14, 2023 at 04:54:49PM +0200, Nicolas Schier wrote:
> > On Fri, Jul 14, 2023 at 04:30:02PM +0200, Michal Such=EF=BF=BDnek wrote:
> > > Hello,
> > >=20
> > > On Fri, Jul 14, 2023 at 04:05:10PM +0200, Nicolas Schier wrote:
> > > > On Fri, Jul 14, 2023 at 02:21:08PM +0200 Michal Suchanek wrote:
> > > > > Some distributions aim at not shipping any files in / outside of =
usr.
> > > >=20
> > > > For me, preventing negation often makes things easier, e.g.: "... a=
im at
> > > > shipping files only below /usr".
> > > >=20
> > > > >=20
> > > > > The path under which kernel modules are installed is hardcoded to=
 /lib
> > > > > which conflicts with this goal.
> > > > >=20
> > > > > When kmod provides the config command, use it to determine the co=
rrect
> > > > > module installation prefix.
> > > > >=20
> > > > > This is a prefix under which the modules are searched by kmod on =
the
> > > > > system, and is separate from the temporary staging location alrea=
dy
> > > > > supported by INSTALL_MOD_PATH.
> > > > >=20
> > > > > With kmod that does not provide the config command empty prefix i=
s used
> > > > > as before.
> > > > >=20
> > > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > > ---
> > > > > v2: Avoid error on systems with kmod that does not support config
> > > > > command
> > > > > v3: More verbose commit message
> > > > > ---
> > > > >  Makefile          | 4 +++-
> > > > >  scripts/depmod.sh | 8 ++++----
> > > > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > > >=20
> > > > > diff --git a/Makefile b/Makefile
> > > > > index 47690c28456a..b1fea135bdec 100644
> > > > > --- a/Makefile
> > > > > +++ b/Makefile
> > > > > @@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?=3D $(INSTALL_PAT=
H)/dtbs/$(KERNELRELEASE)
> > > > >  # makefile but the argument can be passed to make if needed.
> > > > >  #
> > > > > =20
> > > > > -MODLIB	=3D $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> > > > > +export KERNEL_MODULE_PREFIX :=3D $(shell kmod config &> /dev/nul=
l && kmod config | jq -r .module_prefix)

oh, should this be 'jq -r .prefix' (w/o ".module") to match your other patc=
hes?

> > > >=20
> > > > All other calls of `jq` that I could find are located at tools/; as=
 this here
> > > > is evaluated on each invocation, this should probably be documented=
 in
> > > > Documentation/process/changes.rst?
> > > >=20
> > > > (Absence of `jq` will cause error messages, even with CONFIG_MODULE=
S=3Dn.)
> > >=20
> > > That's a good point.
> > >=20
> > > >=20
> > > > > +
> > > > > +MODLIB	=3D $(INSTALL_MOD_PATH)$(KERNEL_MODULE_PREFIX)/lib/module=
s/$(KERNELRELEASE)
> > > > >  export MODLIB
> > > > > =20
> > > > >  PHONY +=3D prepare0
> > > > > diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> > > > > index 3643b4f896ed..88ac79056153 100755
> > > > > --- a/scripts/depmod.sh
> > > > > +++ b/scripts/depmod.sh
> > > > > @@ -27,16 +27,16 @@ fi
> > > > >  # numbers, so we cheat with a symlink here
> > > > >  depmod_hack_needed=3Dtrue
> > > > >  tmp_dir=3D$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
> > > > > -mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
> > > > > +mkdir -p "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEA=
SE"
> > > > >  if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
> > > > > -	if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o=
 \
> > > > > -		-e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
> > > > > +	if test -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRE=
LEASE/modules.dep" -o \
> > > > > +		-e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/m=
odules.dep.bin"; then
> > > > >  		depmod_hack_needed=3Dfalse
> > > > >  	fi
> > > > >  fi
> > > >=20
> > > > I'd like to come back to the statement from Masahiro: Is the check =
above,
> > > > against some very old versions of depmod [1], the only reason for t=
his patch? =20
> > > >=20
> > > > If we could remove that, would
> > > >=20
> > > >     make INSTALL_MOD_PATH=3D"$(kmod config | jq -r .module_prefix)"=
 modules_install
> > > >=20
> > > > be sufficient?
> > >=20
> > > No, the INSTALL_MOD_PATH is passed as the -b argument to depmod while
> > > the newly added part is not because it's integral part of where the
> > > modules are installed on the system, and not the staging area path.
> >=20
> > Ah, thanks.  So just for my understanding, could this be a (non-gentle)
> > alternative version of your patch, w/o modifying top-level Makefile?
> >=20
> > diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> > index 3643b4f896ed..72c819de0669 100755
> > --- a/scripts/depmod.sh
> > +++ b/scripts/depmod.sh
> > @@ -1,4 +1,4 @@
> > -#!/bin/sh
> > +#!/bin/bash
> >  # SPDX-License-Identifier: GPL-2.0
> >  #
> >  # A depmod wrapper used by the toplevel Makefile
> > @@ -23,6 +23,8 @@ if [ -z $(command -v $DEPMOD) ]; then
> >         exit 0
> >  fi
> > =20
> > +kmod_version=3D$(( $(kmod --version | sed -rne 's/^kmod version ([0-9]=
+).*$/\1/p') ))
> > +
> >  # older versions of depmod require the version string to start with th=
ree
> >  # numbers, so we cheat with a symlink here
> >  depmod_hack_needed=3Dtrue
> > @@ -35,6 +37,13 @@ if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/nul=
l; then
> >         fi
> >  fi
> >  rm -rf "$tmp_dir"
> > +
> > +if [ "${kmod_version}" -gt 32 ]; then
> > +       kmod_prefix=3D"$(kmod config | jq -r .module_prefix)"
> > +       INSTALL_MOD_PATH=3D"${INSTALL_MOD_PATH#${kmod_prefix}"
> > +       depmod_hack_needed=3Dfalse
> > +fi
> > +
> >  if $depmod_hack_needed; then
> >         symlink=3D"$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
> >         ln -s "$KERNELRELEASE" "$symlink"
> >=20
> > (untested, and assuming that kmod module prefix is in kmod >=3D 32)
>=20
> It can be detected by running the 'kmod config' command first and
> ignoring the output when it fails which the above patch already did.
> The version check does not sound very reliable.
>=20
> > Or are I am still missing something?
>=20
> MODLIB still needs to include the extra prefix so that files are
> installed in the correct location. And that's defined in the toplevel
> Makefile.

Well, I think that depends.  Technically, you are right; and if we want
to support system with a non-empty kmod prefix fully transparently, then
patching top-level Makefile will probably be necessary. =20

As for me, I am not convinced yet, that the fully transparent way to support
PREFIX/lib/modules/ is the best way forward.  I think it might be better to
first only make script/depmod.sh fit for a kmod prefix and require an adjus=
ted
INSTALL_MOD_PATH for modules_install.

Which concrete distributions did you have in mind while composing the patch=
es?

Kind regards,
Nicolas

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--L+jXb+jvUuYTyyMG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmSxo98ACgkQB1IKcBYm
Emlpkg/+JcUVdKNUYJlHV067Obza1Wgl1sB1pcI4nNBRNsgmTZr9IdfrFhMKwHCu
25cpdlahUI6XGSBfgaePLhGTxpQh18tyaN8OzKeexiCbvTrNLIthzvOrANkq/nfH
P252+S9BJnaYoG25wcyDg+YjS7AGJO5t5jiWEwd7xpgsaM6wGcNPTLnUgQUbkDxq
tmX3ossREJXrksK6daTUhTFluPO3OOFpEBKSb0eMzc+pDIEtkEQaWN7H+c1/oyP5
R1JucOzT4x0W+u/dzIRNvvbsSM0PSNTZlOZ+NiimU+DNMNXJhX0e3K5aIlcJHFHZ
3jHsOpiHiLy9jdhdqMYEy/FZbhKX3lToOoC38YHz0yvmCSha7kljEJhFUNRB2pST
agoFSGPyF72OV+KnHze2qj9t/GA7GrMu+vL7vUjGi4FMb05sKE2wD9wIuYGjkJYz
TAdShc7xX4RqXa9ILbxrnXH/LZs7yCZV1JF7U8r0I21c2T86WYI9mBUVOm+5B61z
6pxI9LTBKOkl2G6WD0AwNfpFSwHOTgyL9Oo8Te6klOyJ9XtCdOB7DttZQrh+N4+q
nYguhSngwD0VKyoi1G76qtcAzaRlefMvsEchc8fLiLEgdCVJngGWnqwmuLvfj9/6
akMFn7gqlnEOKNmxWDUzEP1g4NxP36IlNrXp9sFxJQUnZc8hFuw=
=iKoe
-----END PGP SIGNATURE-----

--L+jXb+jvUuYTyyMG--
