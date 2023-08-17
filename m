Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0847F77F542
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350360AbjHQL3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350406AbjHQL2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:28:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EF03599
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1571646CF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9794EC433C8;
        Thu, 17 Aug 2023 11:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692271706;
        bh=QizM/IZpfLB5gNw8uILxz1bnW3evYEoQkYuca1IFqRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OzpKUutHKba8ti7KWcq4IRNp9NGE4BkW2di4vdwKz1cPKO8O1qsvYuSIHBmW1wxYK
         sb0PaaKdbMVYe8TJJ90r0myvrEjIlIa7kOTZGEyoEfoT11y6ubtyrcphl/14OnCKqr
         a5hF2O/Xxl9sghpr5dCAelyU1KlgNW1WvyBxyk7n6CYKUSOwxEfp/6hp6upZZt/8RT
         Z+2AOpCx3qc2wwQS7Q7M7My/emxmDgrvvbHG6QC+epF9ZKo0Oq9JLsefTogBPnm97I
         3bN4qnjJdKUZk59BwjXLsPgBRBf6EI/U0pU7ls4YH5mERZb1JKoomv9h87OVPHS3RQ
         IgatkkD3ALkNg==
Date:   Thu, 17 Aug 2023 12:28:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: selftests: arm64: hwcap.c:51:15: error: instruction requires: crc
Message-ID: <a7b678d9-d6ba-4cf1-a6b3-89098cc90f6e@sirena.org.uk>
References: <CA+G9fYvVZmOJvf=+JM8LRGxV6ynCPuPreipCP3+fmti=M+dxwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+S02MxnRuwcq6WP5"
Content-Disposition: inline
In-Reply-To: <CA+G9fYvVZmOJvf=+JM8LRGxV6ynCPuPreipCP3+fmti=M+dxwA@mail.gmail.com>
X-Cookie: Walk softly and carry a BFG-9000.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+S02MxnRuwcq6WP5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 17, 2023 at 03:33:18PM +0530, Naresh Kamboju wrote:
> While building selftests arm64 following warnings / errors noticed on the
> Linux next-20230817 tag ( from next-20230815 )

Fix already sent.

--+S02MxnRuwcq6WP5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTeBFEACgkQJNaLcl1U
h9Cgrgf/Wenr4NZxC38M3/DbG/CskZ16LCseE4pV7yjyBMeEtE/oUrSZ2CEncxvr
2XFFcdmCptO6ndzRpfqZWtz+x5IOhq29QbBcHgNQQwSaUaFuDAOcZIcuEBZnK7dT
6k1cnXwDNBxFxrZR371CdZKb6csnBGbgTL/AWSvxwXUx/ho8O1iz1ouaXKmZS9Pc
t6xenkAHV14HFX3eg0RvleE5549UcQrX67Tt5nSblpISxSu6e0sSPNi4PfwRGijr
qltuZNiKI7ESyv9oEv5AcVjJsga+LraklRUdsXyhYt2FJ6Q61gjkXWzXOgCHrLu3
8iVuXhnI7k8B6QESUjEZlgD9bB8PqA==
=M49M
-----END PGP SIGNATURE-----

--+S02MxnRuwcq6WP5--
