Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07347D99C6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345942AbjJ0N1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345939AbjJ0N12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:27:28 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1DE1BC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:27:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qwMru-0002hh-B6; Fri, 27 Oct 2023 15:27:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qwMrt-004eXB-HF; Fri, 27 Oct 2023 15:27:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qwMrt-007LTa-7c; Fri, 27 Oct 2023 15:27:17 +0200
Date:   Fri, 27 Oct 2023 15:27:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     JunYi Zhao <junyi.zhao@amlogic.com>, thierry.reding@gmail.com
Cc:     neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 RESEND] pwm: meson: add pwm support for S4
Message-ID: <20231027132717.braretixsumdnrgd@pengutronix.de>
References: <20231016052457.1191838-1-junyi.zhao@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h33tp4yjyqfzxjra"
Content-Disposition: inline
In-Reply-To: <20231016052457.1191838-1-junyi.zhao@amlogic.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h33tp4yjyqfzxjra
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 01:24:57PM +0800, JunYi Zhao wrote:
> From: "junyi.zhao" <junyi.zhao@amlogic.com>

Is this a valid variant to write your name?

> Support PWM for S4 soc.
> Now the PWM clock input is done in independent CLKCTRL registers.
> And no more in the PWM registers.
> PWM needs to obtain an external clock source.
>=20
> Signed-off-by: junyi.zhao <junyi.zhao@amlogic.com>

@Thierry: This patch didn't made it into patchwork. I didn't check
systematically, but that's at least the 2nd one that doesn't make it in
in the recent past. (The other was my pull request to you.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--h33tp4yjyqfzxjra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU7urQACgkQj4D7WH0S
/k54EwgAktP5P0KpgjtvveUVf3G2IJPv300KQsqESC6NkuM0W6mG119Q8Z2yaxO1
cnyhrUzAfg2qDsyef2f52qh+PUZ0gOM7vxtImaLgqOrnjVoTtCdjo5Dpy3iq6n+K
3KYcau+6yQaq9Ls3qWb+StBwfiQBpEV6v+w3gd+hIpEPnpprd2yma8s+ViWvEtCu
F7ZCD3QgpVoYpPYDFjzMBAqx2qWIYybnOUTybrl45MHg1asQ+NPOVkDC8SmBBaIh
s+V7giMwpnVxtmDuqvSlJ5VVRDUUQSWOCDPLRoWfGvONotK5oJETUVXN0+TgfW0k
0MCT2Tco3DFM+zMBnj8H4Wicgy3wkg==
=w3u2
-----END PGP SIGNATURE-----

--h33tp4yjyqfzxjra--
