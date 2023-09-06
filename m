Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91336794079
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbjIFPgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbjIFPgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:36:37 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBBDE6B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:36:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qduZt-0006ss-1b; Wed, 06 Sep 2023 17:36:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qduZr-004SOr-Tn; Wed, 06 Sep 2023 17:36:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qduZq-00Gtjw-K5; Wed, 06 Sep 2023 17:36:22 +0200
Date:   Wed, 6 Sep 2023 17:36:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Leif Middelschulte <leif.middelschulte@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] pwm: imx27: avoid PWM consumer API
Message-ID: <20230906153622.2huv45qdool45nmo@pengutronix.de>
References: <20230310174517.rb7xxrougkse2lrc@pengutronix.de>
 <20230815104332.55044-1-Leif.Middelschulte@gmail.com>
 <20230815104332.55044-2-Leif.Middelschulte@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eovkn5o4nsbkmbsm"
Content-Disposition: inline
In-Reply-To: <20230815104332.55044-2-Leif.Middelschulte@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eovkn5o4nsbkmbsm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 12:43:30PM +0200, Leif Middelschulte wrote:
> Access struct members directly as adviced[0].
>=20
> [0] https://lore.kernel.org/lkml/20230310174517.rb7xxrougkse2lrc@pengutro=
nix.de/T/#ec9560c1f613d9c0d7b77d72ad9051768812f80db
>=20
> Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--eovkn5o4nsbkmbsm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT4nHUACgkQj4D7WH0S
/k7VmAgAlgzYlFpnlxwob2j/bchti2Ioo6PMQ67kNJILf/QlO6B8FOwzsEYdJBpQ
cmmWkUCguXueWZgRKYqwP1b/3Noe5f6ml3+VOHaavzpdJZjDyaT/K1VEmnYvfP1p
3DWoKsHULUQPHioEbNva4hfHOh3JWUlUe82wjQp+REGENirnAdM9bVCnADd/Grlx
f/y5+Z6+7Ct2LJzFG78ZqDatzthO6YNKBp2r/ng6BLU9SOSk1Xok+UMqcoihtXY9
doCHOUTUACxYvFA1uuyBwrobK4fCk9ml1fMCw1S93MI88WWtRF/VAaYZS4BeN8ew
40qdnQK0oSBBVIQVf40X8D2Lo15Zdg==
=I9C5
-----END PGP SIGNATURE-----

--eovkn5o4nsbkmbsm--
