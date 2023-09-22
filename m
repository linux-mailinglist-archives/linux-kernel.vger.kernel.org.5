Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0007AA944
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjIVGrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVGra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:47:30 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9A9102
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:47:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjZwR-0004KT-P2; Fri, 22 Sep 2023 08:47:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjZwN-0086Rh-Ok; Fri, 22 Sep 2023 08:47:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjZwN-003oy9-DY; Fri, 22 Sep 2023 08:47:03 +0200
Date:   Fri, 22 Sep 2023 08:47:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     John Watts <contact@jookia.org>
Cc:     Aleksandr Shubin <privatesub2@gmail.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 0/3] Add support for Allwinner PWM on D1/T113s/R329
 SoCs
Message-ID: <20230922064704.hlytxjyjo4rekjux@pengutronix.de>
References: <20230824114038.891493-1-privatesub2@gmail.com>
 <ZPfn-0OAL7-3DCmt@titan>
 <20230921212736.nw6ctlimtrxfksbu@pengutronix.de>
 <ZQy3F_VtOL3XWcl0@titan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bww26scqrw5ezmb2"
Content-Disposition: inline
In-Reply-To: <ZQy3F_VtOL3XWcl0@titan>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bww26scqrw5ezmb2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey John,

On Fri, Sep 22, 2023 at 07:35:19AM +1000, John Watts wrote:
> On Thu, Sep 21, 2023 at 11:27:36PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hi John,
> >=20
> > On Wed, Sep 06, 2023 at 12:46:19PM +1000, John Watts wrote:
> > > On Thu, Aug 24, 2023 at 02:40:24PM +0300, Aleksandr Shubin wrote:
> > > > This series adds support for PWM controller on new
> > > > Allwinner's SoCs, such as D1, T113s and R329. The implemented driver
> > > > provides basic functionality for control PWM channels.
> > >=20
> > > I have tested this patch and earlier versions successfully on a Mango=
 Pi MQ
> > > Dual and verified it outputs a PWM signal.
> >=20
> > If you want that documented, the usual thing to do is to include a
> > Tested-by: tag in your reply.
>=20
> That's a good idea! I'll take a closer look under a scope and against the=
 data
> sheet and give another tested-by then when I can. I'm not sure how close =
that
> gets to a reviewed-by but I don't have the experience in driver developme=
nt to
> know if something is off in the design.

Tested-by has little to nothing to do with development or review. If you
tested that patch and it worked for you, that's enough to give such a
tag.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bww26scqrw5ezmb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUNOGcACgkQj4D7WH0S
/k5rHwf/WlCqmSa7FGJOCv1iloPyW8uz1VP/sNtNI2shOtERwNwaZ4iocMFo/o8I
LMITmzxh2ZgB34KBWh96Qy5i3BvvnU7Fzjy6t3OpR0+hjVCy7/LvgKtlA7q9VEb/
tpenCJ38H4rWdTPUsX2OnWOeCfVIvc6Lh7HzUwX/01ekwVbni3MxczQ12CsV3/yC
DIWTheVJrpQHYT9a7qNlzFDralW3MeJrthV04iWvoOpyLMvmx7d0vN5KwlWrMwb2
bPqgcVOmHnUj3lYPjFVQh8cb4E4DGd0P1QNS8S4gfosRfcMkWq16ymwUVOgSB8+/
w6DynP75YpVgCXDeg6SYfoL4HF1iTQ==
=v75W
-----END PGP SIGNATURE-----

--bww26scqrw5ezmb2--
