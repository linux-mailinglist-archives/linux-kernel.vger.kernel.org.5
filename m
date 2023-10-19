Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8347D7CF8FB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345603AbjJSMc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbjJSMcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:32:25 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C95A4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=aqk3
        wiGiuSIoeN9W9kpG0br5Mv4pr5LCTTheHJq9Ffw=; b=XyLCKf/FUin84lXyJWgf
        rb/fi89+hdDjEQXKM0WSddyhJNlDO8zFdkouVLDrU8AKZeUSafCE/X3TvSPVf8/y
        kMK+48qNmO1o1w8g7TcC97ynZNOSzlP+Q+TslcDZgXHXmi0r+Iy3XqtElO7SHKvJ
        FgmbWZQ5MiBB+bu0majIkn9A3Yb5edUj3zAovMAp2GQtsxxrc4NoiE+ygWjbZmwH
        2pkqyX2pAMfh58F7D8Ss27dnbBzg5x8TRqaHgn1lM77bb4spuWSzaoGu6vB16Xcz
        2BxVx7dZw4DUjDa/GySdVxMSq53vJOgpvVc2pIjrmcMYJsqNumPaYhH1NnshWU7T
        3g==
Received: (qmail 862571 invoked from network); 19 Oct 2023 14:32:17 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Oct 2023 14:32:17 +0200
X-UD-Smtp-Session: l3s3148p1@BdkZ8hAIgJUujnvb
Date:   Thu, 19 Oct 2023 14:32:13 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] MIPS: AR7: remove platform
Message-ID: <ZTEhzYNw+bneveHj@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
 <20230922061530.3121-7-wsa+renesas@sang-engineering.com>
 <ZRUl6+i/o0cqCV+6@ninjato>
 <ZRUrVgHyJvvhteGs@alpha.franken.de>
 <ZRUwEjpfILlF5dgE@ninjato>
 <ZR/DNeUMn+BD2NMD@alpha.franken.de>
 <ZTDtkjXcOkxVataJ@alpha.franken.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UOEar4E6NE9EU2b3"
Content-Disposition: inline
In-Reply-To: <ZTDtkjXcOkxVataJ@alpha.franken.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UOEar4E6NE9EU2b3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> nevermind, I've did it by hand, but using --irreversible-delete isn't very
> maintainer friendly as patches won't apply and I need to do the git rm
> manually.

I am really sorry, this slipped through the cracks :( Thanks for doing
it and feel free to ping me again and again next time!


--UOEar4E6NE9EU2b3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUxIckACgkQFA3kzBSg
KbaS7RAAkeqeipd6WzMfsw8eMlMw7WvZhzSTQ3gpF/d8658RK2kbeevwM3+eCfMr
6RzyVBr1IdTyBzFggd8nnVQSwOCnIigIWeXQFjicTaul1q2ElG6D2h61pGn8L6ni
DZOvjE4clIVy0bkyCk/oHukpelhZu29yHsSVMJHmqrUi5bs0IdBQboTs+rgSV+06
3KaB/RjDXHuVA70Idmpf30aM6emNB/NJ804/M1LKxmDsGaTE3aSODfyasGVdUhHL
ZNZKg59x6t6D9Bszg/Twcrm2YqvS3Pqo1NKY62d/Vov8K48xRNsldSOiLmCE/0rO
EAQ+pF32GJNPNffkz+hL9K9Jl8CJ7XWxR8aEGBg1eq+J49NhNwwuS2FaiXAtBHwi
t70FChyG6Vop+NznDmFrA9+1eW5BPhF1JigA3F86NcrMt+wt06oZBVuPb/RgrUAX
nJf36y2cjKR6X9w+6hujJ7jxyYJYl5CqMfMsKkan1MoBxHejp35wH/6iUF/VeNmE
LViTpQLjV4rR6HDOQzMz/UoZkCvwnOXRHeew7moCTso6J2I+TzCdGgcsfC4HeoIv
HGFRraagC+h4DIQ80lSegxeeP+rbgXoeGhbLeGzmaZPepvDjUD2ngyUnREzFzU1E
pgpnlG18iD/8YKhh9gVTAitelWu0iQd7ckefGGhKD7MnbDAqAhs=
=8SQN
-----END PGP SIGNATURE-----

--UOEar4E6NE9EU2b3--
