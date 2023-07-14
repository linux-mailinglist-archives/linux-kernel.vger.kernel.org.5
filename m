Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD757753C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjGNOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbjGNOFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:05:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CFB269F;
        Fri, 14 Jul 2023 07:05:36 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.15]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M6ltQ-1qJkNr2HC2-008HH2; Fri, 14 Jul 2023 16:05:13 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id A4B313E8BD; Fri, 14 Jul 2023 16:05:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1689343511; bh=An1J9X21u4J2HaOuofk3UHvgG0kCJKiC7ixO/xePTdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pr8yJhwzubQ23JNHC2/4HhLm8L7F3vngfMSJKuez4nWNNZf3MwCzE9Yba1yAhTPmI
         5eBWJef5AyQeWbCu0aVi+zOiSMwMLT/0OO7+1nJe3GzXYLSYCHm2KeX3ZSwZEjtNN7
         MNrGb87feByI3dIUPjSBMADrTPNKUiCUzZtCz+D4=
Date:   Fri, 14 Jul 2023 16:05:10 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] depmod: Handle installing modules under a prefix
Message-ID: <ZLFWFoDHcvLGoUuv@fjasle.eu>
References: <30d8c675-e769-e567-a81f-c1b59c66ad67@suse.com>
 <20230714122111.7528-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Pa7mRgbD1vtolPTh"
Content-Disposition: inline
In-Reply-To: <20230714122111.7528-1-msuchanek@suse.de>
X-Provags-ID: V03:K1:yxPjX7SMdl3aqZb23wGacxJ3K48ZF8W81Jw53FQ3MxMhqd2S+8U
 fd5hxfmHVfNUPtU6umnDHynJSE3/rkXimFm1RWwOHerz4oKsA/BIWfWLv+LLA5Novd7Vs9+
 SO/AlnLk7V2NXErEz2Lw+00dVwfvdEqCF4C2bAoHznOLgGJpqc9I4wZv/dcnkrgkCxSnd1N
 1S2OBpPnV236WupnAzE2Q==
UI-OutboundReport: notjunk:1;M01:P0:ChRfqaw0Yww=;MtnPlIX0x8/1MklJC7PNoVO+uFP
 5DwGAMGw3Q6UTCFSgaQ+cxQkT20AjyL8eOqL85THaJPywwMfSmnFwOUi1IEWFxK6z2Q89LUQ1
 Fkg0zay+0HM25X+MmL6/CFXE/ZejNtJkQ5BThXo/C04m43nys7P3pZlUfBhJ54OLG1k7YDEyF
 41OjoLuRGljIUPcp3CcVjR0bJ+FgQeIbaz7w70LLRv0TCIIJdzxIhYeiI8Og5TtIUm2FON0Ku
 aqrgnTRG3vgwwg+ggP8kztR9SINT4Csag754Fae6l8xb1bcaP6iHA0w0oTj0i2Ak8s5UW1u+c
 d2R0bosK+CQKI98olt3QyrkXF/BFG4zDtazD4zjiJ/NPdlfOVhy/Y0p0CLX7IjnKBFK6HV/kT
 hXx4pfpEWSFrnOXU7EWHvCAD4BBvb9zGFlZb5jcGGH1eLnXhuo7i8EPi2sLsMqyyWPvyztDud
 TdP2s8y50y5AG+IVYi1sxogXaWWC5FuDJWeG/741ytWLozECOrsgPOWGZHVnPY2uOsrEi9JLx
 2+fis2wfMZeiZ49Qy9o3yKu+ii1/l+BDgAFxZnz1Q5U3vBXAp+lx1jSAHU1o97hbNbpesYwf3
 u99NTM2vrDb14OAvhWEfrfjEOLf2WmPRExkZL6T0V11AoRdan5y1wJEJ5s99hz6rQz/TZml/T
 ETMQ1/FcMx51LY1NOidc9mCGd0HjLPd8GYZfPCCSwg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pa7mRgbD1vtolPTh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 02:21:08PM +0200 Michal Suchanek wrote:
> Some distributions aim at not shipping any files in / outside of usr.

For me, preventing negation often makes things easier, e.g.: "... aim at
shipping files only below /usr".

>=20
> The path under which kernel modules are installed is hardcoded to /lib
> which conflicts with this goal.
>=20
> When kmod provides the config command, use it to determine the correct
> module installation prefix.
>=20
> This is a prefix under which the modules are searched by kmod on the
> system, and is separate from the temporary staging location already
> supported by INSTALL_MOD_PATH.
>=20
> With kmod that does not provide the config command empty prefix is used
> as before.
>=20
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v2: Avoid error on systems with kmod that does not support config
> command
> v3: More verbose commit message
> ---
>  Makefile          | 4 +++-
>  scripts/depmod.sh | 8 ++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 47690c28456a..b1fea135bdec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?=3D $(INSTALL_PATH)/dtbs/=
$(KERNELRELEASE)
>  # makefile but the argument can be passed to make if needed.
>  #
> =20
> -MODLIB	=3D $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> +export KERNEL_MODULE_PREFIX :=3D $(shell kmod config &> /dev/null && kmo=
d config | jq -r .module_prefix)

All other calls of `jq` that I could find are located at tools/; as this he=
re
is evaluated on each invocation, this should probably be documented in
Documentation/process/changes.rst?

(Absence of `jq` will cause error messages, even with CONFIG_MODULES=3Dn.)

> +
> +MODLIB	=3D $(INSTALL_MOD_PATH)$(KERNEL_MODULE_PREFIX)/lib/modules/$(KERN=
ELRELEASE)
>  export MODLIB
> =20
>  PHONY +=3D prepare0
> diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> index 3643b4f896ed..88ac79056153 100755
> --- a/scripts/depmod.sh
> +++ b/scripts/depmod.sh
> @@ -27,16 +27,16 @@ fi
>  # numbers, so we cheat with a symlink here
>  depmod_hack_needed=3Dtrue
>  tmp_dir=3D$(mktemp -d ${TMPDIR:-/tmp}/depmod.XXXXXX)
> -mkdir -p "$tmp_dir/lib/modules/$KERNELRELEASE"
> +mkdir -p "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE"
>  if "$DEPMOD" -b "$tmp_dir" $KERNELRELEASE 2>/dev/null; then
> -	if test -e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep" -o \
> -		-e "$tmp_dir/lib/modules/$KERNELRELEASE/modules.dep.bin"; then
> +	if test -e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/mo=
dules.dep" -o \
> +		-e "$tmp_dir$KERNEL_MODULE_PREFIX/lib/modules/$KERNELRELEASE/modules.d=
ep.bin"; then
>  		depmod_hack_needed=3Dfalse
>  	fi
>  fi

I'd like to come back to the statement from Masahiro: Is the check above,
against some very old versions of depmod [1], the only reason for this patc=
h? =20

If we could remove that, would

    make INSTALL_MOD_PATH=3D"$(kmod config | jq -r .module_prefix)" modules=
_install

be sufficient?

Kind regards,
Nicolas


[1]: https://lore.kernel.org/linux-kbuild/1307631448-29848-5-git-send-email=
-mmarek@suse.cz/

>  rm -rf "$tmp_dir"
>  if $depmod_hack_needed; then
> -	symlink=3D"$INSTALL_MOD_PATH/lib/modules/99.98.$KERNELRELEASE"
> +	symlink=3D"$INSTALL_MOD_PATH$KERNEL_MODULE_PREFIX/lib/modules/99.98.$KE=
RNELRELEASE"
>  	ln -s "$KERNELRELEASE" "$symlink"
>  	KERNELRELEASE=3D99.98.$KERNELRELEASE
>  fi
> --=20
> 2.41.0

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--Pa7mRgbD1vtolPTh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmSxVhYACgkQB1IKcBYm
EmmKDw//czv3OHnSq7vycn19/eimIAUkcQRrxJof1ViT/+trhlEL8DTmcbc3tSPe
VjeySGsNwOeIznlE91qre7KWeuQFDknmJuMtBjzicggVKTsaqv7ncOOcATH1+M7F
L6X5VrY01S5cjHC0Xa9GioJ/qW4G+3lwhhH0bTYmMUkX/SjDYu6xgXBoNCeQf6dw
sGmjx2GAINHWSwXfdkkP5OTLPKNrGdTQVid3sF6sGIFYSyfBi9C9U1qemBnhJPMv
Mkhpb0tQ5r8UjFNbPfevrvNlDa0FGG9yALiK9zp/z4513AQ0XKqXvvw1V2Bfi4hR
stEm2KWQOylZ+HmCbce4myy0Km/oKZguHce75RS2+ME5X634Sw8b1rbkRVDPnIGW
XjjkYjlskD2tbAgue1WiCluOhCKRre2J+9PFWklWJ0GwuOEIia4hAbpnffKbjL3n
SrNU0fdS89f9zYFR1AF3YRxPpPt28Qqamy2VAdDTpiukJW+WSn4lHj0oEsKQO3sP
1OO761EWBfCggpcyl83MDSpmGf/NcyVjpv0ETie3D6BiC0ZKIAEslqtdZeaJJLpn
TPzz26Bzp2zSmO8WglEduMY8APQ0dx5XRDofwcLdeR7jepvPCdxmsBTafj9I7c7u
vESD+dTlUcYSBzVrZbCz9ClLMSTjm8Qm2KmcsEj1BLYS7frSAVw=
=OX3T
-----END PGP SIGNATURE-----

--Pa7mRgbD1vtolPTh--
