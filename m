Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B0E7B1391
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjI1HGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjI1HG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:06:27 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8691A3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=WnRQ
        HZraydQ/I0WA1ubA16qJ7pFwwHWlgiTiUaPc/vI=; b=aUA2vhO5RUlKsJALmNtC
        6r6oDdvhK/9zdtRlo8qL1DYzvgAEE73lmBrU0RQghfawteX1+kk1miqGHeUIZcla
        gI7pXR/hOwuFP5dFW5ONEUbeRE4RXPLPfcj5lfVehlVa5kmj6b2K8ssDkwEhxxnq
        0n31vmMs7uxg5D0Lo4AtHBt3ORLxe4fzBatAi0JQrSJxleI65Ha8cFF0MIx6wju8
        gPTrw2GSSNUvhFkZQsorCr4+M+4krgUYBgeweOaUfouu7xMjK28FTEjemtoUVVgn
        plhv+L++E0307F88hnXPeUPvhgEo1uI/pnio+2XY3EA7a7x6BxQmcpkmynTi0Bv7
        yw==
Received: (qmail 3365722 invoked from network); 28 Sep 2023 09:06:20 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Sep 2023 09:06:20 +0200
X-UD-Smtp-Session: l3s3148p1@/Hni8WUGJtIujntX
Date:   Thu, 28 Sep 2023 09:06:19 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] MIPS: AR7: remove platform
Message-ID: <ZRUl6+i/o0cqCV+6@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
 <20230922061530.3121-7-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Kk6Pcmg8zt21+RYX"
Content-Disposition: inline
In-Reply-To: <20230922061530.3121-7-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kk6Pcmg8zt21+RYX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 08:15:27AM +0200, Wolfram Sang wrote:
> After a discussion about removing VLYNQ support from the Kernel, it was
> concluded that its only user, the AR7 platform can go [1]. Even OpenWRT
> has removed support because these devices are "stuck with 3.18" [2].
>=20
> [1] https://lore.kernel.org/r/3395161f-2543-46f0-83d9-b918800305e1@gmail.=
com
> [2] https://openwrt.org/docs/techref/targets/ar7
>=20
> Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Hi Thomas,

most people involved in this series think that it will be best to take
the whole series via the MIPS tree. Do you agree?

Happy hacking,

   Wolfram


--Kk6Pcmg8zt21+RYX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUVJegACgkQFA3kzBSg
KbaWSRAAgs8AnRlO8tErt5o5WOQIaQNNnrl5Qey04ZZmQYJdoyMgaWPKvr+SD81w
RNGzpUWQbCuK+mFl1pk+wJ+59z6xfPl1an61RF6nu1Jg+AQpYstyQ28w/stGM/NX
zVxR5zto2kbiaw01qxWMZB/l8YKOEfvphcK0Gm/rgQYzxjcin4QfzFlemfd7IrlZ
aN7axB5UYb0BnF8pHmDwhP3qYQSvQ1VHUc16bu4b2VQIk1pRPqxZ/Mcuwt19aUJ4
KBRi4lEG5qzijKBBkL8JlmaQrzThUWf27rmVO3zl31bkeKFgCWpFVPBF5ykddiY4
1UQabDgGNMGN+mrIyWumw3vpqwucd5NtIfd+kBwYvTlSYdSQkvRz8kYUyW5BNju0
vnNuCYPmOy0pd6mzm+F8BsjIuBzwA9V/aEI1cb5Dg8vru5bJVUHvyKFWZrHaSfBs
qPc43W0OdDiYvO+0zlexRMXkelfZLndQDcFLMjKOyZ83UEi9t2DfFZWhNKjm8yhE
mVWfHIqH4KCZFmGdiOhVPV9LzjlmQ42kI71BfGDsvl0cv1j8hKp9jIHu3eG4TqH6
ntUMZCbtoQ1uCJcl1APwJ222LMmMpXWZMfU+Ox75lDt8o33bWodp/3xqe878X3V4
Dlevx/Xds5IE5QxM+Pv/AdLgjXKJRCVQ7mNVmtD/bIdJTIo5d0s=
=JCLP
-----END PGP SIGNATURE-----

--Kk6Pcmg8zt21+RYX--
