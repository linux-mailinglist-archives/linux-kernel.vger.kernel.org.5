Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BE37CA59E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjJPKjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPKjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:39:17 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1405DC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:39:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qsL03-00053y-82; Mon, 16 Oct 2023 12:39:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qsL01-0023rC-3p; Mon, 16 Oct 2023 12:39:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qsL00-00H9OI-Qc; Mon, 16 Oct 2023 12:39:00 +0200
Date:   Mon, 16 Oct 2023 12:38:56 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v3 0/6] Fixes and improvements for RS485
Message-ID: <20231016103856.d2i2nk5ubaeqpd6a@pengutronix.de>
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
 <0ca84efc-c999-4077-85aa-e13fd0984182@kunbus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ledji7kb3pwli75k"
Content-Disposition: inline
In-Reply-To: <0ca84efc-c999-4077-85aa-e13fd0984182@kunbus.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ledji7kb3pwli75k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lino,

On Sun, Oct 15, 2023 at 03:03:20PM +0200, Lino Sanfilippo wrote:
> Sorry Uwe, you gave valuable input for the former version of this series =
and I
> just noticed now that I forgot to Cc you for this version.=20

My mail setup works good enough that this series already landed in my
inbox without the explict Cc, but I'm currently doing too much other
stuff to find the time for an appropriate look here, sorry.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ledji7kb3pwli75k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUtEr8ACgkQj4D7WH0S
/k6z/gf9G7mcEVUtd7B3pBLcscJ8i8p/kb6s5QAq6eXp2zAoQD5L+++GTNXPxr5O
12H1DX0B8Q58LFI3fI9OcGGCe8TbMD0LSTB7t97g935yAoopjs+0yQcWL2a21F8w
uzhk67DEmUGPBRzKV4fRCEaKUBAc5fFahfYyC+Bz/TQxgxcAAVG562LFw+i2vS6E
W5CCQuU0aSJavGwDE4ghrDlfrs21pFFLn52STwW9iyLY2el9Y0fFpa2rqUJxb/AR
dWd5WGOR0+Z1EkLf8+4sacTFQALWPFmSKKOM/R+wOU23NPLyB0YBmo9Ftj/77cgo
xCT/S9mNMy2AQOMExF+i2YwnDicD+w==
=47/E
-----END PGP SIGNATURE-----

--ledji7kb3pwli75k--
