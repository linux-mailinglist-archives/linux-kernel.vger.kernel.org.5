Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE4580EDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346575AbjLLNlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376283AbjLLNlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:41:07 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D06A1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:41:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD30Z-00082t-R9; Tue, 12 Dec 2023 14:41:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD30Y-00FLvm-Ut; Tue, 12 Dec 2023 14:41:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rD30Y-001eXK-LH; Tue, 12 Dec 2023 14:41:10 +0100
Date:   Tue, 12 Dec 2023 14:41:10 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2] arm64: dts: imx8mq-kontron-pitx-imx8m: remove
 vqmmc-supply node
Message-ID: <20231212134110.cijyajgwljkzovvo@pengutronix.de>
References: <20210914072627.24173-1-heiko.thiery@gmail.com>
 <449f718706fd5af03190bdda986de37aa8fa14e3.camel@pengutronix.de>
 <79fb60ea9a002ea553a92ea08b28b866@walle.cc>
 <2dc72116ec935a5a5d7a1a176868b7af7ff3227c.camel@pengutronix.de>
 <9e3d52c297ed024594a1e610a5cf61b2@walle.cc>
 <CAEyMn7aYYkGZ1Eawd=yazdKeBuHVQc=3F7PnHSCSRyYCu=CJ9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i6pn3jy546wilcvi"
Content-Disposition: inline
In-Reply-To: <CAEyMn7aYYkGZ1Eawd=yazdKeBuHVQc=3F7PnHSCSRyYCu=CJ9A@mail.gmail.com>
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


--i6pn3jy546wilcvi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Heiko,

On Tue, Sep 14, 2021 at 11:37:04AM +0200, Heiko Thiery wrote:
> dependency between emmc and PMIC. Debian 11 unfortunately does not
> have a driver enabled for the PMIC used and therefore cannot
> initialize the emmc driver.

Updating to Debian 12 should give you a kernel that supports the
pfuze100 driver. (But I guess you know that, because it was enabled by
someone named Heiko Thiery. :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--i6pn3jy546wilcvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV4YvUACgkQj4D7WH0S
/k7eowf/WRMWV6oinxGen8cTbmAkwjcyvIyn5YbMeEH9Lh+gEEjgFCasG+4WICBJ
FgwwdJuaNeiYJ3pQDRaBeDk7i9X3dgQkkOt/QbQ14N2GH8L+T7GKs9W81/uF0xTh
WBDWJWzw+2CSe1pn+jK8jLF991ufcyji/z14RSu1FWIIauxa/NhX9oFeQ2Mc2wF4
mdwK3MoZQWPIaSvsloEVtohQZbTHMdC57BuqcjwccnYs4PhNGravZpT0vWlFlZXK
MhkizVsZ6sEBv7oOFVXS/F0m7E/6xWpm5jCDyidpua2GYDnYA1b3HaNsv5N9/Z4K
GAdDOfJSjZLX9itx/YyGfgkmZbZx5A==
=D+nl
-----END PGP SIGNATURE-----

--i6pn3jy546wilcvi--
