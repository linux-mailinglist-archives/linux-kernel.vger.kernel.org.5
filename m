Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F308769801
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjGaNsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjGaNrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:47:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BDC198E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:47:47 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qQTF5-0006St-4V; Mon, 31 Jul 2023 15:47:23 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 454F01FEF91;
        Mon, 31 Jul 2023 13:47:19 +0000 (UTC)
Date:   Mon, 31 Jul 2023 15:47:18 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v4 0/6] can: tcan4x5x: Introduce tcan4552/4553
Message-ID: <20230731-issuing-unshackle-20c6cbcbca98-mkl@pengutronix.de>
References: <20230728141923.162477-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7hokiv2uomu6txmp"
Content-Disposition: inline
In-Reply-To: <20230728141923.162477-1-msp@baylibre.com>
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


--7hokiv2uomu6txmp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.07.2023 16:19:17, Markus Schneider-Pargmann wrote:
> Hi everyone,
>=20
> This series introduces two new chips tcan-4552 and tcan-4553. The
> generic driver works in general but needs a few small changes. These are
> caused by the removal of wake and state pins.
>=20
> v4 updates the printks to use '%pe'.

Applied to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7hokiv2uomu6txmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTHu2MACgkQvlAcSiqK
BOg63gf/cPN6GYr1ujcAtB5q3AHV/GbjB+1Bp8DkT1yzWjXkcPXvm44qr9AnhbBX
qF1UX4whquSeRDoKursw4/5h1THtdYHGIeM+kRa4jPUxB78b3i1AHWhMkuQQP/5h
RXn57V6mIqdFdF1VVAl7/y8fxj7JLLTwoaFIDjjuW5E5aXxLEnNmT2rs5Y/OMG2Z
jeG5Eip0Qu73qCBpVGUh0Wckya+K1b5xwQ2+BauCEzBg4/oCRx9RyIk7awlR6d26
FxZ9nan7AjmkrW/cury9qKGQLdfM31myDypXRl7+C4esJ00KDUvOJlt01E/THvaG
2NS6tk/FiCDV5Otlq3OmGaRfnuVLlA==
=9Hzu
-----END PGP SIGNATURE-----

--7hokiv2uomu6txmp--
