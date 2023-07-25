Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41E2761BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjGYO2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjGYO2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:28:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D673213B;
        Tue, 25 Jul 2023 07:28:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16DA861703;
        Tue, 25 Jul 2023 14:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D9DC433C8;
        Tue, 25 Jul 2023 14:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690295284;
        bh=pLcGjTdvsPWLtNuFTaVkfHigxXLo+fNXVIF1U1P7CPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=StVl5h3+QO2ZWslM97azeV+4ZyU/B/KES+LtwQn7KkU5oAA9Yfx/d/eVYYC5P1BQf
         xWJUMuWvPX6Apk2rqUELDpN8/9l4nUvJMDGGn6yEy3gpHmGO72Fy3pnpfUm9RCZXfX
         YNVd6sKyMDWzNrIqAZKcBaA14WBX+vbT45ENK0V6zDdOuLyisB162vQNsvaS9PweW7
         /wK2i4LlVSQsh8X7ngrDj/0yfaK2jyOK+pX2A5VDtUC3qAvzh7c2bWnZlEYl78FvHZ
         VJhfKbMg8AC+EgkouoMBscBXhI6X6L9yBSlyJ9falHnzL+b4dnqHSZEXXMSInbKdyP
         y9/o4l+kBP5fQ==
Date:   Tue, 25 Jul 2023 15:27:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/1] Documentation: core-api: Drop :export: for
 int_log.h
Message-ID: <29369f0b-732d-4d20-9afa-0918dba0f512@sirena.org.uk>
References: <20230725104956.47806-1-andriy.shevchenko@linux.intel.com>
 <87a5vkb0ee.fsf@meer.lwn.net>
 <b761d010-ef21-4be6-b6c3-678498b7fa71@sirena.org.uk>
 <ZL/W5rc043oPLfMV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eQzzTH+PTuaQADBN"
Content-Disposition: inline
In-Reply-To: <ZL/W5rc043oPLfMV@smile.fi.intel.com>
X-Cookie: Happiness is the greatest good.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eQzzTH+PTuaQADBN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2023 at 05:06:30PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 25, 2023 at 02:46:33PM +0100, Mark Brown wrote:

> > Is this the same patch I applied yesterday or a different one?

> Hmm...
> I do not see anything like this patch in your current ASoC for-next
> (nor in for-6.6). Did I look into wrong branch?

There was some random patch you just sent me the message ID for in the
replies to something from Stephen which I'm fairly sure I queued,
perhaps it was a different thing or git thought it was a noop when it
was applied?

--eQzzTH+PTuaQADBN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS/2+0ACgkQJNaLcl1U
h9CWugf/ZkE8tnRDZ8V5xvbNkjHRdkJUvIlBwjPjQQbY6ySAGZdrgwhgaUEB7J+5
m6yCDqE0ZSGaGzqSHT56DBUal3qmo5UUVaXzpIqF2sJdpCx04T4p8I2exgpH73oG
dpFK6JSICXHbozc8OYysARMFyzho2Yb1AoBY27Tp5aVxOzo1GLi+gXjCSd+2k4dC
BoSp25WhKDr7jM8dJ1s6M9nD+4MXyEOcJ0SyWMw6tXs4Z4YN3H5vHlwGBiXT/daF
5EQkAGdFPNjYbpIpVTX14oyKKTYktA9l5vscjpg2qQpZZXKE0cJ/c8tQov8hlmr+
pxeZMSxAz6z5LfJC3AjOlC20hWBdHQ==
=F+Oi
-----END PGP SIGNATURE-----

--eQzzTH+PTuaQADBN--
