Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A32A80D30B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344197AbjLKQ6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjLKQ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:58:18 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3247EB4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:58:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rCjbr-0002QV-3t; Mon, 11 Dec 2023 17:58:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rCjbq-00F8tu-34; Mon, 11 Dec 2023 17:58:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rCjbp-0012o0-QE; Mon, 11 Dec 2023 17:58:21 +0100
Date:   Mon, 11 Dec 2023 17:58:21 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] rtc: MAINTAINERS: drop Alessandro Zummo
Message-ID: <20231211165821.xp3mlxdezvezg6r4@pengutronix.de>
References: <20231211132600.101090-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hfuxyhyjjyeionsg"
Content-Disposition: inline
In-Reply-To: <20231211132600.101090-1-krzysztof.kozlowski@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hfuxyhyjjyeionsg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 02:26:00PM +0100, Krzysztof Kozlowski wrote:
> Last email from Alessandro was in 2016, so remove him from maintainers
> of the RTC subsystem.  Stale maintainer entries hide information whether
> subsystem needs help, has a bus-factor or is even orphaned.
>=20
> Link: https://lore.kernel.org/all/?q=3Df%3A%22Alessandro+Zummo%22

unusual usage of Link: (which traditionally has an URL proving the patch
submission).

> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec736fccbb26..82ef00014f41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18271,7 +18271,6 @@ X:	include/linux/srcu*.h
>  X:	kernel/rcu/srcu*.c
> =20
>  REAL TIME CLOCK (RTC) SUBSYSTEM
> -M:	Alessandro Zummo <a.zummo@towertech.it>
>  M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
>  L:	linux-rtc@vger.kernel.org
>  S:	Maintained

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Maybe it would be a nice move to add him to CREDITS.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hfuxyhyjjyeionsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV3P6wACgkQj4D7WH0S
/k40NQf/Qp/lGuMGxdxHGUK86QhoSIf2Aha4aI6sPgwAgGgMWiaAbbAMXgfKn2K0
ZeApA49vchlK2qnbJ5cXm99fUS294zJK7rdv6Skq+ZlQ5zFkGRNl1jGD8c9Z0gnP
5zWn2b6r4se0vxd7Xh/U9EAMfUlOMhTFKzz+ECbA/ZNPYRh5tTihv0XKjL4DHNmy
TLgcN06QAGJycB3OLFJ+/YAcXrKxJ34HNqGAfRHKTJJpbPdc79lzM1s3Sh7ZH/Wn
kviBaYYA9FTgfqUYLISYhKgz3pd7ojsAEN8PhLmAmxUVEASo7Sp+lsthjHQOHt/2
K4hT/3psQH8N58YIaOVGIasMcvZRyg==
=W2Xa
-----END PGP SIGNATURE-----

--hfuxyhyjjyeionsg--
