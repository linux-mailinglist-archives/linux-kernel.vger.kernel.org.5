Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15963757610
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGRIBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjGRIA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:00:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751F41FEE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:00:16 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLfao-0005y5-CC; Tue, 18 Jul 2023 09:57:58 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 51F291F3ED5;
        Tue, 18 Jul 2023 07:57:50 +0000 (UTC)
Date:   Tue, 18 Jul 2023 09:57:49 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
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
Subject: Re: [PATCH v2 5/6] can: tcan4x5x: Add support for tcan4552/4553
Message-ID: <20230718-marigold-violation-8d40e9d264c2-mkl@pengutronix.de>
References: <20230621093103.3134655-1-msp@baylibre.com>
 <20230621093103.3134655-6-msp@baylibre.com>
 <32557326-650c-192d-9a82-ca5451b01f70@linaro.org>
 <20230621123158.fd3pd6i7aefawobf@blmsp>
 <21f12495-ffa9-a0bf-190a-11b6ae30ca45@linaro.org>
 <20230622122339.6tkajdcenj5r3vdm@blmsp>
 <e2cc150b-49e3-7f2f-ce7f-a5982d129346@linaro.org>
 <20230627142300.heju4qccian5hsjk@blmsp>
 <e5bd4f01-0b00-4d70-c642-4fdfc0a139fc@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="74iwm2jmiacg2jdx"
Content-Disposition: inline
In-Reply-To: <e5bd4f01-0b00-4d70-c642-4fdfc0a139fc@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--74iwm2jmiacg2jdx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.07.2023 10:34:00, Krzysztof Kozlowski wrote:
> On 27/06/2023 16:23, Markus Schneider-Pargmann wrote:
>=20
> >>> The version information is always readable for that chip, regardless =
of
> >>> state and wake GPIOs as far as I know. So yes it is possible to setup
> >>> the GPIOs based on the content of the ID register.
> >>>
> >>> I personally would prefer separate compatibles. The binding
> >>> documentation needs to address that wake and state GPIOs are not
> >>> available for tcan4552/4553. I think having compatibles that are for
> >>> these chips would make sense then. However this is my opinion, you are
> >>> the maintainer.
> >>
> >> We do not talk about compatibles in the bindings here. This is
> >> discussion about your driver. The entire logic of validating DTB is
> >> flawed and not needed. Detect the variant and act based on this.
> >=20
> > I thought it was about the bindings, sorry.
> >=20
> > So to summarize the compatibles ti,tcan4552 and ti,tcan4553 are fine.
> > But the driver should use the ID register for detection and not compare
> > the detected variant with the given compatible?
> >=20
> > In my opinion it is useful to have an error messages that says there is
> > something wrong with the devicetree as this can be very helpful for the
> > developers who bringup new devices. This helps to quickly find issues
> > with the devicetree.
>=20
> That's not a current policy for other drivers, so this shouldn't be
> really special. Kernel is poor in validating DTS. It's not its job. It's
> the job of the DT schema.

Fine with me.

I decided to have a check of the auto-detected chip variant against the
specified one in the mcp251xfd driver, as it widely used with raspi
boards, where commonly DT overlays are used. It also helps remote
diagnostics of people, who don't focus on kernel development.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--74iwm2jmiacg2jdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS2RfoACgkQvlAcSiqK
BOj47Af7B3Hdzd2/p1G8Qprj/lvOLWeZU5GsBj4CDxEtl62ZGZUusqFDMpPC0lTS
TrrEcTZBT9Uozu1YdUTXzLWds6qD8vR9XoK5bq1PpXuF/0pcxFeOVodE14FhPYYu
plLFed2tRYmQkcksXLgNQh8UPhVC44O7BOHlvHgTl+9ew27r1MKG2Aeb3BsPDDXq
o0mck7GdJ7mTejPZDktkBhhyLbzYMSyn5PgdZMPgMR/5SGcCX38JiXUxWrSjD2jt
7Tg7NiYyj3dyzaqzWFRUJgyJkifirMS+8rNRPUq8vZFvQGq80TdENuzsKibCS0xu
+PQFb7a+suiwV9hwL9FvrfsOlY4Gsw==
=HGF4
-----END PGP SIGNATURE-----

--74iwm2jmiacg2jdx--
