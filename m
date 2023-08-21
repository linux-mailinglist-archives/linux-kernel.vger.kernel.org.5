Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7713782B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjHUOJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjHUOJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:09:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B2DB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:09:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3DFF63883
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190A0C433C7;
        Mon, 21 Aug 2023 14:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692626990;
        bh=Cr7450NcU+poqsVMP6DJMTkqMYUeVml3N8Z7plQPus4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrJ2/tT6o+w9nQWLvVzxTUpuOSLWrCHaPG0N4DDyHsjqtvJnm3MQGaAta5PULhsEm
         F59UR7e8va114+bU7R1V8rWby/L3X10wn6XeQsEtljTFtTjINQfucnXeYS1Roc/sj5
         bBbyUw4QuWAd5rKHTLVx/ML0+ntNVQPaT9ARYqasfMAZfMpkIQsnySKbSYhD55sWaZ
         xlDn8YsCHoUQLlAcgBw7gFHeIZ8B6tRXcdPm7/MWH5lCWo0Ii2WXmjFH/gS6H2v0Dj
         NaxyPAjznq6E7Rnxe+t8oJ0JF+VgH28gd//2vWluX6mFKNleJtfqALGONFGkkQGKxp
         ruxsLcwb4XE3Q==
Date:   Mon, 21 Aug 2023 15:09:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     =?utf-8?B?5rKI5LiA6LaF?= <zhuning0077@gmail.com>,
        yangxiaohua <yangxiaohua@everest-semi.com>,
        Zhu Ning <zhuning@everest-semi.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
Message-ID: <9432532a-efed-42bf-8f58-f1dd898ccf61@sirena.org.uk>
References: <ZBr9rJn50ovG1w9W@sirena.org.uk>
 <87ttycjyw3.fsf@mutex.one>
 <ZBty1CdPaWm0IcRi@sirena.org.uk>
 <87r0t9uc08.fsf@mutex.one>
 <ZCRCqJ7oG6oefo9g@sirena.org.uk>
 <87zg2pxtog.fsf@mutex.one>
 <d2be9183-87fd-4cc4-a239-9401b5b88364@sirena.org.uk>
 <87o7j5b9bd.fsf@mutex.one>
 <8cddbe1c-20d7-4b8f-ba02-f86bbb5a54c5@sirena.org.uk>
 <878ra683ej.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y9KCLMLORcJiQMW9"
Content-Disposition: inline
In-Reply-To: <878ra683ej.fsf@mutex.one>
X-Cookie: Do not write below this line.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y9KCLMLORcJiQMW9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 20, 2023 at 12:32:52PM +0300, Marian Postevca wrote:
> Mark Brown <broonie@kernel.org> writes:

> > You'd need to pull the relevant supplies out of DAPM and handle them in
> > the CODEC suspend/resume callback.

> Can you please suggest an approach that would be acceptable to you?
> In the original patch series I sent, you didn't agree to the approach
> to disable the jack detection in the machine driver suspend callback

Put it in the machine driver.

--Y9KCLMLORcJiQMW9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTjcCgACgkQJNaLcl1U
h9DIbgf/ePAP6mIHmngqcNGJ9WWvAls9RCxkXUYoDJC36pZKS8DtrisjdsyaIyZn
MWnzzkYz8M/YFjStIwrnRxEDnB/RtyxSvL+5iBkke6gKFwO/T4LJDT8zpvYI2nCk
AyFwKgwjhgQje/odaGEqzXtONe4ilRwubSNJUfoNr7anCKyMwvAbecAf2sRjghFm
CPr1LicS/GHMQIHX9v2wE5glJKZLEvZbO5Z/BmffClM76mcnJqZPhz338isptuv4
fSpqzWFENQdnUlVOxX2YZY1uuZPp+OIzh8jGXYMxD3wm8flRl/1Z/dijz3hOt6n9
aaC5hA+XJp71zrElrnaLbagQ/VXXVA==
=mjl2
-----END PGP SIGNATURE-----

--Y9KCLMLORcJiQMW9--
