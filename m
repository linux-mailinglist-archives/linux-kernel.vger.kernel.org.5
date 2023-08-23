Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0302A786112
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbjHWTyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbjHWTyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:54:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D212B10C2;
        Wed, 23 Aug 2023 12:54:06 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.46]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MfZ9C-1q6Svm1eX2-00fwiE; Wed, 23 Aug 2023 21:53:42 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id DEF223F8C5;
        Wed, 23 Aug 2023 21:53:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1692820417; bh=vASKztSakOJ1c1ApDb5Fde/LlmVd/hFEJTOFAf2gKEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=5wK+x2E3pybFUnlj+JVYuN60UnFqy9phgImBLZSslS5NpEPgMBq9Q5rwsx/abkpBD
         aLeWrJWjtJDPlFSDu5ygIn0yQAAsAjZhSHZN+/8eUfWq0lG6mrc2MpXF18OYlkYoFt
         ff18OvIDdYZgjW0cUYVb4s8xdCTPaK62JEFr1M70=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 361246556; Wed, 23 Aug 2023 21:53:07 +0200 (CEST)
Date:   Wed, 23 Aug 2023 21:53:07 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/8] kbuild: add modules_sign to
 no-{compiler,sync-config}-targets
Message-ID: <ZOZjo/8ZyrwF1XwZ@bergen.fjasle.eu>
References: <20230823115048.823011-1-masahiroy@kernel.org>
 <20230823115048.823011-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3x/EjL2sUW0fEZ4V"
Content-Disposition: inline
In-Reply-To: <20230823115048.823011-2-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:Yp8Fpd9TIYio+bdrb9jLGyh4CAqXrpnaszuj6XBpA0F7sThtxWy
 mH6AHE8DjQOwfNXIB8EbJivD14kCRwZwq4aii1TkchMCilQXBp7PUuPk7np+8fheS8OE0MT
 LNW+unr6iXMgS3VgskmI3tCG22h0B2WwVKRqdL362LUX3q1PEq8juuRio7xxUhHbUWjVAR2
 gc3VLg5Dri1nw86gVKIjw==
UI-OutboundReport: notjunk:1;M01:P0:okex6/9mmEE=;K0nbKS+HWJ+KftecBu9a8513clL
 /or1DqSKPBIjYtaXtI6I8oOHddMUboBLC/MO+ovwsS1angQaX4JK6QLKlcFdegTrFZvVurtjT
 L7HXYezoc2m+hOE16M9l3JYVIODrZeG8zy+i0/mDLk8l50LmSiLD19VR5S2rlswBDcu0Z469c
 4oM0ZZYPRoxTvTr1pL3KiWvVYPRw9gSTShJB4385TJdjcqzm4Xj8JproXUYAkqAZc0Cs1x2Y8
 LOigcAQbRgqPCp/uIgBxEIs8f3Sx4CKAfpXmnbI2smktnT3i2h2npetjetYXGGHMjWSJJvzR/
 LQ/7u7CMxp+LS8ItV5Ck23GctCcL9LhQwJYroHaBq8SZIH/u9amhpv4Utg14v33qWPL4CEC6M
 4yqMJ4CvUyoMdcuJN7+/qY7gP15+jWe0KJfj8fx+62aFVPFfEWA06zMbBtj9z5bBvzOYSYvcr
 gVQ13WX75B51Mlhld98rPObeI+JxqUXVphweUF6C+0oW5olGl2s4wRCcJZGtKTufZJirm9+WC
 r6mKYccEOc15d43sdHTBTcKywvetJXIs2Nv+FL9bR3MP8Coev/05qCLeebgv8oR1Rncr1R79X
 UvtPP0rUpWbF3WdX2KE9ElbJVmugK13dALeteBCdzyxhYwwAzG0q53yTyyB356U4Og0X6J0aF
 qjFTrnTLZ8jsej7A2/ABGc6+d+402YACOju4zmkN7fdYnJ9lSMEZZz2Z7eHB7e2D3a6ASU0Bd
 9Nc/8ZkSLTo/IKM5Z/xMK9exnFitDbTyV6yPOntyT1yb+dtMBmjpbUAdwahS9av0WQ94bJTFp
 aDmOcLFGVEojzKoFc1DQh8UqnitkUtBiJCZUIplrgsk+U+7HvB7rhXWBN8IvapDiAbPEw2ZRZ
 +RfiRHIjAjNt+TQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3x/EjL2sUW0fEZ4V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 23 Aug 2023 20:50:42 GMT, Masahiro Yamada wrote:
> Like modules_install, modules_sign should avoid the syncconfig.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 7d54a0700c6e..e2dfa3b994f7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -280,8 +280,8 @@ no-dot-config-targets :=3D $(clean-targets) \
>  # Installation targets should not require compiler. Unfortunately, vdso_=
install
>  # is an exception where build artifacts may be updated. This must be fix=
ed.
>  no-compiler-targets :=3D $(no-dot-config-targets) install dtbs_install \
> -			headers_install modules_install kernelrelease image_name
> -no-sync-config-targets :=3D $(no-dot-config-targets) %install kernelrele=
ase \
> +			headers_install modules_install modules_sign kernelrelease image_name
> +no-sync-config-targets :=3D $(no-dot-config-targets) %install modules_si=
gn kernelrelease \
>  			  image_name
>  single-targets :=3D %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.=
symtypes %/
> =20
> --=20
> 2.39.2

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--3x/EjL2sUW0fEZ4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTmY6IACgkQB1IKcBYm
EmmD0RAAgGLWOJtkuEikILsIAq5vBSjSD5To/2k3ZaeGQeqb22xdzhGHGBtnbX2U
yj89KYS0VMnMieOqkh0mtdByL41PHMukQxAGLVXkUOj9tVZHNnttVYLshotfNLZe
EqEXM9Ncv/WCm8cEJdu5IgIPz3gzZorbLURaJBEdZRC3NYiBeuT4NzxMbokUvbFq
q1avuSTwTBwk1H49NFlDo+RvRaDgPLkb3HDkDURH26oT3m2BBfPUE25RsN1OYJBS
Hq3WG01DrcLg08/R0nrP5xM91os8S+rLaZUITLn9zp+biDUOo3TOfvAQEU9m6Cvx
6/R7qZB0drjx8J42qWLxK5nvfUpzr4a2wSAeH6gc17zEEI3tBJvh888OybbqXcgN
KU0CgA/Yr9DFtkFUSzrv35gEfY2qoRn8RhrOUpzJ8sMbLYe5SusDYcSJnbpYo82K
xxTE+W7T1aL2YSzd3VzpeJEYbulzYOXGwUqUj/CWIvX01wnVa06QtwZUThCB8Qop
dKzjF7hlD6qxZS5iPX15FM2TaLHrHhYnh2/UwHnfg227bYU2O62RbhryKNMFxN+3
sKe6hcYoQt3rD5RfnI9XI2+b70p/8D2URw7GIDzupdOXXwLtyK9r0mj196kOVJMa
BTAeqLf4CNrOVhAgbEs/WBYz7E01FnGHkbcasjRs2pK0GigHlOM=
=IBia
-----END PGP SIGNATURE-----

--3x/EjL2sUW0fEZ4V--
