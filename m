Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96B3782875
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjHUMCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjHUMCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:02:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5A390
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:02:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2303F62714
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B6DC433C7;
        Mon, 21 Aug 2023 12:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692619333;
        bh=OhzVUVonZj9qZnR29C7qxvX+xg5STIavJSFYMfrZ8f0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eH9e0GULtPn3+7o5CVPiJG3BPQ8RHxvqG1sxgejxRpIxR58MuhfvoCZMK6WXwWJ4a
         W3jmEzqOM0WJChfDwl3w1FQYgAUPSeVxsU9TsEA93Pe7DX1TxAIrhzmPlVVUs9eWOa
         waS0aqcKYEKfOyi8Bq/A9j74C4HfhJI1gT7jXSHBAIL0hdT8HjqKh5lkbBd8UtiIss
         wThKBqCeMkrO6Bcuv6+AdKfq1gT/7ezwIfAQeqz3KojHq5RAdW906gJnRJ5WbaEe0W
         VmJ38zN4lCljt5R0+umjtJ/JcfLgdXTx/g7kVyQpS5paMejr43SsZYR7UxZYauDVeS
         L/oJIZSluF/iQ==
Date:   Mon, 21 Aug 2023 13:02:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Senhong Liu <liusenhong2022@email.szu.edu.cn>
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/codecs/rt5640.c: fix typos
Message-ID: <d420f8ab-6ea8-451a-9b71-75a9d1f6ea7d@sirena.org.uk>
References: <20230819133345.39961-1-liusenhong2022@email.szu.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VHM+pqCkh12UabdH"
Content-Disposition: inline
In-Reply-To: <20230819133345.39961-1-liusenhong2022@email.szu.edu.cn>
X-Cookie: Do not write below this line.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VHM+pqCkh12UabdH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 19, 2023 at 06:33:45AM -0700, Senhong Liu wrote:
> I noticed typos and i fixed them.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--VHM+pqCkh12UabdH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTjUj8ACgkQJNaLcl1U
h9DMFwf6A1IiyBJsCe0gvETDTiyjDS7ZX3iut2wr0PDQjcTQe5Hq5cBQyIvSCKnH
T46lzQ4OdJhMrzet4HIT/CeTYky4nvwwdPWb3L/DWiSKsvdmgjI1BS7jZ9p02aa0
QQIQ08ZKAAsk+wZmmkJjouJ7puPvBU6edDbKOwx7wOmKrkDeJq6FQ92EceFbpUrZ
xPm10MT9ZqV0KJ/8i6Nc7OeaXSzBVBuXr15eijqNh02HECDQJ1dV5VxIJoUgZMsZ
Twrg+XSwQR0Rd3GNAUqS28y6+e1lE9+LWPluBD1zMkP5vJgtx9mETnX4Nur+fIZ6
Z00trFH/gAi/UE3ZAmcN5X0ZJv1tHA==
=C5w5
-----END PGP SIGNATURE-----

--VHM+pqCkh12UabdH--
