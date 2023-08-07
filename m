Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F72771B5F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjHGHRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjHGHRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:17:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39F31BDB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 00:17:13 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qSuTs-0008Tg-09; Mon, 07 Aug 2023 09:16:44 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 192BD20588D;
        Mon,  7 Aug 2023 07:16:42 +0000 (UTC)
Date:   Mon, 7 Aug 2023 09:16:41 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     John Watts <contact@jookia.org>,
        Maksim Kiselev <bigunclemax@gmail.com>, aou@eecs.berkeley.edu,
        conor+dt@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, edumazet@google.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, netdev@vger.kernel.org,
        pabeni@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        robh+dt@kernel.org, samuel@sholland.org, wens@csie.org,
        wg@grandegger.com
Subject: Re: [PATCH v2 2/4] riscv: dts: allwinner: d1: Add CAN controller
 nodes
Message-ID: <20230807-denatured-gangrene-e6f37ba5f9ef-mkl@pengutronix.de>
References: <20230721221552.1973203-4-contact@jookia.org>
 <2690764.mvXUDI8C0e@jernej-laptop>
 <ZM8-yfRVscYjxp2p@titan>
 <4848155.31r3eYUQgx@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="knn54obranxnvfa4"
Content-Disposition: inline
In-Reply-To: <4848155.31r3eYUQgx@jernej-laptop>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--knn54obranxnvfa4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.08.2023 13:42:28, Jernej =C5=A0krabec wrote:
> Dne nedelja, 06. avgust 2023 ob 08:33:45 CEST je John Watts napisal(a):
> > On Sat, Aug 05, 2023 at 07:49:51PM +0200, Jernej =C5=A0krabec wrote:
> > > Dne sobota, 05. avgust 2023 ob 18:51:53 CEST je John Watts napisal(a):
> > > > On Sat, Aug 05, 2023 at 07:40:52PM +0300, Maksim Kiselev wrote:
> > > > > Hi John, Jernej
> > > > > Should we also keep a pinctrl nodes itself in alphabetical order?
> > > > > I mean placing a CAN nodes before `clk_pg11_pin` node?
> > > > > Looks like the other nodes sorted in this way...
> > > >=20
> > > > Good catch. Now that you mention it, the device tree nodes are sort=
ed
> > > > by memory order too! These should be after i2c3.
> > > >=20
> > > > It looks like I might need to do a patch to re-order those too.
> > >=20
> > > It would be better if DT patches are dropped from netdev tree and then
> > > post
> > > new versions.
> > >=20
> > > Best regards,
> > > Jernej
> >=20
> > Agreed. Is there a way to request that? Or will the maintainer just read
> > this?
>=20
> Hopefully it will.

I'm just catching up on last week's post (I had a long off-line
weekend).

I'll revert the DT changes and send a PR to net-next.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--knn54obranxnvfa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTQmlYACgkQvlAcSiqK
BOgEOAf/fUZfi2B2HANlxUlb4fdyka/TP5ZLHNHvg7p3zeXtN/14VVOHERsUPbXh
Kldv7yC7b/fwT8eNXA00kF7stor8jzf2pmRnH0O1Nq/OeOezlf6neZxWwzitGCbL
qWYirtSsJw5oN4Q/hxohHL2y9CX2jCXK9f6TQ3eMzr2vhXCrtDxLKPBaL0Abb1qv
vRdIDpQtXYpYWsXXlP1Fw9PArbvZ3mDVFDnBpYIri/nt7wX+TYveOjVOn1h8W+Im
dbFqaDjgwOe4SWL2oWpVMQAWOAs4gCM3af9aC/zcXbYXnEHZduRWlPs/g9kNo13L
IP3YMj70efZqX1eHk2reC0R/Ppf/Xw==
=TA6D
-----END PGP SIGNATURE-----

--knn54obranxnvfa4--
