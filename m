Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BC07EDC6E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjKPH5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPH47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:56:59 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C326C199
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:56:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3XEr-0008RG-Bx; Thu, 16 Nov 2023 08:56:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3XEp-009P1M-Np; Thu, 16 Nov 2023 08:56:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3XEp-002Wrz-EO; Thu, 16 Nov 2023 08:56:35 +0100
Date:   Thu, 16 Nov 2023 08:56:35 +0100
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
Subject: Re: [PATCH v2 00/12] Introduce ExynosAutov920 SoC and SADK board
Message-ID: <20231116075635.onolshbu4waqsqag@pengutronix.de>
References: <CGME20231115095852epcas2p21e067efe75275c6abd2aebf04c5c6166@epcas2p2.samsung.com>
 <20231115095609.39883-1-jaewon02.kim@samsung.com>
 <170005362858.21132.4200897251821879805.b4-ty@linaro.org>
 <6e69df6c-10fa-404a-ac02-4880723b8c50@linaro.org>
 <55a0f27c-ea46-40ae-b1e5-e650802b89a8@linaro.org>
 <d6f3d451-6a53-46b6-2263-cc071a9dc44c@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="deso36yy7zj5rlry"
Content-Disposition: inline
In-Reply-To: <d6f3d451-6a53-46b6-2263-cc071a9dc44c@samsung.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--deso36yy7zj5rlry
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 16, 2023 at 12:32:30PM +0900, Jaewon Kim wrote:
> I already checked and there were no warnings or errors as shown below.
>=20
> Did I miss something??
>=20
>=20
> $ make CHECK_DTBS=3Dy ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu-=20
> exynos/exynosautov920-sadk.dtb
>  =A0 LINT=A0=A0=A0 Documentation/devicetree/bindings
>  =A0 CHKDT Documentation/devicetree/bindings/processed-schema.json
>  =A0 SCHEMA Documentation/devicetree/bindings/processed-schema.json
>  =A0 UPD=A0=A0=A0=A0 include/config/kernel.release
>  =A0 DTC_CHK arch/arm64/boot/dts/exynos/exynosautov920-sadk.dtb

https://www.kernel.org/doc/html/latest/process/maintainer-soc-clean-dts.html
also talks about W=3D1 that you didn't pass.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--deso36yy7zj5rlry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVVyzIACgkQj4D7WH0S
/k7Dsgf8CEfnfcBO+X5uEDgo3Y7Z8C4wi5ENcCF2QdbXIn8f3i/0j24kJy5bKnh1
aYEK3ZPy0TCtE9dW8BCoRjv4XyDOhS4gQkvgUGEhz+Y31KZx54rNTK/vPimcVZ51
ykiKjhtT9WSMf8qcEaTdimYtt8+e8iA8WaRmQyMyzxbSCDnTvTXoWzMga77bpqco
uIm0DgPSeMEzVI3tSNzI1DcJHBsR5Vee65E88Wq6jTukkVGtAiS7/mT0BLwhiYWN
mopKsb3BDL1WvwmuJlnf6wleGhZRKWKNChljiPG/N9o7Vtzt6zJht/WOVYx1dmyJ
CjfcU9YKpKwjWMDJ18/Tas3lVVSvEQ==
=qThe
-----END PGP SIGNATURE-----

--deso36yy7zj5rlry--
