Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A197A7394
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjITHCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjITHCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:02:33 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F8590;
        Wed, 20 Sep 2023 00:02:26 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2DBDD1C0006; Wed, 20 Sep 2023 09:02:24 +0200 (CEST)
Date:   Wed, 20 Sep 2023 09:02:23 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        gregkh@linuxfoundation.org, pavel@denx.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdns3: Modify the return value of cdns_set_active
 () to void when CONFIG_PM_SLEEP is disabled
Message-ID: <ZQqY/+eoVtPJ+i0N@duo.ucw.cz>
References: <20230912064946.1405848-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xjpou7buZ022lZeG"
Content-Disposition: inline
In-Reply-To: <20230912064946.1405848-1-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xjpou7buZ022lZeG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The return type of cdns_set_active () is inconsistent
> depending on whether CONFIG_PM_SLEEP is enabled, so the
> return value is modified to void type.
>=20

Reviewed-by: Pavel Machek <pavel@denx.de>

> Closes: https://lore.kernel.org/all/ZP7lIKUzD68XA91j@duo.ucw.cz/
> Fixes: 2319b9c87fe2 ("usb: cdns3: Put the cdns set active part outside th=
e spin lock")

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xjpou7buZ022lZeG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZQqY/wAKCRAw5/Bqldv6
8mp0AKC8PaWORDidjoMqy+qLkVvGsgsaigCeOahafaKK79kITBtUCtrZ72JWjCI=
=pEC7
-----END PGP SIGNATURE-----

--xjpou7buZ022lZeG--
