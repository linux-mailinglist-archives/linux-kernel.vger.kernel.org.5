Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818A5761A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjGYNq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjGYNqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:46:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6D81FF7;
        Tue, 25 Jul 2023 06:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 837006171E;
        Tue, 25 Jul 2023 13:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C76EC433C7;
        Tue, 25 Jul 2023 13:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690292798;
        bh=JZqrPn+/DHRI6pWh4me2MAQvwy7w4laz7lhHcxIHSxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2gILGbcAHKPc+dC4tnYImKJ8Lz6VQz6UgiEbMc2w+TJIzDMlkPw8kkC7EiZd7Q0B
         wSjleOQqtX3QaxF1h1zqruU/AmEW6FGOtR0GlWzOVrStTevaYkxa9L54+ZlNo2k0KF
         bSOqTF2M7wgBcoxCWLMNJkrapbSqbOc2KVI+ZZSzeBqVaTwQ0li+mP4VgWBWpkgTcw
         JpS0rtVsjdNM11gXgUxMho0Qbs6wGzV+7TUPE3fadPTOhTofY0/ipoEcWTSBaxA8bj
         Vf85uFdzOGyVZ08wyPOT1ge0v6F5uUwQQBuATHRD4QCRdE+A0oHjmSK9n7FUyjLDFc
         R45KWZoFXkrDg==
Date:   Tue, 25 Jul 2023 14:46:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/1] Documentation: core-api: Drop :export: for
 int_log.h
Message-ID: <b761d010-ef21-4be6-b6c3-678498b7fa71@sirena.org.uk>
References: <20230725104956.47806-1-andriy.shevchenko@linux.intel.com>
 <87a5vkb0ee.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sx+tKS4ZQ5MXdS0r"
Content-Disposition: inline
In-Reply-To: <87a5vkb0ee.fsf@meer.lwn.net>
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


--sx+tKS4ZQ5MXdS0r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2023 at 07:12:25AM -0600, Jonathan Corbet wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> > The :export: keyword makes sense only for C-files, where EXPORT_SYMBOL()
> > might appear. Otherwise kernel-doc may not produce anything out of this
> > file.

> So I still can't take this patch for the reasons described before.  It
> looks like Mark took the patch that added the problem, so perhaps he
> should be a recipient of this one too?  I'll add him to the CC...

Is this the same patch I applied yesterday or a different one?

--sx+tKS4ZQ5MXdS0r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS/0jUACgkQJNaLcl1U
h9AVuQf/eS2VDsEqbQkWzEHHEkArGf8F18F0Qgg37XCfM2YZnAuFeYTHC7GheM44
6cOWRRWa/PeOO4ywBCddgHokVy54IgzKeRoTP4au9slwbskxrrdfd3cjy2FMzQe0
iUJmMSeky1zuvf+tZeNKTcrrV7bYF0chIpD8HhLcq9qsdiz+I8sxCuYmsu+U50L7
pUJeVlVB+LZ8CmhTpc8MYYMUcavdGoCbW3/0GDB2onqn/MsJQQBGYAOdRbGGl3Wc
t6HD3Fo6QCF5PA3wm0+rgI1qtAT8hVhKukGEdS2A6xnUqN3hmftjbFX1kS9pmSZa
J2bDUU7+2DwkR91t1L8bANya5PrSbg==
=d9c9
-----END PGP SIGNATURE-----

--sx+tKS4ZQ5MXdS0r--
