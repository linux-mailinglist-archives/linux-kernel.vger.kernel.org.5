Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630BB7BFB23
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjJJMUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjJJMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:20:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4144399
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:20:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0E4C433C7;
        Tue, 10 Oct 2023 12:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696940449;
        bh=ZavnWzZOQAQ7EGflKYoEc/3BIUKgSkHsq0I49wQevOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nL/xb1cnrv5quevPKrptkBenC3UNP7zpxz5EnnQXcGbSj0DgOGC87yf7vMywGRWSh
         RwcIJvYjHkuk+MAiMOkyCNLEhcKZ2f2fUybzfYKCXsX1DdNlOj1qih5LWmT50OvN5A
         nyzPwJeNKGx0TnSpWFASKgJVgBPBg3cyZ9mDMoayotCtNlRPYTweHUTR6R7l5LzGI3
         1GqiHMGGTVjonjDmleHMaO93eEWEdCkhTyY9VPtxbhmW7kEe3pyAY7oQbV3uGw+WCz
         ZS5fUTNAkGsGTrzJF5xgVK/Smr5fZcHc9fDUjcIdX5y7R7qe0b0y+wzD5marBPso/p
         I1fJ/TDkI+LBw==
Date:   Tue, 10 Oct 2023 13:20:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] regulator: dt-bindings: fixed-regulator: Add
 under-voltage interrupt support
Message-ID: <0024647c-cd4e-4b9f-b2bf-02143d27a852@sirena.org.uk>
References: <20231010085906.3440452-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2qKDuD5Uo7Ayf5Bi"
Content-Disposition: inline
In-Reply-To: <20231010085906.3440452-1-o.rempel@pengutronix.de>
X-Cookie: I feel partially hydrogenated!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2qKDuD5Uo7Ayf5Bi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 10, 2023 at 10:59:04AM +0200, Oleksij Rempel wrote:
> Add under-voltage interrupt support. This can be used with simple
> regulators having no other way to communicate an under-voltage event
> except as by toggling some GPIO line.

This doesn't apply against current code, please check and resend.

--2qKDuD5Uo7Ayf5Bi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUlQZwACgkQJNaLcl1U
h9B+OAf9HVf3aL2pQBjTFArNyffVDE6INNQufQW6NAbtgLDbBJnTzqsAkKR+P49v
81rBkDM/nopWQ/w6SSFgj239wsD1Wn8EUxjbfui4fD3zBgy/CBcl8F8FgJKmwkaR
eFpSadEIA8oKGhNkAX5qDcw6eHNVmp28gtMB9UXhXxAzHyzVaV4/yMAR04wieOXn
hF3cuW8xSAc0n7n41zAHBVyRAAfQhFVHizmY/QA9MVdvKGWfFtnn9XRjx+NNIZRY
+4MCDz/KVBbvza7a+tDyox+4t0V2zDVuWNBhHGYB3usuNl6Kumn3BEZZSZfFKRwc
2lSVNeNn9oObEYzCu6kGh1fYrYaJjw==
=7uwH
-----END PGP SIGNATURE-----

--2qKDuD5Uo7Ayf5Bi--
