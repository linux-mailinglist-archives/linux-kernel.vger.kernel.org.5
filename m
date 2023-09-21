Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EF57AA307
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjIUVqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjIUVpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:45:50 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4F81B140
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 14:27:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjRD0-0005ek-10; Thu, 21 Sep 2023 23:27:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjRCy-00816y-1P; Thu, 21 Sep 2023 23:27:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjRCx-003jNA-Nt; Thu, 21 Sep 2023 23:27:35 +0200
Date:   Thu, 21 Sep 2023 23:27:36 +0200
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
Message-ID: <20230921212736.nw6ctlimtrxfksbu@pengutronix.de>
References: <20230824114038.891493-1-privatesub2@gmail.com>
 <ZPfn-0OAL7-3DCmt@titan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hsej65iwiu4uzzgq"
Content-Disposition: inline
In-Reply-To: <ZPfn-0OAL7-3DCmt@titan>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hsej65iwiu4uzzgq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

On Wed, Sep 06, 2023 at 12:46:19PM +1000, John Watts wrote:
> On Thu, Aug 24, 2023 at 02:40:24PM +0300, Aleksandr Shubin wrote:
> > This series adds support for PWM controller on new
> > Allwinner's SoCs, such as D1, T113s and R329. The implemented driver
> > provides basic functionality for control PWM channels.
>=20
> I have tested this patch and earlier versions successfully on a Mango Pi =
MQ
> Dual and verified it outputs a PWM signal.

If you want that documented, the usual thing to do is to include a
Tested-by: tag in your reply.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hsej65iwiu4uzzgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUMtUcACgkQj4D7WH0S
/k6buwf6A0Hc5i21Amtcab5twrhrw6hQ6A5Ooz+1y2NkTKoC1LfIo7H3TlzWFbE0
9v6vTPc5eeLTrrEvqyuklZj4ZeOfQ59QP8J28sITll556Mexp3qZE2UeEsJ+WWnQ
VhotAXjZk0kIxPwYlYtpNRuFIu77UapAGa1fIAbCE+YkWe1gylM0C9U4BoN5Bwt0
YfeNGDLxtFg4fnkdFryQnnt+XdJyZZoP3zyxek759tHYwlV+zyYGtQnqkFrve8O3
/1ulltb5AMO19uiVuefYGW14yKzs2fQQKHvphjHnLAPd3pvio49reLiFmMIbBVoo
mcSTWHcLZyx4+qyDqk1pKuC4hprirg==
=WRok
-----END PGP SIGNATURE-----

--hsej65iwiu4uzzgq--
