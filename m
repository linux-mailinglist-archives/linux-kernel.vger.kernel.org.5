Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8BF76529C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjG0LiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjG0LiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:38:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92544135;
        Thu, 27 Jul 2023 04:38:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D8A961E3F;
        Thu, 27 Jul 2023 11:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C123BC433C7;
        Thu, 27 Jul 2023 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690457883;
        bh=qrtv8LuFgEy9QtuElB5WTipNRE0V3By2gWSVepbtQ7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdkokuZRWEn5yIwSR1hterBm6FSsAhtG+jbCndMx6XxALfVuCKl/EuleMUM0bdERm
         vlG8lLoK9tRysxzXpnsga85ookK4+x+9YHw0BPl1ctmktShDIArBwU7+W/PUuA3DEq
         QttNbUx/ftjwscPBLVMWfcPWyXLu6TbOK8n6MSdFNhTNVv4xQ/Ow4o5Xxq1PC2YovR
         gkzKJ2zZZNatXj68QCgBJ+KxsY+LkjnARjJLeBK2ORPV571h3PusBzcTgdLXDMxFY+
         3jU0d9WnX771OebuCQXc7gGm8oprPDHIPtkNEe7yEv7FdNpz8gD3L1cDbPFlHktI22
         CjXyDZ/NpL4jA==
Date:   Thu, 27 Jul 2023 12:37:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v13 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <2264c9bd-76fb-4a99-b655-f4c7bc2a1d45@sirena.org.uk>
References: <20230613075834.5219-1-zhuyinbo@loongson.cn>
 <20230613075834.5219-3-zhuyinbo@loongson.cn>
 <3822f248-39dc-fb8d-321a-7b6c833cbb3e@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JjBX8JpJbtjo1Snt"
Content-Disposition: inline
In-Reply-To: <3822f248-39dc-fb8d-321a-7b6c833cbb3e@loongson.cn>
X-Cookie: Go 'way!  You're bothering me!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JjBX8JpJbtjo1Snt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 11:09:16AM +0800, Yinbo Zhu wrote:

> Friendly ping ?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--JjBX8JpJbtjo1Snt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTCVxYACgkQJNaLcl1U
h9DDmQf/SxCfcU7xLJb1VQ6Trs2YQcIm+5DBqkYB2kwMc7RkN149QH3JVV7WDZ81
r88Ke9O2Ytk+ahFIoRXEYFwF+tUKgusjLDl3vqBqAYkERSiDA1y+/d1L7/sd2Yl5
MYjnvsPV4EFsWaueRhUruviD1j2uj+4XtvQ30H1Uc4tt1VrjdaLHKFXE+dXB00PL
VgVsNRdRNt/WsHQG7KRgzco/SZXfgmO1HcN/2xO42L4usItL5a+6lWzfoWDs50Co
OePM/jOw0Bpik43CrmG2jZWlZYHCTAfUaz43FGW+qbIMpwjtl3lwMJUh1TKvHcw0
09aP7Uv6TrzACgTRB6T3wMPjY8GKYQ==
=7E8u
-----END PGP SIGNATURE-----

--JjBX8JpJbtjo1Snt--
