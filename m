Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F386D7E63DE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 07:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjKIG2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 01:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjKIG2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 01:28:31 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B78111
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 22:28:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r0yWQ-0003Jy-QX; Thu, 09 Nov 2023 07:28:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r0yWN-007iJD-W2; Thu, 09 Nov 2023 07:28:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r0yWN-00Flde-MN; Thu, 09 Nov 2023 07:28:07 +0100
Date:   Thu, 9 Nov 2023 07:28:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 04/10] dt-bindings: pwm: samsung: add exynosautov9
 compatible
Message-ID: <20231109062807.ko53f63arpxgigd5@pengutronix.de>
References: <20231031094852.118677-1-jaewon02.kim@samsung.com>
 <CGME20231031095017epcas2p306a504619cbaf1fc260f6c46f8b75dd8@epcas2p3.samsung.com>
 <20231031094852.118677-5-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="phrujihovcq5oywv"
Content-Disposition: inline
In-Reply-To: <20231031094852.118677-5-jaewon02.kim@samsung.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--phrujihovcq5oywv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Oct 31, 2023 at 06:47:46PM +0900, Jaewon Kim wrote:
> Add samsung,exynosautov920-pwm compatible string to binding document.
>=20
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Doc=
umentation/devicetree/bindings/pwm/pwm-samsung.yaml
> index 2162f661ed5a..b6beca2ae81e 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
> @@ -30,6 +30,7 @@ properties:
>        - items:
>            - enum:
>                - samsung,exynosautov9-pwm
> +              - samsung,exynosautov920-pwm
>            - const: samsung,exynos4210-pwm

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

What is the merge plan here? Should this go via the pwm tree, or can it
better go via some exynos tree together with the dts files?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--phrujihovcq5oywv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVMe/YACgkQj4D7WH0S
/k4EXggAlFjY54YEO/PoOnIolDxKx9chBDVEVMJlsOyI2QZet0UQWoLYDkiYs/dr
HK9yQQNy4yPzu6/SvsDCEWPUYiE4VxlVBD3ZHopuEw1ALgsbVgpr80/LOVtmah/h
oE0A1eRVmw0DcjltUE0z+jkMPwPWK2TrDf+g/lWlhDU2mAXXZRVUDr51AMaP2CQ9
bZMmgTi1mpHrbs3QqUwvLrA7vgAQJyGE0XnGbBDY14Ay+Se5Nqw3n8BpwnnKuIFP
+mR1DrMlbkRwWaGGlXd3XpUzXCSTE++0lH1DZAkbpaIe4vkmOXF4UNTqVJ1ZWVeH
XI7tMTivTMbH9Nlwdtonbq/Qu8z/wg==
=pKZI
-----END PGP SIGNATURE-----

--phrujihovcq5oywv--
