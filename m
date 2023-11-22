Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C987F454D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbjKVMDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343732AbjKVMDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:03:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4E1D4F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:03:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58005C433C8;
        Wed, 22 Nov 2023 12:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700654592;
        bh=tQRmNFQp+zLdjBmW/eVL1FEGW0CXiLk2EixjzUH4pNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxMWHIycMWTui/Rwt3MmNhNZtUMkeQbkxyYgw5S4cjCw7nGTxTVgP2ipGGI2Ehnj/
         uVSJBcBKBsrpUbaX5euqfZjLoBXQu1DTM56idERNxfpniYNSc6mGPyiVLMXLylnf4j
         75ge8YQgjhLGABjHvth3sSjZjmJ3Jp4U+AIrdvgw3BnctqIMvgZ9v6hnrvTX2ZMCxu
         AFwDg2ztQc9OX6Yz2zTV8kwBUZuJX8qHVbPO7lO9ZBQg+2jNajwjQY7vqixlZDhOpf
         VcjSGOVMmIKanVg/t3Cbnx3HvIrWY65Pf5bJYRT9j25Wjw9pamp6E4rmPn0+YAtSCO
         zHu68XeUVqwWw==
Date:   Wed, 22 Nov 2023 12:03:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     nikita.shubin@maquefel.me
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 14/39] dt-bindings: spi: Add Cirrus EP93xx
Message-ID: <ZV3t+5gVKfFJwHs8@finisterre.sirena.org.uk>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-14-d59a76d5df29@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bM1oHkrl3jZxfR3+"
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-14-d59a76d5df29@maquefel.me>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bM1oHkrl3jZxfR3+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:59:52AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Add YAML bindings for ep93xx SoC SPI.

Reviewed-by: Mark Brown <broonie@kernel.org>

--bM1oHkrl3jZxfR3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVd7foACgkQJNaLcl1U
h9CRQwf+JSN6jCrGLgTa4U7VdvV78brmnmtxIdrFoe2zth5HeiTRoBt4NnHr1ff1
k4v1DtKUEiKq3I4Wwc0qSfSL6tTWVhLwJ244qlqgyfzmJG/Lps65PAL0KMDh61qe
1TINDt0LX3K1zzzPTkpir+es/oyU6gW3vOdh472g8WphXkSIN685wyT0FZFu3Y3C
H6AIBq1oDcFtsiFwxhmCl4Xe+LhgTF0D0Y8dYJsjCLQFa4XBaD4UYIJl27qySJEY
7KN1ACbZZXEHsFPmHp4Q45jzoE4Nk6FYQ8fNH9u6mdzfUzZTXWMwC1pKO2rXTU3n
yhGpJfKSbQ/SJgFeajBv7GYyq5efVg==
=45OJ
-----END PGP SIGNATURE-----

--bM1oHkrl3jZxfR3+--
