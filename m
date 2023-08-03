Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928E776E669
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjHCLKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjHCLKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A216F5595;
        Thu,  3 Aug 2023 04:08:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D27761D47;
        Thu,  3 Aug 2023 11:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE34AC433C8;
        Thu,  3 Aug 2023 11:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691060913;
        bh=KEAtgOS5jYItBOTrXF1vB31CKUjsHUBpPiB4bpc82fE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkEVcdW2O+ztWRu1qNbkdliDPEunSmhcenw/NFYclvicVnhdO/Rh6R3qpcDH344+g
         FA9niHSKP1An6jyQea4woFOR8RFPcfx+vQYng69aoNJCrGVAap/Zywg9srq7eKSYwR
         +m29v9qMy09XgX6cnSZL74k/dRuoK6ztkovhoBxlExG/lfiTfetd4Tq9gfpMujRbrr
         5WSXo3jQxMBRQiRo+0IsBbtMC+GSIAQAueKzEgGR1PhqfZvJHg+875WwWFfwDQR7XA
         DTm71NsEBWBtKhwQwKUa1VZFl2WPROjZnS1mKtkFYpDMow3NYU48flwydIbYvt1uke
         e+PJcx9LrsZoQ==
Date:   Thu, 3 Aug 2023 12:08:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     ChiYuan Huang <cy_huang@richtek.com>
Cc:     Alina Yu <alina_yu@richtek.com>, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] regulator: rtq2208: Add Richtek RTQ2208 SubPMIC
 driver
Message-ID: <e31b8381-7148-4485-834a-02638e9a81d7@sirena.org.uk>
References: <1690355592-10920-1-git-send-email-alina_yu@richtek.com>
 <1690355592-10920-3-git-send-email-alina_yu@richtek.com>
 <20230803072425.GA22780@linuxcarl2.richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4j+GeulFbYEw8OPb"
Content-Disposition: inline
In-Reply-To: <20230803072425.GA22780@linuxcarl2.richtek.com>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4j+GeulFbYEw8OPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 03, 2023 at 03:24:25PM +0800, ChiYuan Huang wrote:
> On Wed, Jul 26, 2023 at 03:13:12PM +0800, Alina Yu wrote:

> > Signed-off-by: Alina Yu <alina_yu@richtek.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> This patch series is to add new drivers, not fix.
> Why do you add the Reported-by tag?

The LKP people have some boilerplate in their reports that tells people
to add Reported-bys for things they find based on patches, it's a
constant problem :(

--4j+GeulFbYEw8OPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTLiqsACgkQJNaLcl1U
h9DctAf+MB91v0Zjw5l0Ud1RAi8ElVYnY4lB3dlp4VTSp+nI5CHQ4IltV4/Pgc8t
WadUrDkBWs2sXmUQxZ8v7kubjGiP4ortH5aEs9FCa0TWc5GFlwTvi8XVX2yjIkJ7
CcOFXXAPN5/Lgvf+ony4dD7Y6ToZavnSEYMS4zF1dm1++an7/4Mc0Zl6sC1J7ziR
pS8aMtuI8J1NQrE0mmqpGSAZn4UqMsOSE/FtGvhlb2X5OYAGR4mYIZPJuYtL/K7x
92e+eUTraIkJfVauMJI6QXmydg4EDXZajGniu7th6FYRvC24m0r2k1fCon17OUPK
GRbVy6yC0Ki2AJnr9O8JJtezYGb6IA==
=JIYC
-----END PGP SIGNATURE-----

--4j+GeulFbYEw8OPb--
