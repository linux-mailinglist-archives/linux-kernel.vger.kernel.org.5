Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB6C7EFCB9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 01:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346408AbjKRArX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 19:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjKRArW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 19:47:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A141D7E;
        Fri, 17 Nov 2023 16:47:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF6EC433C8;
        Sat, 18 Nov 2023 00:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700268439;
        bh=YwEuSfGZ7ojP/5U2tC2NpapQhWjqP4EOmTbb1ZZs8/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJ8XljlaspZB+XcaGvZAyG9pkjA83ckeGDGVzvDZBn5U2nRTFgKamCA41aFSbku2s
         HZINSaxrJrwtaUeYVdDfFuhjAoroF+tFPc4HJyN7lYe8Dm7CUg1A4RENsgm5Z8m9YP
         r+BWEsi7tqhqjLIY3f+T6dH2qfGcf2DzYMa2FxHpOFs+jhef++sv0rlOKf1B/XRJo1
         WuwwWEZsX1LLqMNCnYRyPQDV1CYUtTyTLImIQdkrGRD5eCM/ZqTeC/lArw4KT/L3vq
         DbDx5ECXYht/Ma4n9tglO6TX+TTzLsfjCKRT45qtGbFQ5AUNz/HGJ5Y510RmelMbsv
         uJzjloX6NwAvw==
Date:   Sat, 18 Nov 2023 00:47:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, linux-mtd@lists.infradead.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, michal.simek@amd.com,
        linux-arm-kernel@lists.infradead.org, git@amd.com,
        amitrkcian2002@gmail.com, akumarma@amd.com
Subject: Re: [PATCH v9 0/8] spi: Add support for stacked/parallel memories
Message-ID: <ZVgJkzvMnopOsqr9@finisterre.sirena.org.uk>
References: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5uvpYN7krVaFv1A"
Content-Disposition: inline
In-Reply-To: <20231018213328.40131-1-amit.kumar-mahapatra@amd.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5uvpYN7krVaFv1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2023 at 03:03:20AM +0530, Amit Kumar Mahapatra wrote:
> This patch is in the continuation to the discussions which happened on
> 'commit f89504300e94 ("spi: Stacked/parallel memories bindings")' for
> adding dt-binding support for stacked/parallel memories.

This missed the last release since I'd been hoping for some testing by
others with relevant hardware - from a code point of view the SPI bits
look fine.  Could you resend based on v6.7-rc1 please, it doesn't apply
any more?

--r5uvpYN7krVaFv1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVYCZMACgkQJNaLcl1U
h9BEwAf/VRlQwrkHLeoFYDISp+K+SZYmPqJ0OvYfI7oc0iciARZC/og+rjBq76ZY
rRJhX/vwm4ZroHv292scNztMg5MvVyd2G5MOhu9utieAIrC3QJQcZVb7+tONbLyA
7Owo3viONkjlTa8CMaK2VO6NsaVp0wD88ulHJel4lcvK4/zdiIwwN0VouEdjpmet
MB/1QwwOXKWf+ZKuOIvep1sSTtsZ1RdPjh5nNpXFJyT1c/f+NAWzIVF2/gWE2SDz
ZlWVyN4a3s7J24UtfW16OrPRTckkuSRbiHyYUKlETNrP4KLPlpbF49Omc+Wk0Tzc
fAts3F4Azz4JbVYP84LWEayeflJYXg==
=zI5Y
-----END PGP SIGNATURE-----

--r5uvpYN7krVaFv1A--
