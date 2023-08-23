Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878E6786149
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 22:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbjHWUST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 16:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbjHWURt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 16:17:49 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729DB10D2;
        Wed, 23 Aug 2023 13:17:40 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.46]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9npT-1qcVC81pQ5-005mNr; Wed, 23 Aug 2023 22:17:13 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 1BFF23F8EE; Wed, 23 Aug 2023 22:17:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1692821829; bh=9Y6GJu22Mm4w6kt+Z0QIvpKJSKBxuDbHBUcn5zJ/y9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yj02GCgiR3PvhGLJmxabMp6B6qVfAQEcuXyxrGiBE4kqg4Wjum3ZcfMekOr1Xsl1Z
         77Wmanpqa6sgQpFSklstNBGTwDrNEuQSdKVmTEKtGwm/4zOFQpn/3RXAnUV0dr+rbe
         4PtsIa6ICBXu9lS1fLbILiNAAvcBRPT8/KO3r4l0=
Date:   Wed, 23 Aug 2023 22:17:08 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 4/8] kbuild: remove $(MODLIB)/source symlink
Message-ID: <ZOZpRMu6a47kkzrZ@fjasle.eu>
References: <20230823115048.823011-1-masahiroy@kernel.org>
 <20230823115048.823011-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DcjO63GeeJJAWHOK"
Content-Disposition: inline
In-Reply-To: <20230823115048.823011-4-masahiroy@kernel.org>
X-Provags-ID: V03:K1:ll3xFyBhpy4a0AlZdxB9cPcqKQBqov2zQCy4UJiib3Y4zzjC7Ie
 cnSJ3HXSJ1U8sX8k+vsiJodRc/SgN706zg55Omixf1Q6CUP6srvGFx/nFzUgPh3VUHeIadt
 3W2StLvjpCf5mhmvp/mOOj23fCUeHGAnnb6vP+efxQuxBXwBvpHzWOrOVF1jdRBH5b/uJpc
 pi94LtCscvW0/bTTX5w8w==
UI-OutboundReport: notjunk:1;M01:P0:OOrOpK7oFSQ=;OZr6uQt6rOTcYU3cYDKM0PoO+N7
 OGCCRuPEF5RbTE+YyFmR/xlIO+92GpStmtfNswVsBs7OeJR9fjzgsloEQ7aLEktcqfvCP9BZJ
 UqL8RHiXVle8Sq6iRxb+/1LhAUa3PxLtUmwhFk0SClq50fXKYhghAOU8xCKw9KzaW6QHz6+ul
 M8FAT15LPM72nKtmCmj61u0YhenBwJTkkdjaWrEVoS9NBDBEJJllrkwUFB4vMrxbABvGGUbkk
 6x6BHpGrr1Uou4RtL8wCr1bVAJFonvcW5aFfZKtOYZ9ablzgwBYJR1RRW3VZn/CNu6DyWb84/
 1yfYgwgxLhdaeFKFO4P42kifjL4XROH68vQNecGyejuJOTi/SHQSsO7/pDsDOpFpO3vfzOC/+
 t93KOTCRfa9A4XMzTkDGJb/SZre3c47f3mV5BwCZcBbU/T+eJhw/O3Mom+j1E7gpn54IAfA4Q
 ifmhdk4KszED6lSl+py8ylT8+dEFN5I7siNv3Mg0RXgpq1lhQ1+YTRXkSiZqr0W6l+PlrVkkY
 RUG0pjBfizc3JeqCQEKruAEPFsQjkhPXBqBbFzvHfn1T3Lf7kjx7WGyYUBFRrG/hkUhgqAVT9
 iKG8J+WSSKnyh2KVK8vnOuZ2u3Yuz/MhO0d58nCNH2Qeo+9emmyirNG65ryL237DL21cP0yhc
 WPKNv7c39pzsjK47OIcLWzQaEXfkKeUZhylnHiAkmNnhkbzadfhtY/EwdznHqLM33a8qpj8Ep
 EIsmgTG4ALw6TF6zATkBeNeXVmljKyK2MUK94ofyUtr1ZYcQA4HQK0JCWKy/7DO5T3PtegECq
 ZGkJtEmelix++AClxXYlGIly2zYyBYciHUuBaWnhDzaFkWkdnao0PgwD3OzPo8rZq3uIAkEm/
 jIUyFbeNmpt49pw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DcjO63GeeJJAWHOK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 08:50:44PM +0900 Masahiro Yamada wrote:
> This reverts the old commit "kbuild: Introduce source symlink in
> /lib/modules/.../". [1]
>=20
> The current Kbuild does not require $(MODLIB)/source. If the kernel was
> built in a separate output directory, $(MODLIB)/build/Makefile wraps
> the Makefile in the source tree. It is enough for building external
> modules.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/c=
ommit/?id=3De09e58867154b8aae0a3ac26a9b1c05962f5a355
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Makefile | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index c9c8019e4720..7d9cab3d2186 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1486,14 +1486,10 @@ modules_install: $(modinst_pre)
>  PHONY +=3D __modinst_pre
>  __modinst_pre:
>  	@rm -rf $(MODLIB)/kernel
> -	@rm -f $(MODLIB)/source
> +	@rm -f $(MODLIB)/build
>  	@mkdir -p $(MODLIB)
>  ifdef CONFIG_MODULES
> -	@ln -s $(abspath $(srctree)) $(MODLIB)/source
> -	@if [ ! $(objtree) -ef  $(MODLIB)/build ]; then \
> -		rm -f $(MODLIB)/build ; \
> -		ln -s $(CURDIR) $(MODLIB)/build ; \
> -	fi
> +	@ln -s $(CURDIR) $(MODLIB)/build
>  	@sed 's:^\(.*\)\.o$$:kernel/\1.ko:' modules.order > $(MODLIB)/modules.o=
rder
>  endif
>  	@cp -f modules.builtin $(MODLIB)/
> --=20
> 2.39.2

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--DcjO63GeeJJAWHOK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTmaUMACgkQB1IKcBYm
Emmesw//TfQqTYlQpo5Q6nIDiISOZuUlcP3EsHZ7GcIngKh4TQA/FkQGMS8Nn6pc
a/3zc8JM4AyTZvLJbWnrStttY84DxN9Ugt4D/a1gwQZVx3XbFijRN/rD/hThSliW
mt57E+/2bdixYNsNjJB9Jy4PIH65Q/SZTrSPNlV5iCoStlYc3QrAAEQT4OWUahNB
9O+m42T1UIe06rd/GreUr1vBI4q1e4U22q01UjJep598dieNCeQMXUrae5woDM+P
0ZFE9dTaYH3ZxrEN5M2Z72LTRND5sMR6LSvEHfsDwZ3gMARG4oQ8aZNbtkOcf9+4
zRiD1E3p1ICcbMzMCCUKhp3bdxExNQaSur2naXFzOyeze87x4Mb6tCJc4Wp5D7kn
SIgJfJstTRdLWE+L39cY9q9heh7BF66BH9RATvx9C3q9miKQhKQ1uWQyXfftMsYi
CNynIny5PUoqJovdy0OcvVvT3R6zWDYCv8kseEhhy9DLeroIIotzl1YXGlT/JVY+
0COQ2C6vOaCaOZYh4CY7yDtMEPP54+ia6yjUVx1s+VzBEIhipe3M0DdyugzcWxoL
POURAifOp1eL/G/dgERBmFiVe980ekw0ImUTRwrqHtHdk0pcBMttESQYiCn6w92R
aNLnq7x6gb/+ESP9ee1gHHWsgaab8lRmtfQOXqsLHeWJDbjSMVk=
=AzOZ
-----END PGP SIGNATURE-----

--DcjO63GeeJJAWHOK--
