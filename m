Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218E177B9A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjHNNUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjHNNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC73A10E3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 813BD63985
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18314C433C8;
        Mon, 14 Aug 2023 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692019170;
        bh=QTndECYOg55ffK7u+UZgLqjvQshZIZdUZRl+Xg0M9/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H7v0ZUAer9qx4bwV7BwpQXiK5HLcqG78YtyN2M05EUoHHVTw+PF0/u+JmhAgAIfRL
         JjtEGSq8ahXUkIzeGQHDfOJf+ClEwpa7hWHSnyopEqcRAb1hHT7kRZKHIDunk5lruP
         +FTKEyMEdfvwwbAeg4RZfHXtsLznRkWS7YtJ+0lRTVGMq4b//SO0mL8eMBn+CJ7KA6
         9Rt7yLDbrzL17b34RuFyDBrclLs5zCauq3BFJjZU6cv9J57s03jvaoUbuU7Ndt4eRS
         PX9ES+2T3TAzcj81+wMIwtjcqv+SzMGyTTNPtTj4gGUWBnXgGnITcQ+t6Ehfp0SUGo
         Ikt2FTV/e+aEQ==
Date:   Mon, 14 Aug 2023 14:19:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/25] ASoC: pcm: Drop obsoleted PCM copy_user ops
Message-ID: <e2026463-f5b6-473b-8d54-6f92a785ae90@sirena.org.uk>
References: <20230814115523.15279-1-tiwai@suse.de>
 <20230814115523.15279-25-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sh+QDjkuwhChmasm"
Content-Disposition: inline
In-Reply-To: <20230814115523.15279-25-tiwai@suse.de>
X-Cookie: FACILITY REJECTED 100044200000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sh+QDjkuwhChmasm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 14, 2023 at 01:55:22PM +0200, Takashi Iwai wrote:
> Now all ASoC users have been replaced to use the new PCM copy ops,
> let's drop the obsoleted copy_user ops and its helper function.

Reviewed-by: Mark Brown <broonie@kernel.org>

--sh+QDjkuwhChmasm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTaKd4ACgkQJNaLcl1U
h9CiCwf/RrTLGykI41WM2odLHtQ2vTwEAFKNFZDrZziq6Om5TS+AifxSGAao83Ig
1nEwo5FoVDK7ea6UIpYbQKobhnMo9DExW2SdJU/h1uqMD3eWYOyDsBRcGTk6VI98
468QcTEYc/I3VLWyp8BksQXqjDHgFUizNJYs+wpfOR15ANeN5BjqNJPRFp8O6DBY
ZPVrkWl4LuBhynQbL2Z+b1mJ37Vygl9Um3rbEi42KAgYE1ID0PRr2N+1DxShWfzm
ap7HKIVBeJHc015MNPlI/EPkqquRX34g5g+FdI/98j92E3m9JUo7bBpovms5l7Ye
+sM0WnE2lwUHpwMJuzlKzrN7VNjLIA==
=upSp
-----END PGP SIGNATURE-----

--sh+QDjkuwhChmasm--
