Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9697D2DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjJWJMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJWJMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:12:53 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA66E97
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=Prsb
        8L/rB7hjs8LFPDfXLYORDTbC3nZD3UOHdKFhLsg=; b=DnyULfnhAuByToTpQwQ5
        Oq1LqgmHxlSo+FSmJpNPenmMVuZmLxoFqEdB80vjqZSzwvX8dm31peW7tFRo+cz4
        tjIvX5GGglCcqPFDZUHFg2ReG28Gx8ZN8E9eQg8PhUzd8RNCfkGr27cvwFJ2UXNP
        NcmuLY6FrMEk0HJV9/kGhR53oEs5FYMK81cmtfjIqGh/hAjqrHthJI3Y/St4fEH6
        8OxardlfX/VcquU2pskFNrKRnTk0NksArkel/ARed9AsGa3cbr5hvH39G3W0UCnp
        tsdqDaignA8oDizHWneez47WY72TsNkWAhzE560sQ8Nv9kd8tIPTWst2Uf1nrF5H
        xw==
Received: (qmail 1886524 invoked from network); 23 Oct 2023 11:12:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Oct 2023 11:12:44 +0200
X-UD-Smtp-Session: l3s3148p1@VRj4n14I9K8ujnvq
Date:   Mon, 23 Oct 2023 11:12:43 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-renesas-soc@vger.kernel.org,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: ethernet: renesas: group entries in
 Makefile
Message-ID: <ZTY5C0nxat6/dOXO@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        linux-renesas-soc@vger.kernel.org,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
 <20231022205316.3209-2-wsa+renesas@sang-engineering.com>
 <94f652d4-4538-e6ed-9476-f982fd07ee97@omp.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+mZpJWQzj+NJ6ZRe"
Content-Disposition: inline
In-Reply-To: <94f652d4-4538-e6ed-9476-f982fd07ee97@omp.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+mZpJWQzj+NJ6ZRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>    Wow! Another one? :-)

Yes. Hooray ;)


--+mZpJWQzj+NJ6ZRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmU2OQgACgkQFA3kzBSg
KbZ9TA/+KoEDf70SZBJS/PaXDPl1Rg7e9ggvhjMjkMSXPu4maHyQXDMpS4wp0Q2G
OkJdVm6Y4JVGaSQZIKOTrVABW5nONZlPiEtAIaroiDamIgld0xvG3yFZ2346hGzj
zJZZzMUgIm61uq5AfP8ED4wp/OfBok5Bk2X7HGVzuW7H55sQ6FvgQ6jo3Pp/fUZp
33TVLce2r/u3P9vLtB4utlyVz965CyUzAxKD/orVHbaApVA2y5mJJA4eHyLp33LE
3KN7NFs9lpD44b+mBvVjrgyYa5wpDBgEs2qc6AqAd1osrFO/8yjMrQ+lyKsUQvm7
l7H35VoAyxvywmFnp2trMBApZdvtbwcIsHuUpCBwEuLcAuzaDGcRVrJoxd4jCn/l
t8DPpXWRlFWRmp3BVpBPgkhd1OLKGtghGjPLs+i5vc39XZ5VO7Svvkxy/W4RYNO9
OxDfFGCGJF5eaJxa8tBSLx0eUGTwWl26ciFBMMHjecQCPI7TDX+ErS4tJcR5b/RE
VO31By8j9YdtIlx945Up9F27EcdMfjHMm4cQobSO9TeV6KFzZ1ufcXxArHBwX6K1
7JQsP0P1P54XzdnMUYHn4vI4iZUuNNLdaZvcliK+RPUUFqWO7wYUeVYHx04ZaQgC
gwpANEGPlom4P8y8xQQ/Z7ygV9xOCDFuHKkAv1Us2IBgsRP5N5E=
=fP2D
-----END PGP SIGNATURE-----

--+mZpJWQzj+NJ6ZRe--
