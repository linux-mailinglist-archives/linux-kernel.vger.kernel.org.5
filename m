Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA49B7E2F52
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjKFV4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjKFV4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:56:18 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A00E10C0;
        Mon,  6 Nov 2023 13:56:13 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 300571C0070; Mon,  6 Nov 2023 22:56:12 +0100 (CET)
Date:   Mon, 6 Nov 2023 22:56:11 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 4.19 00/61] 4.19.298-rc1 review
Message-ID: <ZUlg+zd26I6F1oWD@duo.ucw.cz>
References: <20231106130259.573843228@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qq+6ykEKXxcqiiOA"
Content-Disposition: inline
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qq+6ykEKXxcqiiOA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.298 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

There's something wrong here.

|d17debc75 a5feba o: 4.14| r8152: Increase USB control msg timeout to 5000m=
s as per spec
|78fca56b7 d2a0fc o: 4.14| tcp: fix wrong RTO timeout when received SACK re=
neging
|8152892c6 adc8df .: 4.14| gtp: uapi: fix GTPA_MAX

These three patches are in 4.14-stable, but not in 4.19-stable.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qq+6ykEKXxcqiiOA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZUlg+wAKCRAw5/Bqldv6
8lcjAJ9LpOT4RCd0AbLeFyEnFcw7Py5dtgCfQjqVvmOobfn/u86XhOiM5g5Dx0Y=
=zm+s
-----END PGP SIGNATURE-----

--qq+6ykEKXxcqiiOA--
