Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC97B48B9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 19:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjJARFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 13:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjJARFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 13:05:49 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44F383
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 10:05:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzsz-0005mK-QE; Sun, 01 Oct 2023 19:05:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzsy-00AKWJ-OL; Sun, 01 Oct 2023 19:05:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzsy-0079qX-Eu; Sun, 01 Oct 2023 19:05:40 +0200
Date:   Sun, 1 Oct 2023 19:05:40 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        pavel@ucw.cz, phone-devel@vger.kernel.org, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 2/2] leds: add ktd202x driver
Message-ID: <20231001170540.yiouho2lrzrioxns@pengutronix.de>
References: <20231001-ktd202x-v5-0-f544a1d0510d@apitzsch.eu>
 <20231001-ktd202x-v5-2-f544a1d0510d@apitzsch.eu>
 <a2380c93-42a5-9de5-3be9-9ebb50a965a3@wanadoo.fr>
 <250d0e681e7bbb750464338fb3a1a4a3199ce6ef.camel@apitzsch.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="byfsp32mttsymf7l"
Content-Disposition: inline
In-Reply-To: <250d0e681e7bbb750464338fb3a1a4a3199ce6ef.camel@apitzsch.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--byfsp32mttsymf7l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andr=E9,

On Sun, Oct 01, 2023 at 06:56:20PM +0200, Andr=E9 Apitzsch wrote:
> Am Sonntag, dem 01.10.2023 um 17:15 +0200 schrieb Christophe JAILLET:
> > Le 01/10/2023 =E0 15:52, Andr=E9 Apitzsch a =E9crit=A0:
> > > +=A0=A0=A0=A0=A0=A0=A0for_each_available_child_of_node(np, child) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0u32 mono_color =3D 0;
> >=20
> > Un-needed init.
> > And, why is it defined here, while reg is defined out-side the loop?
>=20
> I'll move it out-side the loop (without initialization).

In my book a variable with a narrow scope is better. I didn't check, but
if you can restrict both variables to the for loop, that's nicer.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--byfsp32mttsymf7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUZpuMACgkQj4D7WH0S
/k4UrAgAsqfphLfBJY2x0Nxsf8Wj657r8d8qYHsMPFBaWGtTTAmORhde68d7oG2y
ZBFbwx6uFFqh+uL005zE/MFzujknV/8ymncUxQUBDyh9oqXfq1K+c9flpwS9rZ13
LhQTu+akTLmSO2KdZEG9qxUP66+T36XyTppUPXCr2xVJtNOELSd6avAno4BkfwP6
0Y29zuL+JILfcd96yBUdUPvGjFpvsX0+qSCPtdckuWGZ34Amw0E/NVtwLfKP1ZSL
FbNn4SJ6n7VAhAKlNkXjdhMmw/vTPBeiWmRN5EHX1eBW2bWkx86rWfvhM6FNP8YO
6ZWLbPc0HblCtiHRhRM+06PrNYcvpQ==
=WKZx
-----END PGP SIGNATURE-----

--byfsp32mttsymf7l--
