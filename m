Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2012A809ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbjLHJIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjLHJIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:08:05 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4978910FC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:08:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBWpx-0005lS-NY; Fri, 08 Dec 2023 10:07:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBWpv-00ENVi-0n; Fri, 08 Dec 2023 10:07:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rBWpu-00GLG5-NU; Fri, 08 Dec 2023 10:07:54 +0100
Date:   Fri, 8 Dec 2023 10:07:54 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Ian Ray <ian.ray@ge.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        kernel@collabora.com, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCHv5 0/2] Fix imx53-ppd UART configuration
Message-ID: <20231208090754.fn3bddlum3t7kakn@pengutronix.de>
References: <20210430175038.103226-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rhppgyqd7t7ywrip"
Content-Disposition: inline
In-Reply-To: <20210430175038.103226-1-sebastian.reichel@collabora.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rhppgyqd7t7ywrip
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc +=3D dt maintainers]

On Fri, Apr 30, 2021 at 07:50:36PM +0200, Sebastian Reichel wrote:
> IMHO PATCHv4 was better, but in the end I don't have strong feelings
> about this. Btw. I think this patchset is a good demonstration of
> frustrating upstream kernel development can be considering PATCHv5
> is basically the same as PATCHv1. Thanks for making us go in
> circles :(

I still like v4 better than v1/v5. I'm sorry for the frustration this
created on your side.=20

I'd ask Greg to reconsider given that dt is less flexible than a sysfs
knob and otherwise shares all downsides of sysfs (people don't want to
have to tune that, so a useful default for most cases is important; you
have to consult documentation to understand how to tune it).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rhppgyqd7t7ywrip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVy3OkACgkQj4D7WH0S
/k6ZMAf/bJ6Do/+Ap+RHZnbjCMELrpCx+6h7f7pnGXD8hqftIz+Ysir0aF+kBCFH
GdEtc/ct9nQi9SYsT1u18+UFG/roD/WoNLQ72Elr46CopNsRnHBNKmDA/VgS0xW/
um8qYbF+aEFkyZgS2NKT0bzkjpMSDnNYu2IZQr2keCLmQQAbLOp8bELi3oX2JuJT
fjHusoMT3abd0ZQm3kY+CUVJ+ROkUl/8yi7TZTnLN0NTH8JSudB1euakrEV0bhOc
KW6GMif04RK75PWPUunvlrxyPD2Pje2I9G3K6vsp8mXDIffeI5GyhH51wD3YKOe7
mIaJ6GBw0+ASbVw7fErVyzxIf5SzdQ==
=BHUP
-----END PGP SIGNATURE-----

--rhppgyqd7t7ywrip--
