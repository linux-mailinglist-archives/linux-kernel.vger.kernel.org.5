Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5BE761C45
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjGYOvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGYOvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:51:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0078E63;
        Tue, 25 Jul 2023 07:51:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DBA061766;
        Tue, 25 Jul 2023 14:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C61BC433C7;
        Tue, 25 Jul 2023 14:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690296708;
        bh=gjyDXLkC4mnr8WezzRutIPic9c0en4BSR1Ldx+j+02Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u0qb33yuiUzrausHRexOwq+TFO8CmYojNgkzOBxERBhM1YVmCyNveQLHk672twPah
         yJJSiaTozBmiUYOj8dEUrtcOvl0RUhDPpnH3J7NWPOGdffIoaSCcEDiYaCKpEKogc0
         HZ6/j2k4q2opv+6zkOg3xnVdcmkBuZ+K+OIEDbXl/EdxGDWHXTjurQ/BKdqhz4AaGq
         ruE23o7N68hk4u9p4nmmOI/sqmuDN790BbmMVTn+G8MymIeD62W9db3vPpIpOs/8mh
         NR/Vfw0UQ1UBnOq8O0waQX92wl4PfJs6NkLWWDinDN4JAKqbBXUo9IsOGorVnKDvOI
         t3/y3AaG6PqFg==
Date:   Tue, 25 Jul 2023 15:51:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/1] Documentation: core-api: Drop :export: for
 int_log.h
Message-ID: <4f6c9be9-22bd-472e-a20a-cd361b46e005@sirena.org.uk>
References: <20230725104956.47806-1-andriy.shevchenko@linux.intel.com>
 <87a5vkb0ee.fsf@meer.lwn.net>
 <b761d010-ef21-4be6-b6c3-678498b7fa71@sirena.org.uk>
 <ZL/W5rc043oPLfMV@smile.fi.intel.com>
 <29369f0b-732d-4d20-9afa-0918dba0f512@sirena.org.uk>
 <ZL/e9oguxJ8+nht/@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YzYDg1fKvwmUW5cZ"
Content-Disposition: inline
In-Reply-To: <ZL/e9oguxJ8+nht/@smile.fi.intel.com>
X-Cookie: Happiness is the greatest good.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YzYDg1fKvwmUW5cZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2023 at 05:40:54PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 25, 2023 at 03:27:58PM +0100, Mark Brown wrote:

> > There was some random patch you just sent me the message ID for in the
> > replies to something from Stephen which I'm fairly sure I queued,
> > perhaps it was a different thing or git thought it was a noop when it
> > was applied?

> The first version is here [1].
> Then it was a discussion about Linux Next build issues [2].

> In the discussion I mentioned:

>   The 20230713165320.14199-1-andriy.shevchenko@linux.intel.com had been sent.

> which is exactly what [1] is.

> I have no idea how it can be a noop, but the patch is missing as far
> as I can tell.

> This thread is v2 of what was in [1].

> [1]: https://lore.kernel.org/linux-doc/20230713165320.14199-1-andriy.shevchenko@linux.intel.com/
> [2]: https://lore.kernel.org/linux-next/20230713121627.17990c86@canb.auug.org.au/T/#u

So there's two versions of the patch and for some reason v1 was
mentioned yesterday but there's also a v2 version?

--YzYDg1fKvwmUW5cZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS/4X8ACgkQJNaLcl1U
h9DFYgf/ZWPoClzNGrEuYRm2z7PxLQL7AKn9qAWXogSRQy+PBYInm06vbBRKoCJY
RX7v9RRq4PkNaH/Ua+qMWcPT3+qEbvGbb15WOuL00UZrfDEfjcvOoqwA0HL9MgXY
eA8Vk1TRXzZv8kmNLRhyM0NFLOyJ9LYDE4uEpVGFGjr2uqAG2yRJKFu8bPAPR5PW
ki+N/fagypQooKQH8+bJbE6HDqkV6evdtzPZ2/kmgLOEvxzrYpLDqqMm2/phlaob
k9vd2otgohUK3lXgRshyFPA4Ueo6aGYK6DZJlNWcZ/n3bxUiUtaTfUQDxXNmlcNQ
8EE1jyqp4P+kVKS/I59GCLox7oX8gA==
=FUnX
-----END PGP SIGNATURE-----

--YzYDg1fKvwmUW5cZ--
