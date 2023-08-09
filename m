Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E696C776663
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjHIRW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjHIRV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:21:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2E2DA;
        Wed,  9 Aug 2023 10:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1227D64260;
        Wed,  9 Aug 2023 17:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14367C433C8;
        Wed,  9 Aug 2023 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691601715;
        bh=97KbzLi9Si0wiuAVs4dKvbELDUj4qzzEdAk6c/YCBr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQYy9yJcNS6eSDh1GYBGi4bu3L7TH4mFnuYNDJiF2uPlTp2YhLYGEAI7K9Q9MDqFV
         Joypdb8zs9XlYky+VIGMYfv+Vaw/RUxqC+h5/+0e30kx/Pt7VB42lECwqgv/ik1YFy
         E0o7wTpesm6lAoKxRew5WMehr5F77D7dh2GmmOBBSbqVff5Wf6T4xsO4V96z7+cmC6
         MOgGKnphWsyQaHGei0NF0RYd+sVWsqLPrRzvjRONZzR+KSX1R5Ol3dn6sPyaijF4t8
         5l9pmckYrLRGmS9RXEXO4CoBllbmipZj1ZwyHT2hFxl8vSkjwtPVx6QVgu+RXf7I+C
         vnBWukHcK3Acw==
Date:   Wed, 9 Aug 2023 18:21:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Kernel.org Tools" <tools@linux.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: get_maintainer, b4, and CC: stable
Message-ID: <6dabeab8-d013-40fc-a705-d2d202510549@sirena.org.uk>
References: <CAKwvOdmOVnhKws_6DdakK9SDxiCCCR1d6VJwvz94Ng_y3V8QCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LWqUKYVMG3UGwyMl"
Content-Disposition: inline
In-Reply-To: <CAKwvOdmOVnhKws_6DdakK9SDxiCCCR1d6VJwvz94Ng_y3V8QCg@mail.gmail.com>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LWqUKYVMG3UGwyMl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 09, 2023 at 09:50:00AM -0700, Nick Desaulniers wrote:

> I suspect that either b4 or get_maintainer could see the Fixes tag and
> then suggest to Cc stable for me.

> Should get_maintainer.pl make such recommendations?

People use the Fixes tag all the time for bugs that never made it into a
release...

--LWqUKYVMG3UGwyMl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTTyy4ACgkQJNaLcl1U
h9A/Qgf9HGkw8mUChyCpqj1Gd7XYPoLdfYsL4xPF8/eVvrohiJHpz5TaO4jE+UAN
SFPnbZhSINInsqL+/q+MEX3VmwTySCNknhlKflE51q6Zo6CpgSt0TfYCM0BsvrfT
VrXCnsXlkjONOGnTRmV1FoayrSOGF+wXy7TUxFhaT7UpgR9Ar6a6uiiJmsJC7jO7
DFd3jt2Uy2bUWOJeUqhdHV0zvBZhcMitut761Wd5QHwtaOq2xhEOzTPOgW6P/0Cb
HvPQK1mRMePYnEfpbKWxZ5M/2jNtn5hSD1HyopV8byELbf5HS7BtCQmOckp6JyIu
CahImhLPoqIQWzpys/PykESoFgs3+Q==
=5jRH
-----END PGP SIGNATURE-----

--LWqUKYVMG3UGwyMl--
