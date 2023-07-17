Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C928375674D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjGQPOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjGQPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:14:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7246A10A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:14:51 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLPvj-0001fz-8q; Mon, 17 Jul 2023 17:14:31 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 782A31F3778;
        Mon, 17 Jul 2023 15:14:28 +0000 (UTC)
Date:   Mon, 17 Jul 2023 17:14:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Judith Mendez <jm@ti.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Schuyler Patton <spatton@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v10 0/2] Enable multiple MCAN on AM62x
Message-ID: <20230717-deprecate-happy-34e1dadb8161-mkl@pengutronix.de>
References: <20230707204714.62964-1-jm@ti.com>
 <20230710-overheat-ruined-12d17707e324-mkl@pengutronix.de>
 <ZLEckxW0oLklkMtn@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m344sizttoq6ws4c"
Content-Disposition: inline
In-Reply-To: <ZLEckxW0oLklkMtn@francesco-nb.int.toradex.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m344sizttoq6ws4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.07.2023 11:59:47, Francesco Dolcini wrote:
> Hello Mark,
>=20
> On Mon, Jul 10, 2023 at 11:57:51AM +0200, Marc Kleine-Budde wrote:
> > On 07.07.2023 15:47:12, Judith Mendez wrote:
> > > On AM62x there are two MCANs in MCU domain. The MCANs in MCU domain
> > > were not enabled since there is no hardware interrupt routed to A53
> > > GIC interrupt controller. Therefore A53 Linux cannot be interrupted
> > > by MCU MCANs.
> ...
>=20
> > Applied to linux-can-next/testing.
>=20
> Did you forgot to push your changes out? Nothing here
> git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git

Sorry for the delay. I've not updated the testing branch on
linux-can-next.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--m344sizttoq6ws4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS1WtEACgkQvlAcSiqK
BOjH6wgAqGk/kA2iQOQJmRGla0/6nu5OmWnaZkx/c/Exxjoyn2oPl6va6xi5Fhwj
PXt6GIG0O0AZl7h8YeSnd9y9YG2MjQFJAhlhxHbvsPrs9M15Afgra2L1Nca2eO7F
LX3JfjeZaCrSOk9WcF02x3x7eEQmFdDpZybuJ5AJ3+VCYqsUleoPdbrcPkea7aVQ
uJwVOj6h+TIasp818Gb4CcxBjFuhekjUTt6BMe/onGavqF8wowdD3g87IeMa+9VJ
4KoutBVSxkRbCDhIozr0Tl1i1S4muhkt+H/uvYzLn14EMFKgXHZDdRqJ+bOoELSv
45yGOHP9mDmzBqzMxEDawWibmHemIA==
=mMf8
-----END PGP SIGNATURE-----

--m344sizttoq6ws4c--
