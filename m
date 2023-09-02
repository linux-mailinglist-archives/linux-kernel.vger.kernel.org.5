Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950C17909D1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 23:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbjIBVjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 17:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjIBVjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 17:39:39 -0400
X-Greylist: delayed 1011 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Sep 2023 14:39:36 PDT
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17E9E54
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 14:39:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qcY4W-0006CP-Tu; Sat, 02 Sep 2023 23:22:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qcY4V-003V6R-2G; Sat, 02 Sep 2023 23:22:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qcY4U-000jBN-AY; Sat, 02 Sep 2023 23:22:22 +0200
Date:   Sat, 2 Sep 2023 23:22:11 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/2] leds: add ktd202x driver
Message-ID: <20230902212211.egbmusrbawkrrdlu@pengutronix.de>
References: <20230901-ktd202x-v2-0-3cb8b0ca02ed@apitzsch.eu>
 <20230901-ktd202x-v2-2-3cb8b0ca02ed@apitzsch.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3yy36qt3op6mlcma"
Content-Disposition: inline
In-Reply-To: <20230901-ktd202x-v2-2-3cb8b0ca02ed@apitzsch.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3yy36qt3op6mlcma
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andr=E9,

On Fri, Sep 01, 2023 at 11:19:59PM +0200, Andr=E9 Apitzsch wrote:
> +	.probe_new =3D ktd202x_probe,

probe_new is about to go away and since commit
03c835f498b540087244a6757e87dfe7ef10999b you can just use .probe with
the same prototype. So please use .probe here.

(Disclaimer: This is the only thing I checked here.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3yy36qt3op6mlcma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTzp4MACgkQj4D7WH0S
/k6paggAr8GWkS0QCAUDHE36Yy80iYlPCMDhK+Buxs+2gjg2gfr3l+qI3D32cX37
RsA3B94vmdZCx8Dkm1KPIwA3udb4/seZyzbwXO/9Qp5tt6J4K4OfD3sWeZKhQdgf
BDH5xeKmnQZthacdfiEZs7h0Rjpm6nQrMuuYLKURhTb0yd9L7XZcdIig9jd45Cio
BP2b+pNlSu2lP6mY5yZXmVVeApfx6uHRtRj9E4NJBz/SH/afu+MgUl+zs5MyHLoI
r9Hp8JGT4TJ/DqsSr5zheOofJnNN5lSzaDNEZWpc/rbhhYHn7EEsZ+R4R67WNjX6
kvLLcYguDddAChTqoOpJEsaprYHDOQ==
=Puti
-----END PGP SIGNATURE-----

--3yy36qt3op6mlcma--
