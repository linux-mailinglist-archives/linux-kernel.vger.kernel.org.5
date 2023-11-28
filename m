Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DD77FC598
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbjK1Uje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1Ujd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:39:33 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED01E10DF;
        Tue, 28 Nov 2023 12:39:38 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E4FEE1C0050; Tue, 28 Nov 2023 21:39:36 +0100 (CET)
Date:   Tue, 28 Nov 2023 21:39:36 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, alexander.deucher@amd.com,
        mario.limonciello@amd.com, zhujun2@cmss.chinamobile.com,
        sashal@kernel.org, skhan@linuxfoundation.org, bhelgaas@google.com
Subject: Re: [PATCH 4.14 00/53] 4.14.331-rc2 review
Message-ID: <ZWZQCJtD7kmX9iRO@duo.ucw.cz>
References: <20231125163059.878143365@linuxfoundation.org>
 <ZWUBaYipygLMkfjz@duo.ucw.cz>
 <f4a7634-3d34-af29-36ca-6f3439b4ce9@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lRLMaN1GVD9qoEQr"
Content-Disposition: inline
In-Reply-To: <f4a7634-3d34-af29-36ca-6f3439b4ce9@linux.intel.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lRLMaN1GVD9qoEQr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This is the start of the stable review cycle for the 4.14.331 release.
> > > There are 53 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
>=20
> > > Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > >     RDMA/hfi1: Use FIELD_GET() to extract Link Width
> >=20
> > This is a good cleanup, but not a bugfix.
> >=20
> > > Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > >     atm: iphase: Do PCI error checks on own line
> >=20
> > Just a cleanup, not sure why it was picked for stable.
>=20
> Just an additional bit of information, there have been quite many cleanup=
s=20
> from me which have recently gotten the stable notification for some=20
> mysterious reason. When I had tens of them in my inbox and for various=20
> kernel versions, I immediately stopped caring to stop it from happening.
>=20
> AFAIK, I've not marked those for stable inclusion so I've no idea what
> got them included.

Fixes tag can do it. Plus, "AUTOSEL" robot does it randomly, with no
human oversight :-(.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lRLMaN1GVD9qoEQr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWZQCAAKCRAw5/Bqldv6
8kI1AJ9xy9QoY/0QExh/MaaO3D4aSel1zACfT73nofDFGz4GE5URTM7E3l54ulE=
=Ezwi
-----END PGP SIGNATURE-----

--lRLMaN1GVD9qoEQr--
