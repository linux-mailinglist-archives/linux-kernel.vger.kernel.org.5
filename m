Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B6E7C840F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjJMLIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjJMLIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:08:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988DDBD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:08:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAC4C433C8;
        Fri, 13 Oct 2023 11:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697195301;
        bh=hi+q84flLYEhDprUoXom2DC+HzOy1jmWdIiU+rrG4tE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B22j3g4gdWW4b5wVYF+39gQrY4nyelWgMQzGW0RpCtqEySm/ov64ySMzMo/ACkp9l
         isEbikqLOG10KNRRkvaHf0NX1UGdaOOM8Ed90vbHQalp+ZjorFYdIKSJPlD7cs1J3A
         bSJPdOUobkCgV7DNW16xtTujfsbnfLtFRjmbJKItavW5CSVR1RiWg+htWSNQR6bZq4
         N8qDZmhMbUsXgWguQmfBtOVVH3LBDszrmlUw7MFM48JZpaWK4A8GUYSJFfwXOKqytB
         xLqH/nRAxl+szGprP+BNNve6Jzln5fEbSM94x5nYupHmwIM1gkF2E+iz9prE2vHUe0
         QD2fQVtOkUkAQ==
Date:   Fri, 13 Oct 2023 12:08:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, maz@kernel.org, anshuman.khandual@arm.com,
        krisman@suse.de, james.morse@arm.com, ionela.voinescu@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: cpufeature: Display the set of cores with a
 feature
Message-ID: <ea73efc8-87f1-4441-8118-281688065e35@sirena.org.uk>
References: <20231013013016.197102-1-jeremy.linton@arm.com>
 <20231013082948.GA13431@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3I8rgvoMR9dErHZb"
Content-Disposition: inline
In-Reply-To: <20231013082948.GA13431@willie-the-truck>
X-Cookie: BELA LUGOSI is my co-pilot ...
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3I8rgvoMR9dErHZb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2023 at 09:29:48AM +0100, Will Deacon wrote:

> That's pretty neat. Are there any other caps we could switch over to this
> new mechanism as well? We have a weird bodge, for example, in has_hw_dbm()
> to print a "detected: ..." message and I wonder whether following the
> example of the AMU would be better?

There's 32 bit EL0, though that's a bit different...

--3I8rgvoMR9dErHZb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUpJR8ACgkQJNaLcl1U
h9BMOwf+J8IOx0JHYL+AtYtZr3OW7QwKGj2r51ktEXQC7q914StIZ0PKp/menLDb
mYnCMfwY0dgvlv1IsUJXbSud4vrEO/D3lRtTa32cT0rg06lMD0w6isWigocPGwfI
a3KskryY9Hm6ri2XcJnJfMzrmM0LB2VNytYEeF3ra0eVENJFF5YkIaUnUFEQ6UFk
B+mIoKPiHNhwaV/8qMOp+X/QOuMvlv8T274rflx8xM9Mz5tj7qzHc/vRMHw5E9/h
0e0FMZoFeL7ORKrD9zJ/2HSdq43fOdLEJXmioJn6k/d5Yo+SLGll7rERdVvw+a96
x3qMV9FlPZKcuSu3al/oqv5CP9WaLQ==
=Aipq
-----END PGP SIGNATURE-----

--3I8rgvoMR9dErHZb--
