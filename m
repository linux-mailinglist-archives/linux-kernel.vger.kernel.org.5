Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DA97A5342
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjIRTsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIRTsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:48:00 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28808F;
        Mon, 18 Sep 2023 12:47:49 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0C9DC1C0006; Mon, 18 Sep 2023 21:47:48 +0200 (CEST)
Date:   Mon, 18 Sep 2023 21:47:47 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Sameer Pujar <spujar@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
Message-ID: <ZQipY8MUrNSpOBOB@duo.ucw.cz>
References: <20230917191051.639202302@linuxfoundation.org>
 <dfe78c1a-8322-413b-f1b7-3a6a307a831c@nvidia.com>
 <2023091846-cabbage-imagines-3fde@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RsvENpkY97gWjqyL"
Content-Disposition: inline
In-Reply-To: <2023091846-cabbage-imagines-3fde@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RsvENpkY97gWjqyL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Sameer Pujar <spujar@nvidia.com>
> > >      arm64: tegra: Update AHUB clock parent and rate
> >=20
> >=20
> > Unfortunately, the above change is causing a regression in one of our a=
udio
> > tests and we are looking into why this is.
> >=20
> > Can we drop this from stable for now?
>=20
> Is it also a problem in Linus's tree?  Keeping bug-compatible is always
> good :)

Please update Documentation/process/stable-kernel-rules.rst
accordingly. People expect certain properties from stable tree, and of
the rules written there only "It or an equivalent fix must already
exist in Linus' tree (upstream)." is followed.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RsvENpkY97gWjqyL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZQipYwAKCRAw5/Bqldv6
8ga/AJ4rIhtWw5HCsxMcbFWd/XpshfXZXQCfWx27itd90g0HydpGZLqxlqrRFJQ=
=JZbM
-----END PGP SIGNATURE-----

--RsvENpkY97gWjqyL--
