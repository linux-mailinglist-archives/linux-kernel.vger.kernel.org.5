Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BE17B0701
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjI0OfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjI0OfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:35:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540E6180
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:35:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlVcj-0007du-JP; Wed, 27 Sep 2023 16:34:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlVci-009MaV-1x; Wed, 27 Sep 2023 16:34:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlVch-005LnT-Ot; Wed, 27 Sep 2023 16:34:43 +0200
Date:   Wed, 27 Sep 2023 16:34:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jagath Jog J <jagathjog1996@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
Message-ID: <20230927143443.f4xpfzkwylipo25g@pengutronix.de>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-3-jagathjog1996@gmail.com>
 <20230927095708.l57kmdc3mmrtaco7@pengutronix.de>
 <ZRQhdkVNFdCfPseY@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6qll4arutm5puf3a"
Content-Disposition: inline
In-Reply-To: <ZRQhdkVNFdCfPseY@smile.fi.intel.com>
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


--6qll4arutm5puf3a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 03:35:02PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 27, 2023 at 11:57:08AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Sep 18, 2023 at 01:33:14PM +0530, Jagath Jog J wrote:
>=20
> ...
>=20
> > > Datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downl=
oads/datasheets/bst-bmi323-ds000.pdf
> >=20
> > Maybe put this link better in the driver.
>=20
> Why? We have a handful commits with this and it's better to see the link
> to the datasheet without browsing the source code.

But if you later work on a problem in the driver, it's better to see the
link without browsing git history. :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6qll4arutm5puf3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUUPYIACgkQj4D7WH0S
/k74wAf/bKI3Et3gPAiOaaSXOYWg7yGxuEkgLT0MChmeipxFuTXHohip+DTJJtYv
/omw0NS3Ysa2BGAg6ytQWuSuA5DE/6GxpiZ1GVwsLQLd7mFkIOg0DP7pp6elhqCR
Ex9/ioVWyWEKKCFjeywO+dYruEDFD87//au1bpNyY5ZTTNBvfQhuPsRmD1SQ1IUc
X0NuZxB7WwYTR83Zpw5kgViBjYAvL3qgd470uwrbAESBSJfCCE7noB7trU18A5mR
/BjCr6RzE/CWUKX6fE+tfw4PQr2l+eDeYE12W96JAgduRwVk3d/JSIlhSd6Rkkvp
2c+EnW0JyNOKnA7L0F8RBFyUXjOLaw==
=bJTb
-----END PGP SIGNATURE-----

--6qll4arutm5puf3a--
