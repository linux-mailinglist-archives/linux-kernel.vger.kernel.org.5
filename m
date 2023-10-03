Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212507B6F36
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjJCRDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjJCRDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:03:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA2AF;
        Tue,  3 Oct 2023 10:03:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746A5C433C8;
        Tue,  3 Oct 2023 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696352588;
        bh=2CYnWvtXt90mgRwSHfw8tCk2sH07p2olXVL/VqC8WNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1hsbnL4fm7Bv7ZICc/2FMKW/20RphpnHCx/Tn5Ui54gN20adbO2TOvmk+RMmuLzM
         N9UE1KGku3S8zV1O0OQRdM0Yfunb5tZIAofpsRhc5tJalERLTpKu52j30Nyr9Gnprr
         RnHTqxyL/ptiiPPIaG3x0z+SZZimAvF0dT+ex/1pR8H+SEcEvDR9Q0FR1XKSCma831
         lGCFYnhC6w8jeq0IZbWBEqFNQsRcL+d7NZN0cX0WPnBcwh9sxGxXHtCU9Pio9IxQbN
         ppTPLz1XuHDxdsNzRDcC8LxVmHp1Vlv8jwzjvqoah1sJjyAXPZVdU1AAWS+MIS79PU
         RE8Vwr9POl5hQ==
Date:   Tue, 3 Oct 2023 18:03:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Javier Martinez Canillas <javier@dowhile0.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: submitting-patches: Suggest a longer expected time
 for responses
Message-ID: <68a9bc07-07dc-4e97-ae0e-e0b29c808707@sirena.org.uk>
References: <20230913-submitting-patches-delay-v1-1-a2d48c5ca205@kernel.org>
 <87y1gjen5d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Jz4o80Rm23Rqhve"
Content-Disposition: inline
In-Reply-To: <87y1gjen5d.fsf@meer.lwn.net>
X-Cookie: Oh Dad!  We're ALL Devo!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9Jz4o80Rm23Rqhve
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 03, 2023 at 09:33:34AM -0600, Jonathan Corbet wrote:

> I was hoping to see some more comments on this; it is a fairly
> significant change in the expectations we put on our reviewers.  Oh
> well, I've applied it.  I wonder if we should add a note saying to look
> at the maintainer profile for the subsystem in question for more
> specific guidance?  Of course, it would be good to have more of those...

It's the sort of thing that's going to vary quite a lot with things like
the point in the release cycle as well (as the existing text already
gestures towards) plus the complexity of the change, I'm not sure that
setting explicit QoS guarantees is going to work out well.  The list of
variables gets long and complicated, and the more explicit things are
the more likely someone is to be disappointed.

--9Jz4o80Rm23Rqhve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUcSUYACgkQJNaLcl1U
h9Ag8gf9HduXLtJgMwI+3EeEQhIZIMvFNRa1kIyisAaAw/T2BBNHnujHGvh6Sp00
2KQZ4+LiPMvmzzt10YXFTsK5L4E7HqrRIdcoRog8WVdQlQjKOgsMxPHUkP8V2E1l
mOsC34R5VK8WDGp7BbhUWqWbFoqADUOGRwNs/gULaTap5tSsvHGQOKpqYzL+M/Lk
iwaG8PQgAZ8urJVuf1aUH6AW4JIKG0s3hDn4PDV63lFMjIHuF0gnrZvJ6QvvUIdz
0bocxGJkt+T+Smayrelvjr1eX3AxLKAUbNYUIuZXr682bXDOVTIRyQqG1geV0rmk
rkc3V/GWC+geogdNu1Y27RKhbkmQmA==
=VBdU
-----END PGP SIGNATURE-----

--9Jz4o80Rm23Rqhve--
