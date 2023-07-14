Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9A875387F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbjGNKnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjGNKnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:43:02 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481A72D7D;
        Fri, 14 Jul 2023 03:42:53 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.15]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5lvf-1ps8Ok2epH-017CtL; Fri, 14 Jul 2023 12:42:13 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id D561D3E8B6; Fri, 14 Jul 2023 12:42:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1689331332; bh=VbtTiOb3pj67buXnCTmEAlGgzMMxWUTXwxnvZuk4Xp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=d3/gxwudV53G2YvmCI65zt4LtGzb9FXtZXtieUiGSHZk5qU58I1WZiQNlyh0XJG2m
         UMQrTV8h9Eu/Bx17sfKcntheRBLqnjovLaQzWmV2c0273qt0RJ2R70PCxRps2I4trW
         VpWavTKE35DqWLzdQuGxjCV20s+lBPlGgQcQQsJk=
Date:   Fri, 14 Jul 2023 12:42:11 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kbuild: flatten KBUILD_CFLAGS
Message-ID: <ZLEmgxm73zzmffWD@fjasle.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0Cqt7gF9l+Mxlu9M"
Content-Disposition: inline
In-Reply-To: <4f414a87-0c54-44bd-b218-f6f0b22c57ef@p183>
X-Provags-ID: V03:K1:pXlRpCei6t48Xe832x9jG0u+dF34XzEwMra9E3u68U7X4sJ1nZL
 E8WgYvFA0Z/Ai6uJsuHLXgUHBMZnAE+AegVRoFnk3A/YFOPN54RviliNMOm4/jR9UU4wPRg
 IRHaH+HAWQcPe15etQSE24X7V5CcHiQqO1PV1Ter0mIHx8A+y1nqeBYQgzbedH8t9SszLp/
 d9PMLrUVJwSPWRBetY/lA==
UI-OutboundReport: notjunk:1;M01:P0:iiBMgfWDDUg=;BvGKpF2FEwM6xE6lGgOv+mD2TER
 R27VwYXzkvrcAcxMksWWxp+hHczreaVtafh0F0BdvuI0RisWXMzZ4mDqLAt1WRTX5NQwaZ96l
 eM27sLrb7/gB+X1//ZXm7j8mS0xNKs/mz853VnfwVfwHnaSe869bsmWp+mBQCWv01avfFT1Lk
 leleFY/4izgNpZks+5mRm3KnjERo1Y8FFjiDrpHwX2YFXHOWLRxmKJtdXAmaPIBllluOOgLHz
 hE+xwhMBUhzU9RWtPszy9sJdoXzV81rPooLPEUzZFCxz0+1QPbK0Ijx9XBbsz1tLNS8hcGCHk
 1ThAXjWfj65rkRwEfxYK/LHZieMR66jk+aV8WprTxWTw+G1L6nzQYOQaK1vBMBIeqGje9ikoV
 tuRj1xebbP4If1exXGat4LeJy4e6NE/Azq0IZofnwhhidie/s41ex+YS7HZGQv4cpNZ/A8vwX
 WLMExJYax5cVtpY6912nfMm9LI4Duae9suB7ovbs8/rcg9dL8SjumuzTPbPbaAcpMqDrAbInB
 8tcOB/N4LYTM3oO3kDf4rpJlqcJcaH2XfRQaFRSnjrNmYlGQopywuYP1/cIz3TcxOJALHJZUL
 HSwCgDXOaAnUx/AmDcEn3YjyKyR2q4Pxa2VGL9MTyxLscrUIdUk0p3abh7tiTSRFLvzjlNy7g
 B8roXL388xSPw9blrX3gC4F+4FjDZ80ZgyVmH1SdNQ==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0Cqt7gF9l+Mxlu9M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 09:52:28PM +0300, Alexey Dobriyan wrote:
> Make it slightly easier to see which compiler options are added and
> removed (and not worry about column limit too!).
>=20
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>=20
>  Makefile |   22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>=20
> --- a/Makefile
> +++ b/Makefile
> @@ -555,11 +555,23 @@ LINUXINCLUDE    :=3D \
>  		$(USERINCLUDE)
> =20
>  KBUILD_AFLAGS   :=3D -D__ASSEMBLY__ -fno-PIE
> -KBUILD_CFLAGS   :=3D -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trig=
raphs \
> -		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
> -		   -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int \
> -		   -Werror=3Dreturn-type -Wno-format-security -funsigned-char \
> -		   -std=3Dgnu11
> +
> +KBUILD_CFLAGS :=3D
> +KBUILD_CFLAGS +=3D -std=3Dgnu11

If you want to put -std at top, on contrast to the sorted options below,
you could also merge the two lines above.

> +KBUILD_CFLAGS +=3D -fshort-wchar
> +KBUILD_CFLAGS +=3D -funsigned-char
> +KBUILD_CFLAGS +=3D -fno-common
> +KBUILD_CFLAGS +=3D -fno-PIE
> +KBUILD_CFLAGS +=3D -fno-strict-aliasing
> +KBUILD_CFLAGS +=3D -Wall
> +KBUILD_CFLAGS +=3D -Wundef
> +KBUILD_CFLAGS +=3D -Werror=3Dimplicit-function-declaration
> +KBUILD_CFLAGS +=3D -Werror=3Dimplicit-int
> +KBUILD_CFLAGS +=3D -Werror=3Dreturn-type
> +KBUILD_CFLAGS +=3D -Werror=3Dstrict-prototypes
> +KBUILD_CFLAGS +=3D -Wno-format-security
> +KBUILD_CFLAGS +=3D -Wno-trigraphs
> +
>  KBUILD_CPPFLAGS :=3D -D__KERNEL__
>  KBUILD_RUSTFLAGS :=3D $(rust_common_flags) \
>  		    --target=3D$(objtree)/scripts/target.json \

Thanks for the patch.

Reviewed-by: Nicolas Schier <n.schier@avm.de>

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--0Cqt7gF9l+Mxlu9M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmSxJoMACgkQB1IKcBYm
EmlvNQ//cAJl2yEh6GztQ9N5MczsTK+goBJfyZT930kb7ogIqrUu2mL7WzbPEMou
fcb+DIWEwoc+WSmRawUf2k9aGEkuiGzY4sVWFfDIxbJyfHaQEnIdQbFpP7Wg4iFW
DAtlH8H2bi3sQgzPXDJHPbL+GmzppQHO/iEqUX8sco8Ti0N0vBt5foYSH8pgU3rZ
V6g5sTxZ4potPKgA9T/686AkEGDwLgFz8OgdEz01lzOZ+Gwh+nXSDZRhjvachVGr
C5d/cSno7DPDFmYK+JVkdXFi/waobG9agHW7YoqPMGBjCBvTH2Ojnm0mzIk5V5mf
DsP2ZME0Hjn9mncuYDJCnb2CTPn6wG4qqlMz4I6S52Hfy7Y39YUpDdAilu/bWruE
avCR2jQAtM7aOrRjuou1E8KzXJpPLAB+8OB8Lae6gadRPqRral3LdUcW9rJnXHOw
nQUZaQmgtYgMyeMgPf3jYVpnWbKh2wze5O7aYiYG3ERs+S0vReW/u5KPXUxDhmHy
s/Vy0FqgSHjyWimy/ie8cxl9gpkjuYYhKEn973/GtOl6IcA3VdA5kuwYGXXixiyV
C3ofKI3HbCs02chIpTdlzIgoEVzq/FtKvXa9Fby15zzWt4ySCtv939r5P7OIzpbL
dpMo9jhN8bEB/wpswoTRuscEHpP5AhAm2obe1A4NY6OJoONCKsw=
=QTTE
-----END PGP SIGNATURE-----

--0Cqt7gF9l+Mxlu9M--
