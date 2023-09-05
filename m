Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05941792EA7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbjIETSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjIETSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:18:21 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0788F1711;
        Tue,  5 Sep 2023 12:17:56 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 542481C0004; Tue,  5 Sep 2023 21:16:53 +0200 (CEST)
Date:   Tue, 5 Sep 2023 21:16:52 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hch@lst.de
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.15 00/28] 5.15.131-rc1 review
Message-ID: <ZPd+pJ2GOEn1mPcL@duo.ucw.cz>
References: <20230904182945.178705038@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EYk9EF0sE1TdmKlq"
Content-Disposition: inline
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EYk9EF0sE1TdmKlq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.15.131 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

> Christoph Hellwig <hch@lst.de>
>     modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules
>=20
> Christoph Hellwig <hch@lst.de>
>     rtc: ds1685: use EXPORT_SYMBOL_GPL for ds1685_rtc_poweroff
>=20
> Christoph Hellwig <hch@lst.de>
>     net: enetc: use EXPORT_SYMBOL_GPL for enetc_phc_index
>=20
> Christoph Hellwig <hch@lst.de>
>     mmc: au1xmmc: force non-modular build and remove symbol_get
>     usage

This is not fixing any bug. This is playing politics. And it will
break people's setups, as it was in mainline only for month.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EYk9EF0sE1TdmKlq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZPd+pAAKCRAw5/Bqldv6
8g6DAKCgKODOQ2uMo44HcoZL49PfziByqwCeIcM6QRNPnNrR9DWmeG9vdLKb91s=
=0UdH
-----END PGP SIGNATURE-----

--EYk9EF0sE1TdmKlq--
