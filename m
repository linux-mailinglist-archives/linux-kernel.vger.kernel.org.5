Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C73755C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjGQHHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjGQHHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:07:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE95131
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:07:18 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLIK1-00012q-9t; Mon, 17 Jul 2023 09:07:05 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 144561F3074;
        Mon, 17 Jul 2023 07:07:03 +0000 (UTC)
Date:   Mon, 17 Jul 2023 09:07:02 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Wu Yunchuan <yunchuan@nfschina.com>
Cc:     wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, uttenthaler@ems-wuensche.com,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v3 8/9] can: ems_pci: Remove unnecessary (void*)
 conversions
Message-ID: <20230717-clash-kerchief-afdf910e2ce6-mkl@pengutronix.de>
References: <20230717031221.55073-1-yunchuan@nfschina.com>
 <20230717-staple-uninjured-26bfd8cde5e0-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5dxaakn7dnfa335u"
Content-Disposition: inline
In-Reply-To: <20230717-staple-uninjured-26bfd8cde5e0-mkl@pengutronix.de>
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


--5dxaakn7dnfa335u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.07.2023 08:52:42, Marc Kleine-Budde wrote:
> On 17.07.2023 11:12:21, Wu Yunchuan wrote:
> > No need cast (void*) to (struct ems_pci_card *).
> >=20
> > Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
> > Acked-by: Marc Kleine-Budde<mkl@pengutronix.de>
>=20
> Please add a space between my name and my e-mail address, so that it
> reads:
>=20
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> nitpick:
> You should add your S-o-b as the last trailer.

BTW: The threading of this series is still broken. Make sure you send
the whole patch series with one single "git send-email" command. For
regular contribution you might have a look at the "b4" [1] tool.

regards,
Marc

[1] https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-p=
art-1

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5dxaakn7dnfa335u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS06JMACgkQvlAcSiqK
BOhunAgAq7HhqkHTxzfDvHIyljEnoxxDKpnB50lo14yvrgK7CjVNC0EMdtrE7+7e
B8M9yaSCN5jOnXAMX/kc0w5nxe8rdR1r13UUoY6gnO8+NiP0k5X3DnWpVVEYWOaY
gh8WuC7B2hFE1ZhICcDMI7xyUtsfs7FjoblBiTSPxt22umW8Viath5NQRWf1DbJO
N+KJnHCPseaOC3YMOtWhFVfSkfvS03NpmpBbp50saBpo/9fcVKNAnlfFaN9uQZS2
70PGkPxbMbeaXqva0TbHBkLoHU564Az/zY2ScKg9Qu1LCO+kb78vTNoGjggHUEge
JS/C7tEFt766dMJGJ2ZRxnYAoeWxxQ==
=PR62
-----END PGP SIGNATURE-----

--5dxaakn7dnfa335u--
