Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36A77E25D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjKFNj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjKFNj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:39:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D0CBF;
        Mon,  6 Nov 2023 05:39:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3017C433C8;
        Mon,  6 Nov 2023 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699277963;
        bh=164i95hPdxRv+UuJhk1KZYBVCeK2L4rG5cXCDqPVubg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afuuMvtcCdd5uqdfqQIw5p73K+pEyfH0Ox8toKTDj+aEnuGWRqwlD6WhEys7y9x9I
         ObyIWyIfGBeYSo7KRCwQe0AiU5QqLUir1LZeycflSu2TLDgOWvvuRDrwanT0EF0y6+
         JTZRRftToJ32Fed9Uv/eOOpvPz4BWQmFZj+we7jA8TChplHQH4OzXKAGZAXYU1LUZM
         AY2mTErREQ+QFcJ2EYR1sir4evu2uaqJA3gpcOnY1/wNBS5HRwZRSXruowgWHR5kqL
         VbILVc48YxpOvj+qsaMqXj+JR3lB7/zM90D80SWggrLyRH0qnGj1o0vAOktaa6Pfms
         zxo8vZ5MRDQLw==
Date:   Mon, 6 Nov 2023 13:39:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Harald Mommer <Harald.Mommer@opensynergy.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Haixu Cui <quic_haixcui@quicinc.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harald.Mommer@gmail.com, quic_ztu@quicinc.com,
        Matti Moell <Matti.Moell@opensynergy.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [RFC PATCH] Virtio SPI Linux driver.
Message-ID: <ZUjsiHh/ibZKeEQN@finisterre.sirena.org.uk>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qkeXg7wviBwNTmFI"
Content-Disposition: inline
In-Reply-To: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qkeXg7wviBwNTmFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2023 at 06:10:13PM +0200, Harald Mommer wrote:
> This is a virtio SPI Linux driver which is intended to be compliant with
> the proposed virtio SPI draft specification V4.

I'm really not convinced that the spec here is ready, it looks like a
very thin wrapper around the current Linux internal implementation which
seems to provide unclear levels of abstraction.

--qkeXg7wviBwNTmFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVI7IcACgkQJNaLcl1U
h9CKeQf9GMfHbvddCadi4SmgeCvHzILopET84NU5qEnJv77gIUEs1inOz6LFmd2a
07lC/rhDPnc4tKC390IkRLuXTx5+GZZIhXvvDolADmFxwHjxKht+aDEemuSKMfBF
5yUORm2M/i7qu9wqODGOGUgKD03WE+zpiQg/tFOdY+e9j1sl0rPzjQ5vcg7MYK/e
1Ne6Y1YPXIR/PKFG9bfpQ9pJlXWn6ythXxRyvNW3fLpSJSq0Ld1KXbDPokAtrnS9
ThWkjQ0LHzpZZgD5iB45A86nEE4xdWCFbhaFBax7StxdDHm1frKQz9Fx/gaqYMlH
EhaWqkol2tX0XjuCYeVCSE9nJnxp2A==
=Q66I
-----END PGP SIGNATURE-----

--qkeXg7wviBwNTmFI--
