Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487BD7FC6A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346235AbjK1VBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344533AbjK1VBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:01:45 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE2A9D;
        Tue, 28 Nov 2023 13:01:51 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EC1771C0050; Tue, 28 Nov 2023 22:01:49 +0100 (CET)
Date:   Tue, 28 Nov 2023 22:01:49 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com, stanley_chang@realtek.com
Subject: Re: [PATCH 6.1 000/366] 6.1.64-rc4 review
Message-ID: <ZWZVPaIt3EGsDLj7@duo.ucw.cz>
References: <20231126154359.953633996@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RzAbNghvS/rgMX0P"
Content-Disposition: inline
In-Reply-To: <20231126154359.953633996@linuxfoundation.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RzAbNghvS/rgMX0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.64 release.
> There are 366 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

> Stanley Chang <stanley_chang@realtek.com>
>     usb: dwc3: core: configure TX/RX threshold for DWC3_IP

This adds properties such as "snps,rx-thr-num-pkt",
"snps,tx-thr-num-pkt". They are not documented anywhere, and they are
not used in 6.1 tree. DTS checkers may eventually find the
inconsistencies, and this will cause warnings, so it may be good to
revert this.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RzAbNghvS/rgMX0P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWZVPQAKCRAw5/Bqldv6
8o4QAKClYXQc2EPmalB52hJlRmqzIOGuLQCeJxy9LQgQImFvh2NPluUrHvt+20Y=
=vavJ
-----END PGP SIGNATURE-----

--RzAbNghvS/rgMX0P--
