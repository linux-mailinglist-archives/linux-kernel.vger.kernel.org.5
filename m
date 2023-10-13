Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7547C86AD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjJMNVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjJMNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:21:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EF3BF;
        Fri, 13 Oct 2023 06:21:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F36C433C7;
        Fri, 13 Oct 2023 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697203277;
        bh=0VLSmUiBT4OXSKoUDLazEOxnT0ZGOzCtUjBBnsTitwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FCNmsHwYJDmN5iKapkMHyrE6IvjJehLUtF23l9lcZRkuXgX9C4vGhRXlUJnuLZHKC
         r1BfmIkhWnnKwt7JBe6RIFm4sAbdwqfzn472ct1nN9o4Jh627dKLX+7mI1RiVkaTFA
         0QMZk3rZbth7fy+Jm9AZOC87fIq4wdRah9E2HMwKxQQmZI0CyYvGvLwGvaC9hageEq
         xzljsZRXZK8b/bN/XwiXVLrPkNJMfUn8+71BzNDU0toxYPQpgWz7U09RMlFxK+se26
         +Wa7xV8ZB1sypDRyE263R3NYJrszF/YuFfq6fAhcoOH5U2VT4RaGWKVCRyg/u9HYXg
         2Rec5SLOYS76g==
Date:   Fri, 13 Oct 2023 14:21:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v6 04/11] ASoC: fsl_asrc: register m2m platform device
Message-ID: <ZSlERK8gRFUOusqf@finisterre.sirena.org.uk>
References: <1697185865-27528-1-git-send-email-shengjiu.wang@nxp.com>
 <1697185865-27528-5-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wC1z3YN8nkgTz/wR"
Content-Disposition: inline
In-Reply-To: <1697185865-27528-5-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wC1z3YN8nkgTz/wR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 04:30:58PM +0800, Shengjiu Wang wrote:
> Register m2m platform device, that user can
> use M2M feature.
>=20
> Defined platform data structure and platform
> driver name.

Acked-by: Mark Brown <broonie@kernel.org>

--wC1z3YN8nkgTz/wR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUpREMACgkQJNaLcl1U
h9B0vgf+NIJEhKtL7g30+vSPZtbkBvnhTzPAcFV3zcMUZxT5QqDaOUcJVcQhn8fG
JRFW4lt71Z8bMABFCkoA/YghAFfzI5wLaxkzZgJT5B62Txw5tI9m8U4G2/LZt7y3
MM9ZP6KAzESEb3Xzc5I6DNPcXP13RiAijK4UzIvFmZZvn1htGzK3Fw0Lw9I5JIAT
oIIVQ8xaI107q2cuzxoBQ0bORi3UUCHL1f4g/YHxt7LHcdaXyZN6QoJ4jk4C2Qwi
5OtfvG14FnnM110KqTRVL7X9ZDeDq5d9EhhAgTqrzUDmvb2Pv0JY4mUbONiG63JU
nhIyQqDJ8Ri8cgDk2OVf/sXHx8XT+g==
=zNQc
-----END PGP SIGNATURE-----

--wC1z3YN8nkgTz/wR--
