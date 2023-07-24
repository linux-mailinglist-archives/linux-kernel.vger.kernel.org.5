Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968C375ED8F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjGXI2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjGXI20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:28:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF8710FD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:28:19 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qNquo-0007RN-JQ; Mon, 24 Jul 2023 10:27:38 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 53E021F8389;
        Mon, 24 Jul 2023 08:27:33 +0000 (UTC)
Date:   Mon, 24 Jul 2023 10:27:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     John Watts <contact@jookia.org>
Cc:     linux-sunxi@lists.linux.dev,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/4] Add support for Allwinner D1 CAN controllers
Message-ID: <20230724-paving-pep-4c3ca2fae261-mkl@pengutronix.de>
References: <20230721221552.1973203-2-contact@jookia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bzzg2zjmqpjfr7ls"
Content-Disposition: inline
In-Reply-To: <20230721221552.1973203-2-contact@jookia.org>
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


--bzzg2zjmqpjfr7ls
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.07.2023 08:15:49, John Watts wrote:
> This patch series adds support for the Allwinner D1 CAN controllers.
> It requires adding a new device tree compatible and driver support to
> work around some hardware quirks.
>=20
> This has been tested on the Mango Pi MQ Dual running a T113 and a Lichee
> Panel 86 running a D1.

Applied to linux-can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bzzg2zjmqpjfr7ls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS+NfAACgkQvlAcSiqK
BOg8Kgf/eJt24Ndvcmh6L+eNtFLgI9sT0zZeRNAKl9MJzbRclkN9kj5PSwfjjXt9
UyBuvnxjyHDs81oanjq0yLh673plo1Q+PH2S9bx2q0GuWxudK8fIS7K6C3FBO5EI
cvoAK6cyy33+7LUR7X7w0/0cs8jPUS8znJh7iw3fhr+R9fW+uTzoMDxQsDi9duf7
OPTBCOiiAnBajqy16/sxFHIyUFAHWYGs0RCgGEu1g4oW8JyPAr4lznp2wEYAPVeX
oNjCnvJrfNPTqFbIKV9dY8GaYA765qy11toqYmpv/WCxMAOKO52ElS0dko5+nt8S
ykN0k7XY6EzIqvbjvWh8AzhNvO8Gog==
=cUGJ
-----END PGP SIGNATURE-----

--bzzg2zjmqpjfr7ls--
