Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BB475473A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 09:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjGOHWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 03:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOHW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 03:22:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563FE26B5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 00:22:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKZbW-0001bz-FF; Sat, 15 Jul 2023 09:22:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKZbU-00EWXC-18; Sat, 15 Jul 2023 09:22:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKZbT-0050eI-Ck; Sat, 15 Jul 2023 09:22:07 +0200
Date:   Sat, 15 Jul 2023 09:22:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH v2 2/3] pwm: samsung: Add compatible for ExynosAutov9 SoC
Message-ID: <20230715072203.ecz7wg4novvhpyuj@pengutronix.de>
References: <20230714100929.94563-1-jaewon02.kim@samsung.com>
 <CGME20230714101434epcas2p3e2475698c527ca72dee797225d3dad37@epcas2p3.samsung.com>
 <20230714100929.94563-3-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kqo2ocrcjovppqzr"
Content-Disposition: inline
In-Reply-To: <20230714100929.94563-3-jaewon02.kim@samsung.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kqo2ocrcjovppqzr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jul 14, 2023 at 07:09:28PM +0900, Jaewon Kim wrote:
> Add new compatible string to support ExynosAutov9 SoC.
>=20
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>

Looks good to me:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

What are the merge plans here? The whole series via pwm or a samsung
tree? Or a mixture?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kqo2ocrcjovppqzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSySRoACgkQj4D7WH0S
/k5f/wgAopsGxq70NXlUC/uGjOQh4t7xUaf3gadY0sFhLBGjxS0NEH/2RD1NNS1N
4lJ8+t1dK5M6u1JWjIFQUKmUrxtur1g5Ziy4JDOM76OV7s270E5tOTyeaeKwHzYU
YD6vLY3GF98CM7Z8zfR+n9Ucxfsyj2MOAjxkmkGDCk9kkbye08szbkFc/+t28V94
X3iMPkKrGTN9Kt2NMGBGQ/5ejqZOyeMDB7gioobTciTJO5uqtoaH6r82eLemfYTa
4mLyg7EGxhrHLXic9TaXzQpRK4uSzWjvaBSVH6b0gHMQTdPoBwAjv9tNnv9omyUH
EmuybPj4oWswBnqf4MzVux1vpDevCQ==
=K4Ru
-----END PGP SIGNATURE-----

--kqo2ocrcjovppqzr--
