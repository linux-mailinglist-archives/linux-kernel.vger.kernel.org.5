Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1998C759C09
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjGSRIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjGSRIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:08:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1F21731;
        Wed, 19 Jul 2023 10:08:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD6A0617B3;
        Wed, 19 Jul 2023 17:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BBDC433C8;
        Wed, 19 Jul 2023 17:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689786502;
        bh=H0TI3lv5V5snhOaaPWfEdfeN5mLjsrEblaKGu2VK/oA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5i7JcDwupZbnC5qurstWHiIR/vvSk5pJ8QDfopYh6GlbeZHzToQKiY54yBdHGY7M
         GT5AkgQd/nWkcjwg9Hw2jxM6LiHCHfw2j/qLvTRja0pMhbTQrJRUDNsKJHKdNkZC0P
         26jOgPoUhDHb5Z/Cbr2O3By3PHyVM4IO9iZDyTxDV2OR8wB70aC6Xn7EFxcc5nPNLW
         9DQJ98XUjlgfdXe5dN1yd18An6+nQwYA6xY1G8w9ZxYDBBp6ke3AKC/mm7po6V1FeD
         3U2KYZ8bKSMGQ6KYZFsOAPj/LOZMzraF58d3HZuOor1wcVfAZYk9xxIna+ND0+b6QK
         eLa3IC4sYXKZA==
Date:   Wed, 19 Jul 2023 18:08:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alina_yu@richtek.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] regulator: rtq2208: Add Richtek RTQ2208 SubPMIC
 driver
Message-ID: <9eb5d3a3-ba26-4e68-9324-9f1ce24418b9@sirena.org.uk>
References: <1689758686-14409-1-git-send-email-alina_yu@richtek.com>
 <1689758686-14409-3-git-send-email-alina_yu@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s7Tf4Ty8R9yCnV/7"
Content-Disposition: inline
In-Reply-To: <1689758686-14409-3-git-send-email-alina_yu@richtek.com>
X-Cookie: They just buzzed and buzzed...buzzed.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s7Tf4Ty8R9yCnV/7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 05:24:46PM +0800, alina_yu@richtek.com wrote:
> From: alinayu <alina_yu@richtek.com>
>=20

It'd be better to format this like you do in your e-mail and signoff so
that git doesn't generate the extra line and the logs look a bit neater
(there might also be some warnings about signoffs due to the mismatch).
'git commit --amend --author=3D' should help.

> Add support for the RTQ2208 SubPMIC
> This ic integrates with configurable, synchrnous buck converters and two =
ldos.

The driver looks good, just needs the bindings sorting.

--s7Tf4Ty8R9yCnV/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS4GIEACgkQJNaLcl1U
h9DQVAf9H6OOnhoJVDIuI/nPwr5uD0s4hrJyHYT1gd/JIhhSGk6UQa16fgLqnDWr
YVjprM4X6yJ1TfFIN1DlJuyny2Vc1dO9b1qOfjS2iYPLIU9ZVYjPOwkIHIayR274
TBziDe+hNDP37YXdQ9oy1qFa6PSuH7lbXmHUBJ7G6bvZgiSuhVDBKJUdMwZTkF/B
XqvFPkJ9wERfNaje1XWTvh4RWLLf31gtducYqJO+Q8xLnRdKPmTUb3oRDvTQ1QYg
LVh//TNSQxYmtdlDNbr4vcUAJHxDTuGpRBcLbJkWud8fsMoj9a0XD+zYpaleNmas
fxHRyrRkO0JvspmiJPbOaICeyR04gQ==
=u7Uu
-----END PGP SIGNATURE-----

--s7Tf4Ty8R9yCnV/7--
