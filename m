Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FAA7AE751
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjIZIFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZIFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:05:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96D7D7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:05:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DD8C433C8;
        Tue, 26 Sep 2023 08:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695715511;
        bh=rsZCnHsDg/PSpS8ECalwOE6Ou4yPp9BLhohJjYFzlX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXymruQtjxxIfXF7x2pLNjT+Cw/C2uEmv5orKU35FTj+vbbEC01C4qgIqpiCFMaok
         XIgE1W1f3z+zgmBAfhPFRQowvDFFXWRleyOtXdP0wWwyWW1yWlt5TAatkH2ThtmyTn
         qHmUH6SYZKwk8TCnhgTQrIIe49+QTYpNbpoLQJUAMRkwYwfBcxMFKYJFF41KRxeOUW
         3QRUjFNfVRacwEsEZy2IyISRFNsCQkkrbKkRFS67o5p5dg9cleivUbnzfLBLNPpV+c
         v4m9XB4Lsd3VvDUcRXg8ZgnH+6nOi2UeytogolSVbCUnpAMD6LU05cHPPccPKwGgl2
         7+0H15BVTPURw==
Date:   Tue, 26 Sep 2023 10:05:09 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RESEND v3 0/3] regulator: mt6358: Remove bogus regulators
 and improvements
Message-ID: <ZRKQtcXB88qN4fET@finisterre.sirena.org.uk>
References: <20230926043450.2353320-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t4jJH+6O6abw2Jmm"
Content-Disposition: inline
In-Reply-To: <20230926043450.2353320-1-wenst@chromium.org>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t4jJH+6O6abw2Jmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 12:34:45PM +0800, Chen-Yu Tsai wrote:
> Hi,
>=20
> This seems to have fallen through the cracks, so I'm resending with tags
> collected and patches rebased onto next-20230925. The diffs remain the
> same.

AFAICT this is still in CI.

--t4jJH+6O6abw2Jmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUSkK8ACgkQJNaLcl1U
h9AvCwf+MXnwhG2vsZ8drBJHxcx3EXvkQQZMpfD4wlotjD4+QnKW1G84AnsJcWZT
GAOsxYzvyS4iPV9umnqB4bLTXz1YMmtgTFjb5vTcUiJBSElJs3487HUGMemlIceC
aAUa89XY47crMgR44d7MtVUlj7Hb9uHXXI6eZalrkYnkyj2KQt0J/dmI3HU4pZkY
ajZUFrWXnqw7dX7wWsXAXE+TIXkikpOWWu52w7842Y0KTzpzqHK2gvB+biUpxkLm
e6+EPGCLIa9G/yKtUfRX1IUCX5Fu3aIqNeR+simLYSnpsc14VYQg2UYy7APIjdYZ
1dAmQtTSnAICa/V82P/YejQvP1QjmQ==
=48cD
-----END PGP SIGNATURE-----

--t4jJH+6O6abw2Jmm--
