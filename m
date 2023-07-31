Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F50F768FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjGaITR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjGaISi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:18:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183B61718
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:16:32 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qQO4j-0007KX-1o; Mon, 31 Jul 2023 10:16:21 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 496151FEB03;
        Mon, 31 Jul 2023 08:16:20 +0000 (UTC)
Date:   Mon, 31 Jul 2023 10:16:19 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 05/10] can: slcan: remove casts from tty->disc_data
Message-ID: <20230731-playmate-character-475ae615a245-mkl@pengutronix.de>
References: <20230731080244.2698-1-jirislaby@kernel.org>
 <20230731080244.2698-6-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yztcseyamfs2bn76"
Content-Disposition: inline
In-Reply-To: <20230731080244.2698-6-jirislaby@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yztcseyamfs2bn76
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.07.2023 10:02:39, Jiri Slaby (SUSE) wrote:
> tty->disc_data is 'void *', so there is no need to cast from that.
> Therefore remove the casts and assign the pointer directly.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-can@vger.kernel.org
> Cc: netdev@vger.kernel.org

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--yztcseyamfs2bn76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTHbdEACgkQvlAcSiqK
BOh9/Af/THnCGoP37bgvvE65p0qzqzR//LspAtr3dZ8jCMQf12kthgFVpEAQnShe
8vvnSJXhXiFuIpBUB7nGXjnhkHLDnGX+kywVkJmQpKUWkwK1Jo75pCHIswPHTBE2
7wQkqyhKKyroUSpO7r3r8Fr1ZfH3b8Y/+fnwZtNkn7MXtURJBcrgHrbXUFMG0Pyd
pr6HvOCBDIZwn/HPPGPEnmafYbRn4d8FQl9Z21uCsG3pKVW+4Lc/IVs+SMoD++hU
qcipG4z4maGmN46y42s0V+qidixfZr3QMcxS3UbIRHOe80b1wjsDvrRv4pMb8izy
wlM9Au0ul7AI+NaZU6XphLgK9sjtIA==
=1Zek
-----END PGP SIGNATURE-----

--yztcseyamfs2bn76--
