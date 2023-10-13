Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE147C86A7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjJMNUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjJMNUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:20:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E78A91;
        Fri, 13 Oct 2023 06:20:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB6FC433C8;
        Fri, 13 Oct 2023 13:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697203203;
        bh=0j+p4gMhFdIWLnm4zbDZJedU2EzXTXnNAOs/EsZTX0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBbOrhzuNJFXYvdWvr2JLqh2YcVYeqqfsnnGkrOjWFufvvmfYE6wvFJwi8IVuwDiz
         cnQ2Pc+di2bIiG9H+uYS7aCLBoNHY46IXoWPZN82JdrGCmMmsh1EWhIDHb33A8JXzS
         GuY227xVrV7SPuIAAughRjQcpONtC5MuPp3z17Ca/OTyq6xhVbJNqckmmkVfLxYtY9
         9ZJ6C8xLt8Z7V1fVt7XlmenJbS1iJ2wpo5Jf1WJN/irUPCGb9ePlrdxWqgLvmVgF5y
         PXXq0xbcdhwqGernBkmEd/gkg49VnXZza5ny+JYDvd/b3rj28hOckLTQOpMPEqKZGe
         dN+Y60iLxEYEA==
Date:   Fri, 13 Oct 2023 14:19:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v6 03/11] ASoC: fsl_asrc: move fsl_asrc_common.h to
 include/sound
Message-ID: <ZSlD+vP0+yCWmB0B@finisterre.sirena.org.uk>
References: <1697185865-27528-1-git-send-email-shengjiu.wang@nxp.com>
 <1697185865-27528-4-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w0UFSr9I7Wnpnjus"
Content-Disposition: inline
In-Reply-To: <1697185865-27528-4-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w0UFSr9I7Wnpnjus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2023 at 04:30:57PM +0800, Shengjiu Wang wrote:

> Move fsl_asrc_common.h to include/sound that it can be
> included from other drivers.

Acked-by: Mark Brown <broonie@kernel.org>

--w0UFSr9I7Wnpnjus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUpQ/kACgkQJNaLcl1U
h9DFGQf9G4UAk1AJO176S6OyBU/9FH3l2Jy9leYRRBkjLWEV2Var2mAPe54QynuS
TBmYeaLGyBINIrPr0lIhRJhIUlR6eVwWSQoKQv6yJpmmcrWw4/NapZgeETcMLkPw
Uil1NJG9PvURiCX+hg1Z+46ctP4pfhD+n6LNyFofy/tmQiHgzy/kdgGCbyg+hiRR
55OhU/8M8R8uTwmPC5ZR2/gEZHzp56V2vX9Gn8jZhduUZNTNZrthPMM5GtjPj2di
A1AEb1vPbwJNllKmRd/wMn3ZsW62dQYQiboRj5jFq+HOBsa0nEsTmjTfKSc2us3m
TMscXvWIRjSEHcy+Hq+nvn+FO5C6eA==
=P3BV
-----END PGP SIGNATURE-----

--w0UFSr9I7Wnpnjus--
