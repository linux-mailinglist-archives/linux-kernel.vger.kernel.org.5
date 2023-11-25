Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1E97F8C83
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjKYQoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjKYQoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:44:22 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E41D13A;
        Sat, 25 Nov 2023 08:44:28 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 429C91C0071; Sat, 25 Nov 2023 17:44:26 +0100 (CET)
Date:   Sat, 25 Nov 2023 17:44:25 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@denx.de>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 4.19 00/97] 4.19.300-rc1 review
Message-ID: <ZWIkab2PnalL4ZmF@duo.ucw.cz>
References: <20231124171934.122298957@linuxfoundation.org>
 <d48b5514-759f-47a0-b024-494ce87ec60f@linaro.org>
 <ZWHYlErVfVq8ZoOu@duo.ucw.cz>
 <2023112518-traverse-unsecured-daa2@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p9lJ+2E6bbm/ygVf"
Content-Disposition: inline
In-Reply-To: <2023112518-traverse-unsecured-daa2@gregkh>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p9lJ+2E6bbm/ygVf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > This is the start of the stable review cycle for the 4.19.300 relea=
se.
> > > > There are 97 patches in this series, all will be posted as a respon=
se
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > >=20
> > > We see this failure on Arm32:
> > > And this one on Arm64:
> >=20
> > We see problems on arm, too:
> >=20
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelin=
es/1084460512
>=20
> Note, posting odd links isn't going to really help much, I don't have
> the cycle, and sometimes the connectivity (last few stable releases were
> done on trains and planes), to check stuff like this.
>=20
> Info in an email is key, raw links is not going to help, sorry.

Resources are limited on this side, too, but I'll try to keep it in
mind.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--p9lJ+2E6bbm/ygVf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWIkaQAKCRAw5/Bqldv6
8ipoAJ46UKxBTpiIYGQrYRakF9KCHkzNRgCgprqo2Zt1ep2pO7ha5S2jLNoPq84=
=1inI
-----END PGP SIGNATURE-----

--p9lJ+2E6bbm/ygVf--
