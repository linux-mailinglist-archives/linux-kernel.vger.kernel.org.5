Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CB0791BE3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345915AbjIDROs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 13:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjIDROr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:14:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C35DCDE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 10:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBA8860DD6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 17:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0486EC433C7;
        Mon,  4 Sep 2023 17:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693847683;
        bh=4TBv+hfoSawKYK7q4TRAzz0jWAHC4YJ34BO8FxPlzYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOIHJs9HxaWqT5qRvCdkhBG6JCUAYqOzDHSLHzopSZftVn2EgQbo+hMNC3Q1rK2Mo
         PjyjheNlC0l/FohNCQ5dzApRCT289c5tdYkaBe+ZT1zzRqHKpg61NwQdXDCPvZwvYf
         KKRzjG3J4YVHm7oaZEzTp9zU90Zf5DtPuphxTVcmpBI4RSFmRnOy3TkaB9B0UncoyG
         jH7LaWvZtfCmoi/qnaASzo7c/d1nExMzTYVjXZFtM9ceSxrnDSN8y+Wx/Iep0H89lJ
         1MkQwJ+sNjLa+7EZYrKRGu7cHPoKJ5uEvdCsxmGErqHmN+bHF7i/z9ZXq3BCqh/Tlb
         ULgsypY6SvyLA==
Date:   Mon, 4 Sep 2023 18:14:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, wangweidong.a@awinic.com
Subject: Re: [PATCH 1/3] ASoC: aw88261: drop undocumented, fake sync-flag
 property
Message-ID: <f62eb98b-39a3-4601-94a2-2cc6508cf2ae@sirena.org.uk>
References: <20230904125309.43350-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GXtndeLIKth/q1R8"
Content-Disposition: inline
In-Reply-To: <20230904125309.43350-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Immanuel doesn't pun, he Kant.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GXtndeLIKth/q1R8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 04, 2023 at 02:53:07PM +0200, Krzysztof Kozlowski wrote:
> The Devicetree sync-flag property was never accepted and is not allowed
> by bindings.  It is not used by any upstream user, thus considering that
> it was never documented, should be dropped.

It would be better if we could just get the properties documented of
course.

--GXtndeLIKth/q1R8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT2EHsACgkQJNaLcl1U
h9Asiwf/XyF5Cp/WwF5q7viU6OXe4fP8SaMpwSrssThySvAfFTGHeJY65Mafv7h9
wx8j+Uh2Ug7nb7uHn7+Xipzx19WHwuJPcqQPSXQbtOj6kenClXsafpAvQioC7mKe
rSC//1qVA6sxBCkDHyyGzDG2qZafFUJmNEmyJC+LcbWMCGKQ+OwrBYVoFAhr1x4M
KbWfQ/NTmd7Be+pT3tUawHD8UoZhnTRVKxAC2xtIxex9nLoZ6CAgGMyS3GpYssvF
Pyj9SoeGaLf4JMWel9lnbwCoDXLOQ2jdCTQNlmAMCoUQe5shX4FOJGPEIYjRlT/N
S/yQaRQvl48+CBmHQtsHYLBh4lNAaQ==
=/F0p
-----END PGP SIGNATURE-----

--GXtndeLIKth/q1R8--
