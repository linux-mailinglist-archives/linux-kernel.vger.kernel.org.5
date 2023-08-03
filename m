Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B53876F1B2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjHCSR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjHCSRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:17:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19012708
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:17:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRcsX-0005L1-1E; Thu, 03 Aug 2023 20:16:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRcsQ-000tz3-N9; Thu, 03 Aug 2023 20:16:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRcsP-00ACyp-TG; Thu, 03 Aug 2023 20:16:45 +0200
Date:   Thu, 3 Aug 2023 20:16:40 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ioana Ciornei <ciorneiioana@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andre Edich <andre.edich@microchip.com>,
        Antoine Tenart <atenart@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Divya Koppera <Divya.Koppera@microchip.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Kresin <dev@kresin.me>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Michael Walle <michael@walle.cc>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nisar Sayed <Nisar.Sayed@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Willy Liu <willy.liu@realtek.com>,
        Yuiko Oshino <yuiko.oshino@microchip.com>
Subject: Re: [PATCH net-next v2 02/19] net: phy: add a shutdown procedure
Message-ID: <20230803181640.yzxsk2xphwryxww4@pengutronix.de>
References: <20201101125114.1316879-1-ciorneiioana@gmail.com>
 <20201101125114.1316879-3-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="emeii36judbalvyq"
Content-Disposition: inline
In-Reply-To: <20201101125114.1316879-3-ciorneiioana@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--emeii36judbalvyq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

this patch became commit e2f016cf775129c050d6c79483073423db15c79a and is
contained in v5.11-rc1.

It broke wake-on-lan on my NAS (an ARM machine with an Armada 370 SoC,
armada-370-netgear-rn104.dts). The used phy driver is marvell.c. I only
report it now as I just upgraded that machine from Debian 11 (with
kernel 5.10.x) to Debian 12 (with kernel 6.1.x).

Commenting out phy_disable_interrupts(...) in v6.1.41's phy_shutdown()
fixes the problem for me.

On Sun, Nov 01, 2020 at 02:50:57PM +0200, Ioana Ciornei wrote:
> In case of a board which uses a shared IRQ we can easily end up with an
> IRQ storm after a forced reboot.
>=20
> For example, a 'reboot -f' will trigger a call to the .shutdown()
> callbacks of all devices. Because phylib does not implement that hook,
> the PHY is not quiesced, thus it can very well leave its IRQ enabled.
>=20
> At the next boot, if that IRQ line is found asserted by the first PHY
> driver that uses it, but _before_ the driver that is _actually_ keeping
> the shared IRQ asserted is probed, the IRQ is not going to be
> acknowledged, thus it will keep being fired preventing the boot process
> of the kernel to continue. This is even worse when the second PHY driver
> is a module.
>=20
> To fix this, implement the .shutdown() callback and disable the
> interrupts if these are used.

I don't know how this should interact with wake-on-lan, but I would
expect that there is a way to fix this without reintroducing the problem
fixed by this change. However I cannot say if this needs fixing in the
generic phy code or the phy driver. Any hints?
=20
> Note that we are still susceptible to IRQ storms if the previous kernel
> exited with a panic or if the bootloader left the shared IRQ active, but
> there is absolutely nothing we can do about these cases.

I'd say the bootloader could handle that, knowing that for some machines
changing the bootloader isn't an option.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--emeii36judbalvyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTL7v4ACgkQj4D7WH0S
/k43fQf+LtN8CtvFjSQCPcsJOwWkPa26gDEwrQDGnxYUjOqh3CdgKVV7zp577Cba
/u8Jj55aA7bYCyBlC3AYsN6sqCR73+9WHEe6dukmV6neiPDWbtWpQ/4GuwESQCOT
GuB2fszBc6pVN2NZbz4XOKiOraURewkw0+0n/P0dLyu2AyQP6NAzu0FoS4wim3v2
4o7IUqfxF4FbVco7cbRxysCBddaKcmdkiTKACZrUXedU4YQDniU2r2kUEiuvtogg
RifYN+rIVtg6TDU5/hMHEtNXWKvilblZlyC/RpSZDgQ2m0G+Fwqpx+XaVQ6BxYrW
a676/8ncIKLgJAIjfVrdxjK1EEVXDw==
=7n4Y
-----END PGP SIGNATURE-----

--emeii36judbalvyq--
