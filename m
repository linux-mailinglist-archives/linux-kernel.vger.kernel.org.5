Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569EC7B372B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjI2PoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjI2PoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:44:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06550B4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:44:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmFey-0001ZK-TE; Fri, 29 Sep 2023 17:44:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmFew-009qZE-OP; Fri, 29 Sep 2023 17:44:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmFew-0060XG-Ef; Fri, 29 Sep 2023 17:44:06 +0200
Date:   Fri, 29 Sep 2023 17:44:06 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH 6/6] serial: imx: do not set RS485 enabled if it is not
 supported
Message-ID: <20230929154406.c2xvll4iecd6nq5e@pengutronix.de>
References: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
 <20230928221246.13689-7-LinoSanfilippo@gmx.de>
 <20230929063942.qukemr4o7l5vdmud@pengutronix.de>
 <8fac0a79-cf0b-f35b-4e5e-e8f502bb5367@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nopdae4ryx4v5ekg"
Content-Disposition: inline
In-Reply-To: <8fac0a79-cf0b-f35b-4e5e-e8f502bb5367@gmx.de>
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


--nopdae4ryx4v5ekg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lino,

On Fri, Sep 29, 2023 at 03:46:52PM +0200, Lino Sanfilippo wrote:
> On 29.09.23 08:39, Uwe Kleine-K=F6nig wrote:
> > On Fri, Sep 29, 2023 at 12:12:46AM +0200, Lino Sanfilippo wrote:
> >> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >
> > I don't know how picky Greg is here, but formally you missed to add an
> > S-o-b line for the sender of this patch (i.e. you with your gmx
> > address).
> >
>=20
> Hm, until now there have never been complaints about this. Is this really=
 an issue? Of
> course I can also S-o-b with my gmx address but adding two S-o-b's for th=
e same person seems
> a bit odd to me...

The obvious and easy fix is of course to use the author address to send
the patches. :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nopdae4ryx4v5ekg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUW8MUACgkQj4D7WH0S
/k7fFgf/VtW24r6XZ/vfBGnv50SL4uW1TpgvNgOSKJbZATkxzxBr1V+FnxXG30Ip
vf9ptBnSAIajdgxU6BLqrDe19QaXZWQE5QMxvGsR4LZtAWQ7553NhtcPSE6czgW0
vqQlP/X5x48PMyCojx+1Ntsf21NXrwSIkUkEP4oHF54XfesWyOErL9z6MZ00HK8X
6/vQ3LA1mpnwuAI+AE23lHjciyLR0jJA1aXKKF5szFN4HW72ADc/BzcsUmSQTctO
d2ZO8kGs/tiJ4+3+I80cqcC+3+8CQXKflPEz/77MPwxCo25FSc02Yz2TjO+0Yq5v
JPpeYh2hmpN54n8Bgb3uRS8TrNiRkg==
=86ry
-----END PGP SIGNATURE-----

--nopdae4ryx4v5ekg--
