Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38747D6F25
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344955AbjJYOdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjJYOdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:33:13 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F5899
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:33:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qvewX-0004R0-Az; Wed, 25 Oct 2023 16:33:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qvewW-004CNI-Kb; Wed, 25 Oct 2023 16:33:08 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5138C23E29A;
        Wed, 25 Oct 2023 14:33:08 +0000 (UTC)
Date:   Wed, 25 Oct 2023 16:33:07 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] arm64: dts: imx8mp: add imx8mp-venice-gw74xx-rpidsi
 overlay for display
Message-ID: <20231025-pessimist-irritate-927b64fbd2fa-mkl@pengutronix.de>
References: <20230719152920.2173-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3vhsml6d66uwdycg"
Content-Disposition: inline
In-Reply-To: <20230719152920.2173-1-tharvey@gateworks.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
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


--3vhsml6d66uwdycg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Tim,

On 19.07.2023 08:29:20, Tim Harvey wrote:
> Add support for the following Raspberry Pi displays:
>  - DFROBOT DRF0678 7in 800x480 TFT DSI capacitive touch
>  - DFROBOT DRF0550 5in 800x480 TFT DSI capacitive touch
>=20
> Both have the following hardware:
>  - FocalTech FT5406 10pt touch controller (with no interrupt)
>  - Powertip PH800480T013-IDF02 compatible panel
>  - Toshiba TC358762 compatible DSI to DBI bridge
>  - ATTINY based regulator used for backlight controller and panel enable
>=20
> Support is added via a device-tree overlay. The touch controller is not
> yet supported as polling mode is needed.

I'm just integrating the 7in Raspberry Pi display for a customer on an
imx8mp. Do you have a (non-mainline) touch driver that works for the
Raspberry Pi display? I might fight some time in this project to work on
it.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3vhsml6d66uwdycg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmU5JyAACgkQvlAcSiqK
BOg5ywf/XB/Ny1RGUSqlQ+oIj35OzKJLsKPcx4BteKcIlYJlSvKUfeFkKM5/7VXa
FaIUN4XuKY9efKXlhOS+NF3js3AQyUhZf5XrQ6F4gP9ncotDb7L1YpS8Lzp+VsNK
0PMQuBnXLT+07PHJsbk2jPUbvDyUA93lIhNP0B1lEaF7SidVFo+iWQkxRZFOybGb
kfO3vp1b2CpWSmYHEWzPG/x8KeMOXfPE4cmAbNFxYh/U8AUQofBf+MpmtUahWHFB
eH/Lc8kz+11coeIV5kJA+oqKM2CSqG1RGHRAssfpPVvg3RCdpUHlGgH+Gwss4Q1Y
9SefEP41ZeWRQrm5bUhu4krMDdn/QA==
=6kWa
-----END PGP SIGNATURE-----

--3vhsml6d66uwdycg--
