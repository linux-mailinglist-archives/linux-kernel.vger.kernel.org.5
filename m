Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7908377493D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjHHTue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjHHTuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:50:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2995A29B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:56:16 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qTNon-0005h7-To; Tue, 08 Aug 2023 16:36:17 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 825AC206CE6;
        Tue,  8 Aug 2023 14:36:11 +0000 (UTC)
Date:   Tue, 8 Aug 2023 16:36:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     John Watts <contact@jookia.org>, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] riscv: dts: allwinner: d1: Add CAN controller nodes
Message-ID: <20230808-outgoing-trifocals-ee5d44aea113-mkl@pengutronix.de>
References: <20230807191952.2019208-1-contact@jookia.org>
 <49ce2d9c-eb38-4ceb-bae1-0409df876e9b@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4nwq7phqlae7mco3"
Content-Disposition: inline
In-Reply-To: <49ce2d9c-eb38-4ceb-bae1-0409df876e9b@web.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4nwq7phqlae7mco3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.08.2023 16:26:17, Markus Elfring wrote:
> =E2=80=A6
> > Both of these fully support both CAN controllers.
>=20
> Please choose a corresponding imperative change suggestion.
>=20
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.5-rc5#n94
>=20
>=20
> > Signed-off-by: John Watts <contact@jookia.org>
>=20
> I find the local-part of this email address suspicious according to the D=
eveloper's Certificate of Origin.
> Should it usually indicate an unique person instead of the shown key word?

FYI: https://lore.kernel.org/all/20230718221504.GA2015343-robh@kernel.org

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4nwq7phqlae7mco3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTSUtgACgkQvlAcSiqK
BOhQSgf/Yqmf0f7tupRc/JJY1XEaKV/WZHCse/ijc2E8sbJdhF4F8eilfyDriOxt
6TRqL9fD0DcjKx9WR719GJm7CgigzwOJk0vj56seoQGtzqkVZg3qjARMOiHTlILS
UvIh6ZgNdGP0WmdAiB1ZO7p1imugZGua7gGihHobLLVOT4Ipa8AD/I9TQLo7LudX
zAhTYepqt3nxf0fxvTgqQc3I2lmtV/LuOViF2NxE2BiSNjPzpQxGyIAMElRaQg4D
RJdamfDLYuJletg5OFI6QMb0JmASUZlz7889cgGx+UGtSp+JWNviXxDq4bvoF8KC
MbYMhncSKCPdpTJYRLMLCxaaXGCF4w==
=4/vk
-----END PGP SIGNATURE-----

--4nwq7phqlae7mco3--
