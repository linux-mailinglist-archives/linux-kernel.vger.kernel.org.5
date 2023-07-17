Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F72B75671F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGQPEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjGQPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:04:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D240410DC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:04:33 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLPlq-0000FH-8h; Mon, 17 Jul 2023 17:04:18 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E0CE11F3756;
        Mon, 17 Jul 2023 15:04:16 +0000 (UTC)
Date:   Mon, 17 Jul 2023 17:04:16 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/2] can: xilinx_can: Add support for reset
Message-ID: <20230717-acronym-surging-27c99c0a1aa4-mkl@pengutronix.de>
References: <cover.1689164442.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i6dff7kuru4cvcda"
Content-Disposition: inline
In-Reply-To: <cover.1689164442.git.michal.simek@amd.com>
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


--i6dff7kuru4cvcda
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.07.2023 14:20:44, Michal Simek wrote:
> Hi,
>=20
> IP core has option reset line which can be wired that's why add support
> for optional reset.
>=20
> Thanks,
> Michal
>=20
> Changes in v2:
> - Add Conor's ACK
> - Fix use-after-free in xcan_remove reported by Marc.

Added to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--i6dff7kuru4cvcda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS1WG0ACgkQvlAcSiqK
BOgFNQf/SNgtjQihhGSwxvLoga11wYHClkMTuB7ZGEKSMQMpnvsa/qu5oOE7+pXJ
bZq8nO9zrrBNsrmv500c8kDZDSGKenZdbT8QBDuCfmirh5YbQqEfBnL8Zos/s7Tq
QkVzsVj+e6kMeIImbNqHpGqdn9p5zxxWsgb8EDiKMXIoUeU9KUiwPCCIiKRzEjPi
MgOJpsVvPSYxQ/IRPUcVZ2ebzmuQHbvW1QKlFfRvY/N4AggPgFFPSukTg/jrVdmY
sZ7M2H9CjZEbMobh8RlNo/+vxeoBRLhEEvuLxE9Ex/6y7Gqh1/4w/uGfxxpqiM7s
dad1BzbRZp48K21DiDN2QOJnhpOVfA==
=oPZ5
-----END PGP SIGNATURE-----

--i6dff7kuru4cvcda--
