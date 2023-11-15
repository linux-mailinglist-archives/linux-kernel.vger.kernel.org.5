Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC07A7ED1DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344346AbjKOUPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344325AbjKOUPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:15:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE8A189
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:15:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D298DC433C8;
        Wed, 15 Nov 2023 20:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700079329;
        bh=Bbzb1vTCJhBLDKVrgOv4pZV0dgnqbfTs4W3PaSvXEEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TlHYt8IA/CyoMsKQz709eLjfBDgNDjLBYqa4M2nCYi2pBRr23ymewLyf+92LOvY/P
         glhNCLfzB2rI/TCOapp3rqz4t6LHQ8YDpRGZeYYLNNNJ6oQJS1Qik33+dyyjpiEyFo
         84Uv+5BI2NCJHkz0IK5T0w2v5cncxXZ8ouNPO0gYO5Ktcp7VmR1tHka4dlOlMIgOv5
         vDFNDTJPmIg3CbqngmzfGFjkFHwZ+Jre9z0LrkE1u0SmngwEwc9vWHCteCfG1DT/Ma
         +Hh8POFY+Lv826SV28cGV3iBvTSfpmkV/tC6KzO8D9YdRqCHvmYlkhbX3DkvRvNTsO
         BC9m+9jP4/rMw==
Date:   Wed, 15 Nov 2023 20:15:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bret Joseph <bretjoseph@gmail.com>
Cc:     wenst@chromium.org, angelogioacchino.delregno@collabora.com,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        zhiyong.tao@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 3/3] regulator: mt6358: Add output voltage fine tuning
 to variable LDOs
Message-ID: <638afac6-0d2f-4bb1-8101-b58fdc03e303@sirena.org.uk>
References: <CAKpemQKo2gigO44amj=eFUXgUnUeSmiOoTbS8GdXMx3O07N1vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hjQL6OBH+N1k/edv"
Content-Disposition: inline
In-Reply-To: <CAKpemQKo2gigO44amj=eFUXgUnUeSmiOoTbS8GdXMx3O07N1vg@mail.gmail.com>
X-Cookie: For internal use only.
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hjQL6OBH+N1k/edv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 15, 2023 at 06:52:12PM +0200, Bret Joseph wrote:
> *In mt6358-regulator.c*

I only have patch 3/3 from this series, what's going on with
dependencies and so on?

--hjQL6OBH+N1k/edv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVVJtsACgkQJNaLcl1U
h9BjjAf/Yl71ZXLLJjNgAs7f5DuGYY1nXuxU+QJ/PpLeeuQD7kNmuzPXZBufNtyz
82dlF9dB/ifJmr3WIFlYfX1aHFoWv4rSytB8mo9U1bWJv40njuko1i5LRQe+8QtF
h/H2Mi9xtE7fPdqKX21oRF7hOnCfwNBoNgQ2yrdtBs5TNMaGEbpZXxcIEj5dB3X7
npz0iglU8L8y6M+B2kPm5ieYASraIFrynjKQeedaVCZi3Rj5nH4V5AdSIXiw85P/
6yFDGKma1N45NJ6zThrodEvsUSrfvOyBPPozdLkqhB1SSHEFKzVHZgXweJdi2YQL
0CfOFVCvjuNRM1zyVu6lhBji9jfjUg==
=XWLB
-----END PGP SIGNATURE-----

--hjQL6OBH+N1k/edv--
