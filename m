Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56184786113
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbjHWTyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbjHWTyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:54:21 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31FC10CC;
        Wed, 23 Aug 2023 12:54:15 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.46]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MuDsZ-1pjYig2wCD-00ubov; Wed, 23 Aug 2023 21:53:51 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 10BB73F8C0;
        Wed, 23 Aug 2023 21:53:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1692820429; bh=W8HwNVodimkglBXbPPTwxa4vjsb4pR5MrnJ4yaf/CUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uj5SJK+RxmhPvCNYvOr46/nZX/H6RBsU7or1wOUZNJTlJfsrA+mgAphCqFVcmwt6e
         Td3F2x67H7TWzxiZf4a3av00wccWw7l7DcQM82Svh0BV8S5qIrkHyl29G1QOhkS818
         CLXYvoTm4/4o+jjyhGUkgAd20lEc+vGDkfCu84Hk=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id ACFEF655D; Wed, 23 Aug 2023 21:53:15 +0200 (CEST)
Date:   Wed, 23 Aug 2023 21:53:15 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 3/8] kbuild: move depmod rule to scripts/Makefile.modinst
Message-ID: <ZOZjq4dl0hthWaVT@bergen.fjasle.eu>
References: <20230823115048.823011-1-masahiroy@kernel.org>
 <20230823115048.823011-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vF7ipIWdiY1xe9LR"
Content-Disposition: inline
In-Reply-To: <20230823115048.823011-3-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:VrKjufNOHN9MtgRJD0s90HFFqcCQA6bb4+0X1r8ocW/mz3K5+NH
 MOJiCTWI+yPLYTSwUxwn9CP6W0a/7hcIOO87IaJNaIoh0rdU9yCDWiLIvUVafep9kob7M+c
 T/IXGhLAjLnDwDDJDDPkptPi3CbwecOcf3ZeQlXaXOnM5NI7yOQC0N5fKY2EK1woqxD717f
 GDklbggsTZA5gpA3XHSrg==
UI-OutboundReport: notjunk:1;M01:P0:f+72rpk94vU=;aQNE4TkRZVai756QYjApNGZln3W
 nOtnvE/hTKawklN5ZLS1xvGvhOmhk8LOPd/YK5NEFU4tjKCwt0SwccegZzYv4t3GZMfDSoQEd
 9h3wI4ooYa5B131SvVXycju3JeBf3gbVzwj6EyM+h3mesprDxsFl2i3CwffikolBnYFVOOR36
 fQyB42OuJqffhWD3vaM1tZAoDjXvMsnBEOaBLx1hrZCZVjarP2KBbRtlRdkxzPg52vDp8ZIvT
 bRwq/ikmFJFlhOmIVIwcP/adhZf7ynYilNu5B/Kfb75o85mHBhsniiJ0X3se+DNZi88fP4IVY
 XnHA9dak3y/wWDEuUTF3ljWvz9gyYUPYxgm5KNuKzzsOfmFAg965go7sUm4qLgLqIlPHBeW8F
 GgrY2DHZxIX2fq7pgsgPrRCBn6LWfShy8MYUh9IgGtFCD/0pLg+aaL4Z1oUn8HyOk8aNAE17J
 KD9ghd6a73UPbsMDb/k1IIoPTI1C+cClJmyJBakEseYhYR0k32fLpTU9Rhrf7nVDhOr6WgeVC
 M5T2qYhMxd6FVVTuN6hXZkPZXWAJV8kEcPRieVcmboWmJREo1EysqrPrSRaeB+1GDHwK8Wr2Y
 qXATdUdHedoZ9JnTRHDxw+QOAVleHVJBTI85ewDB2oAn40p4b1GrcLvn/R6aIWYxlZwW2I/7N
 yZK/R00p32oXuZfaETOLPtjJhVJgtHr8ZWpv8nlk1BHDscQLfOWL141LpZhiG6CMwt/prC2a2
 vsk8GIN+dZBInjRNYd8x7PGbdV4VVMFgxYCOxKies1Su2yl1QYhxMrxgNlgOslqkMWr1UwfG/
 e06NN9Lyxwa2YSie0fgaOT0OubhQcy/BQgK/67Hg2BG62sCbVWouYWf8f6MKFcJc581mhvSHQ
 ISzHGAMmOFnLiNg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vF7ipIWdiY1xe9LR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 23 Aug 2023 20:50:43 GMT, Masahiro Yamada wrote:
> depmod is a part of the module installation.
>=20
> scripts/Makefile.modinst is a better place to run it.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Makefile                 |  8 --------
>  scripts/Makefile.modinst |  9 +++++++++
>  scripts/depmod.sh        | 10 ++++++----
>  3 files changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index e2dfa3b994f7..c9c8019e4720 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -509,7 +509,6 @@ LEX		=3D flex
>  YACC		=3D bison
>  AWK		=3D awk
>  INSTALLKERNEL  :=3D installkernel
> -DEPMOD		=3D depmod
>  PERL		=3D perl
>  PYTHON3		=3D python3
>  CHECK		=3D sparse
> @@ -1871,15 +1870,8 @@ PHONY +=3D modules_check
>  modules_check: $(MODORDER)
>  	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/modules-check.sh $<
> =20
> -quiet_cmd_depmod =3D DEPMOD  $(MODLIB)
> -      cmd_depmod =3D $(CONFIG_SHELL) $(srctree)/scripts/depmod.sh $(DEPM=
OD) \
> -                   $(KERNELRELEASE)
> -
>  modules_install:
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
> -ifndef modules_sign_only
> -	$(call cmd,depmod)
> -endif
> =20
>  else # CONFIG_MODULES
> =20
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index ab0c5bd1a60f..7a64ece9b826 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -86,6 +86,15 @@ $(dst)/%.ko: $(extmod_prefix)%.ko FORCE
>  	$(call cmd,strip)
>  	$(call cmd,sign)
> =20
> +__modinst: depmod
> +
> +PHONY +=3D depmod
> +depmod: $(modules)
> +	$(call cmd,depmod)
> +
> +quiet_cmd_depmod =3D DEPMOD  $(MODLIB)
> +      cmd_depmod =3D $(srctree)/scripts/depmod.sh $(KERNELRELEASE)

Did you remove the $(CONFIG_SHELL) by intention?

> +
>  else
> =20
>  $(dst)/%.ko: FORCE
> diff --git a/scripts/depmod.sh b/scripts/depmod.sh
> index fca689ba4f21..ee771ccb1f9c 100755
> --- a/scripts/depmod.sh
> +++ b/scripts/depmod.sh
> @@ -3,12 +3,14 @@
>  #
>  # A depmod wrapper used by the toplevel Makefile

toplevel Makefile -> scripts/Makefile.modinst

> =20
> -if test $# -ne 2; then
> -	echo "Usage: $0 /sbin/depmod <kernelrelease>" >&2
> +if test $# -ne 1; then
> +	echo "Usage: $0 <kernelrelease>" >&2
>  	exit 1
>  fi
> -DEPMOD=3D$1
> -KERNELRELEASE=3D$2
> +
> +KERNELRELEASE=3D$1
> +
> +: ${DEPMOD:=3Ddepmod}
> =20
>  if ! test -r System.map ; then
>  	echo "Warning: modules_install: missing 'System.map' file. Skipping dep=
mod." >&2
> --=20
> 2.39.2

A minor observation: with this patch, the "quiet_cmd_*" examples in=20
Makefile and in Documentation/kbuild/makefiles.rst become out-dated.

But technically, it looks good to me, thus:
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--vF7ipIWdiY1xe9LR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTmY6sACgkQB1IKcBYm
EmmFRBAA4EVxa8aYl2qwSoW215fvAR+EmVBuIsb2zQkTtXja9ba6oYpMl30Didkc
9w80jsZ2Li0Nux1V3KKf872ESQQtCXhAxXyX4fqpinMhKozmbkzCqiaEPamRn6CR
bUOde46sIfjdrD6WiDQwGqx9iLXGRVclgm4JVbkg9XoC6vNaKlr3Wtd2JJiHJ14P
1JLpbs4dl8nQbdpVhXeGxjjTu09LFfe8wlGwwdnMv2u2klRIPLH+oGUzxC+1aQ3F
/HvTb9Tmq8DNB/uUJBhtc7bpKawJlKyMZNPTm5SjHeV/PDnMtMRoE4vS7hn6E4uD
78Ss0g+2RAA+JboZV6C26PCM68xoA2Wlb+/nX1Z2VxxjBIKwgx/uT5GD23kw8yBq
ZqjkzmUy+SICfM436G4mivt+J6DpsVGERPiBzxxHN0tJbtZwMpVdZXXh9g2FSuA6
yS7XwBnagRm8zgQo2r+/D4bdTqjEu6+CW0akpZh9nfIIO30V5uyJOJ41q+uZrfL5
XCp76aPl5Nj1JrWGjluZ93GVp/YnJU9GGdmEvgj+otObhOidpVDIjA5OqA4Dzxf2
ZCcLgLm1LlYAgYq8oX18ryAZd9tb9+63Kp/0A0wDXkdtHCt+ozPUaPF7glGV6O3E
DiKhVi36FGKQpIKx0v9zDN2eh2zIhpYT1zV0DsR8TZxMikmQjhY=
=q0fX
-----END PGP SIGNATURE-----

--vF7ipIWdiY1xe9LR--
