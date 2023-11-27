Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B12D7FA293
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjK0OYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjK0OYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:24:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F23E271C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:12:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6912C433CA;
        Mon, 27 Nov 2023 14:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701094375;
        bh=3M3eAvRak5VkuHb1qF6UfPY/VDhQYEaOoWcLA4J5rzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3GI5ZRJUjtw4BGG6iIH4Z5qcGKQqFsL7gwDIACB2AtOfjalRVvlpnsTPGqu9QZhL
         h/U5eCOW49m3iBzcbdwRcWozvXRXN1Ay4QuxqQhJsYq5VjqwAA9C3/ruxFupcus+Cd
         6Ggvv4OvbMWYx/9o9//RcPrWmPUsIFZdB6837oNRRB4cQX69q7NrOtwAHUI+nZQQdy
         c6hbBI5+8fRg4hnpUNI/kfL9TO87C/i4QFbUt2umoxI19fbxngZEDwHmoYi/2tJSI0
         QsvAjivvzNZOxAk0qwxZpgI06gzVOGEJwrCm5h3DYuVQbImCH+UgbXNiOp/hTackXb
         IPpH/5zdJDHqQ==
Date:   Mon, 27 Nov 2023 14:12:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: event: Add regulator netlink event support
Message-ID: <ZWSj4+Ag739Axe8O@finisterre.sirena.org.uk>
References: <20231121101331.22837-1-naresh.solanki@9elements.com>
 <ZV9MNdOCkIpLB+6Y@finisterre.sirena.org.uk>
 <CABqG17jRbqcw=QioyZTPFTidUDiPDgBFbm45vfvG2Sc5TOznvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oDd1BHQPG3/7aQgq"
Content-Disposition: inline
In-Reply-To: <CABqG17jRbqcw=QioyZTPFTidUDiPDgBFbm45vfvG2Sc5TOznvw@mail.gmail.com>
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


--oDd1BHQPG3/7aQgq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 27, 2023 at 04:07:45PM +0530, Naresh Solanki wrote:
> On Thu, 23 Nov 2023 at 18:27, Mark Brown <broonie@kernel.org> wrote:

> > I'm also not clear on where the 15 byte limit comes from.

> I felt 15 characters would be sufficient for regulator names.
> Would need your inputs to make sure here.

It does feel like it might be a bit tight - perhaps double it?

--oDd1BHQPG3/7aQgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVko+IACgkQJNaLcl1U
h9CuzQf/UU1KwfF/hjjNCCerMedUlINTl8qjsOfWDV84z2/fnUGX5TjjaOIGKDNV
I9UviVuBKTC+WbrZcHC5Svn7E8q/p5dQ7a4P8LU79ndRtGSBP6R2H7Ast1eTquqs
zEHIAbaTov2+9U/ngyh80DAadSCzHwH8qCkIhXSABoO7L2CYZmdQCF9VCYyaD+tx
Jhws+45N/WkssgtW8kxuoPF77QBnB7ikH5yeYbhDQjxPEYw3SIizR6B0eqZoQwDY
5in2C45tYk3n2q5TV2XivhADkGFzcQwrF3+lrP2jg0qyj/EvxAMddtGsekHBW0rU
7bMPJTmGUp1vuuP4MAhl4TE2Mo0bmg==
=1Ldf
-----END PGP SIGNATURE-----

--oDd1BHQPG3/7aQgq--
