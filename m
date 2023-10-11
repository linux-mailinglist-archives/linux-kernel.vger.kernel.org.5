Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8807C7C4E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345846AbjJKJSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjJKJSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:18:50 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A62A7;
        Wed, 11 Oct 2023 02:18:48 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B4C871C006E; Wed, 11 Oct 2023 11:18:46 +0200 (CEST)
Date:   Wed, 11 Oct 2023 11:18:46 +0200
From:   Pavel Machek <pavel@denx.de>
To:     luomeng <luomeng12@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.10 000/226] 5.10.198-rc1 review
Message-ID: <ZSZodpfecBbnReIP@duo.ucw.cz>
References: <20231009130126.697995596@linuxfoundation.org>
 <6c75e3a4-916a-9474-0361-ed80dc77c03e@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="L93NYHXkqzw8T+5w"
Content-Disposition: inline
In-Reply-To: <6c75e3a4-916a-9474-0361-ed80dc77c03e@huawei.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L93NYHXkqzw8T+5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Tested on arm64 and x86 for 5.10.198-rc1,
>=20
> Kernel repo:https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable-rc.git
> Branch: linux-5.10.y
> Version: 5.10.198-rc1
> Commit: 18c65c1b4996e3f6f8986a05eceaf427355a7a4f
> Compiler: gcc version 7.3.0 (GCC)
>=20
> arm64:
> --------------------------------------------------------------------
> Testcase Result Summary:
> total: 9023
> passed: 9023
> failed: 0
> timeout: 0
> --------------------------------------------------------------------
>=20
> x86:
> --------------------------------------------------------------------
> Testcase Result Summary:
> total: 9023
> passed: 9023
> failed: 0
> timeout: 0
> --------------------------------------------------------------------
> Tested-by: Hulk Robot <hulkrobot@huawei.com>

Thanks for the testing. Please avoid top-posting and remove irrelevant
content when replying. (Yes, I actually scrolled 900 lines to see
there's nothing to see there).

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--L93NYHXkqzw8T+5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZSZodgAKCRAw5/Bqldv6
8so+AJ4x7BWTfrVWFzJ/RjyKXrde29HT6gCeOIvMgiBap11R56hXCVDi8KPKouk=
=gmTk
-----END PGP SIGNATURE-----

--L93NYHXkqzw8T+5w--
