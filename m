Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9A87A1C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjIOKoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjIOKoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:44:13 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31FCFB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:44:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qh6Iq-0001zO-G5; Fri, 15 Sep 2023 12:44:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qh6Ip-006Vvp-Sx; Fri, 15 Sep 2023 12:43:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qh6Ip-001pNJ-JB; Fri, 15 Sep 2023 12:43:59 +0200
Date:   Fri, 15 Sep 2023 12:43:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     nikita.shubin@maquefel.me
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v4 18/42] pwm: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <20230915104359.casgjp2bdeys4lbl@pengutronix.de>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-18-a1d779dcec10@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rws2zmjkqx5zytr4"
Content-Disposition: inline
In-Reply-To: <20230915-ep93xx-v4-18-a1d779dcec10@maquefel.me>
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


--rws2zmjkqx5zytr4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 11:11:00AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Add OF ID match table.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rws2zmjkqx5zytr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUENW4ACgkQj4D7WH0S
/k60kQf/WnpMGx2B6UIPoxvrAgO2juM9qlBEoKxiIhGufNDeNtw2PlONkCQWbdcO
RBwz8expQwSHYYPQ26p+HukubXoJt8fRPeTNzO614WySE2IRye8OFjl4kCgRtr4i
ZuYRJTuv91ocvDtHaWzWiq94NePuj2qWQqTDLCFSpwObkdmWnm7bVmPdI9Y/uc3X
XHjhPchiOpo5mqkPDB864572y4HN6TLEfPsoXfeOrbYFVcEPA+BoCC8ddS3uxbjV
HqwSBhqlG8PbtAgkxkoL4eZtBQp0TD1mf4UHv9liGzW93dpz7CNO9lwTsIIzsXAB
DUszSK5RoX00ck3s8Xxo8mo/xkxs8g==
=JMjn
-----END PGP SIGNATURE-----

--rws2zmjkqx5zytr4--
