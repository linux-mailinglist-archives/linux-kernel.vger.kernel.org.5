Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA7880F1A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376755AbjLLP6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376740AbjLLP6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:58:04 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C33AA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:58:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD595-0007Gp-Tw; Tue, 12 Dec 2023 16:58:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD595-00FNFQ-4B; Tue, 12 Dec 2023 16:58:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD594-001kKw-Qq; Tue, 12 Dec 2023 16:58:06 +0100
Date:   Tue, 12 Dec 2023 16:58:06 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2] arm64: dts: imx8mq-kontron-pitx-imx8m: remove
 vqmmc-supply node
Message-ID: <20231212155806.yvjd5ozw2k7qex35@pengutronix.de>
References: <20210914072627.24173-1-heiko.thiery@gmail.com>
 <449f718706fd5af03190bdda986de37aa8fa14e3.camel@pengutronix.de>
 <79fb60ea9a002ea553a92ea08b28b866@walle.cc>
 <2dc72116ec935a5a5d7a1a176868b7af7ff3227c.camel@pengutronix.de>
 <9e3d52c297ed024594a1e610a5cf61b2@walle.cc>
 <CAEyMn7aYYkGZ1Eawd=yazdKeBuHVQc=3F7PnHSCSRyYCu=CJ9A@mail.gmail.com>
 <20231212134110.cijyajgwljkzovvo@pengutronix.de>
 <CAEyMn7Y_ZsGQjKJtFn6zuqzRzUzf_ueSi7JWhjOX0zeDsBzM8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tehlj4jbe4gy7bj7"
Content-Disposition: inline
In-Reply-To: <CAEyMn7Y_ZsGQjKJtFn6zuqzRzUzf_ueSi7JWhjOX0zeDsBzM8w@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tehlj4jbe4gy7bj7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Heiko,

On Tue, Dec 12, 2023 at 02:50:04PM +0100, Heiko Thiery wrote:
> Am Di., 12. Dez. 2023 um 14:41 Uhr schrieb Uwe Kleine-K=F6nig <
> u.kleine-koenig@pengutronix.de>:
> > On Tue, Sep 14, 2021 at 11:37:04AM +0200, Heiko Thiery wrote:
> > > dependency between emmc and PMIC. Debian 11 unfortunately does not
> > > have a driver enabled for the PMIC used and therefore cannot
> > > initialize the emmc driver.
> >
> > Updating to Debian 12 should give you a kernel that supports the
> > pfuze100 driver. (But I guess you know that, because it was enabled by
> > someone named Heiko Thiery. :-)
> >
> Thanks for the hint!

I'm working on cleaning up my inbox and had old mails open without
noticing. I only noticed after sending out that the mail is 2 years old
already and I should have considered it done without a reply.

Sorry if my mail appeared sneaky.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tehlj4jbe4gy7bj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV4gw0ACgkQj4D7WH0S
/k5rygf/cNolbAVIgf6k3p00ndKvZQUbNfHxdmMaQFpD+FOonmHJ9a4siPfFcBdP
2sc5sLVTxidhQR6qpEzPUA1bbiivjSII5C6vRP1RzKZiD/UAa80kQvn4JQ6ACqwP
LLm0ychULkr8PVBIb0zHTPo6SrlSJ9xquVmolmMKTrKT6Z5T8j+CjvCI2p/rZdU2
3zhpgRuU4zD65Bc8Y+rmFd94YgeUG8F3sIMOyYLPtu7qz/i0AvBnbMq2s7NqwvKj
C6OzbmyaqP0kFP5hJgEeXW1QOq1A7dox2ULrgbCQKDtupYyOLuH6K4BZfLOA3/48
O+irYZOqMKo7kH/bcE+/53qA9OweAg==
=LsDh
-----END PGP SIGNATURE-----

--tehlj4jbe4gy7bj7--
