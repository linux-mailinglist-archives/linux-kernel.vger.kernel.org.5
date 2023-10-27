Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F100D7D99A9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345637AbjJ0NXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjJ0NXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:23:17 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6563C128
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:23:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qwMns-0002DL-2O; Fri, 27 Oct 2023 15:23:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qwMnp-004eW6-Ek; Fri, 27 Oct 2023 15:23:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qwMnp-007LID-4k; Fri, 27 Oct 2023 15:23:05 +0200
Date:   Fri, 27 Oct 2023 15:23:05 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v6 2/4] pwm: opencores: Add PWM driver support
Message-ID: <20231027132305.u6ompbbqd35gjrrw@pengutronix.de>
References: <20231020103741.557735-1-william.qiu@starfivetech.com>
 <20231020103741.557735-3-william.qiu@starfivetech.com>
 <20231020112539.gctx5uj2rrhryulo@pengutronix.de>
 <b2ef7299-5d5a-4ef7-89fd-04b6130cb227@starfivetech.com>
 <20231024114545.73ljfceuon2blkxz@pengutronix.de>
 <e3faaa46-896a-405d-ac5f-97587e81fba4@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3qmjtkogiqqwe4cm"
Content-Disposition: inline
In-Reply-To: <e3faaa46-896a-405d-ac5f-97587e81fba4@starfivetech.com>
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


--3qmjtkogiqqwe4cm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello William,

On Fri, Oct 27, 2023 at 06:23:58PM +0800, William Qiu wrote:
> [...]
> Maybe depend on STARFIVE'S SoCs first?

If these are for now the only known implementers, that sounds about
right.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3qmjtkogiqqwe4cm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU7ubgACgkQj4D7WH0S
/k4Pzwf8DKveomYTnI/qtW/+NJ/bbFuOW4Ide3qKtQ75kpEVkbIHu/l+ymXJ1TMv
NjGjmLOXLajnz7Qzsvndobrvj6dFXA4uXlWfJCgommhS/RzwBOz8ndQj/KG7WjsM
E0U0HSMa/118tZJJxyWc2im29ZauxsGeyTifffuMVdEztcpxcQgiu4tHH4SBMa/h
LulGyro0VZ1sxOb4GWVt9t6jfSD07Ya+0WPXedmbWFSMcPVXxBmr6PViuAywk9By
HTW5Ml+hKwp6Ca8nQhukElFK1R0m/ZvqOA9+WKlIzt1BwL2q5r7nd2NsWJ03yP5d
fJA98G2UirMdGOT14zi9URiFnHKZkQ==
=B7Fc
-----END PGP SIGNATURE-----

--3qmjtkogiqqwe4cm--
