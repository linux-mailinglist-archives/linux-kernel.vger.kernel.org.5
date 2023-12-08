Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECDF80A899
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573864AbjLHQRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbjLHQRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:17:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E463266
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:16:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21356C433C8;
        Fri,  8 Dec 2023 16:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702052178;
        bh=HNMdAMXJERUF53Kjs3E4YL0gn1F8mGeITFeWYHqhCY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DamV/uBPQc58DmxPnUsISkF315n9vxPM3sL0n8Yr8uCCL+/01CCaF3yQmBBMH4RGO
         mLJgBCX1+o8xVVan342PGxbBpaPu78kdasv/k6JEMMZNbS2MpDWwDBdMDB3DPahRNS
         fgT2GGqOPzVBB7fs6jODEh0V0jlGXp0mxPsNnrl50zt1YSQ/RULU5SvLOSZS/wGEs9
         cUhfEGPWWU3JlgAn8sWUmy82kYkqguJxqYbQ1Hre4V1K7REonWSV0N5nGR4vYWL4iq
         vJPI4bEV3CF8tJdvtunLCtzGce4zuQvreZtqgA9meoSPUJJjSAd1FlESjYulOo+GPy
         1mu3I/McX2bdA==
Date:   Fri, 8 Dec 2023 16:16:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] spi: pxa2xx: Update DMA mapping and using logic
 in the documentation
Message-ID: <ZXNBT9/sDSuTrvxh@finisterre.sirena.org.uk>
References: <20231207221426.3259806-1-andriy.shevchenko@linux.intel.com>
 <20231207221426.3259806-3-andriy.shevchenko@linux.intel.com>
 <ZXNAVXRG9aXWlwsu@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7R8vsKA7asubWBkm"
Content-Disposition: inline
In-Reply-To: <ZXNAVXRG9aXWlwsu@smile.fi.intel.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7R8vsKA7asubWBkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 08, 2023 at 06:12:05PM +0200, Andy Shevchenko wrote:

> Here seems inconsistent indentation. I'll fix it in the next version.
> Mark, should I resend patch 1 as well?

Yes, please.

--7R8vsKA7asubWBkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVzQUsACgkQJNaLcl1U
h9DGoAf7BJ32xvvFG1tg3bveQjPCnizwGDyXGr/VZTS5TBu4gy/MGCnnJtoKMyDM
g5hrhRhHaQ1pgkhrogRB+h1eYSJmatyoFG/6O90rXKplKDCmMiJDLjgh0XBEoRhA
GLY8QuXkMPxcabXKbS0FH8JiYNc1SSYlvb2oPSbdZvc5q1lCx8wPrH9PK9zpcR3q
0psdxqq6DD5HVgvVPj7V10e4fXBziBs5EK31sZ4MlR+7ujuFVFFVkZhpeFdZQBn8
qW5JRXvInozVGweNGqixP+SY1KpYd3A8miZlXgwX0YOLQz04aHFjtqP2rhK+qWR1
454pv9eUprrY2CoIWwvnnCU5InHSXg==
=obtJ
-----END PGP SIGNATURE-----

--7R8vsKA7asubWBkm--
