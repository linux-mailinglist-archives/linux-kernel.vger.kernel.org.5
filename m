Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E61755C40
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGQG51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjGQG5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:57:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14861737
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:56:38 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLI8r-0008Cg-5s; Mon, 17 Jul 2023 08:55:33 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4DF321F304F;
        Mon, 17 Jul 2023 06:52:43 +0000 (UTC)
Date:   Mon, 17 Jul 2023 08:52:42 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Wu Yunchuan <yunchuan@nfschina.com>
Cc:     wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, uttenthaler@ems-wuensche.com,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v3 8/9] can: ems_pci: Remove unnecessary (void*)
 conversions
Message-ID: <20230717-staple-uninjured-26bfd8cde5e0-mkl@pengutronix.de>
References: <20230717031221.55073-1-yunchuan@nfschina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="exgeui6fqooldnrg"
Content-Disposition: inline
In-Reply-To: <20230717031221.55073-1-yunchuan@nfschina.com>
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


--exgeui6fqooldnrg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.07.2023 11:12:21, Wu Yunchuan wrote:
> No need cast (void*) to (struct ems_pci_card *).
>=20
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
> Acked-by: Marc Kleine-Budde<mkl@pengutronix.de>

Please add a space between my name and my e-mail address, so that it
reads:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

nitpick:
You should add your S-o-b as the last trailer.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--exgeui6fqooldnrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS05TcACgkQvlAcSiqK
BOjxXgf/fNhyeUfgj8a3UOgD2T2AhNRSX5zoNVMqZeFacwtVKuGO4IB+9oZ/0cUC
1v5ogKr088Bw5tFggQ1Yu0y32lUgh+/kci6S+EkjNKwiVJPGoF/7z0uPDOvBkBzT
fY6rRKe9+XTNHBDFka/6yKelQlfbrZmoDUdZuyINKlKeuzCctPhhOzR+ZNL8N4mP
UNGVEmKO57EuCzmSXPN9oP+FeqeP+Jqs67eP/1JggmTXQIjOMB75Sikg9afc2brw
gBgE/PlF3gl0b4OF6Y/bAFXxjwkTaOjE4nzgvLN0ncWz0IcnhzdC7H09+6ID7Xam
RBYDVMaKrXMeUI9Nj6/yGNhgi0QWzA==
=uzn3
-----END PGP SIGNATURE-----

--exgeui6fqooldnrg--
