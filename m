Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182A47C86A2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjJMNTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjJMNTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:19:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1FA91;
        Fri, 13 Oct 2023 06:19:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC540C433C8;
        Fri, 13 Oct 2023 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697203174;
        bh=VcB5/8seKLmFDKdT+kSos3+IFwbNg0oQ1SdCP/8TYHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbcC9b27ZdXTw0KnKGi8PnmGOavWx2Gz8d4m0p5n5/7E9X9+vyu7GPIfIrdLFl0Ab
         35RfJ7QgW6JBMdhQjh7UBRa8hJtxuUoCwY8bRJzqyD6b1xlBjtnXvRRlUi8Xx0oQkh
         MZ/Qcs7Ef2LmSkA3+Lp1tuqd7o13UbsXF0jfVrIeWAGf5/dYkAL0b6drKRqjhZOFo7
         EX0sL86XrC0M3KG88/RmOilU7l/LUjqACrD+sCn6YR3H3U+8y+3v+hgFfpqud6oIPJ
         dVsxrvWMCWP/jLVu4rABekQRNayIT8VF/I1TCf0YaCxqg5/iJkhXLAgtNkhoVQ0mfK
         8VqTw0G2zuBMQ==
Date:   Fri, 13 Oct 2023 14:19:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v6 02/11] ASoC: fsl_easrc: define functions for
 memory to memory usage
Message-ID: <ZSlD3ee9x3JsZL7f@finisterre.sirena.org.uk>
References: <1697185865-27528-1-git-send-email-shengjiu.wang@nxp.com>
 <1697185865-27528-3-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ytqlM95q5yypPr0Y"
Content-Disposition: inline
In-Reply-To: <1697185865-27528-3-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ytqlM95q5yypPr0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2023 at 04:30:56PM +0800, Shengjiu Wang wrote:
> ASRC can be used on memory to memory case, define several
> functions for m2m usage and export them as function pointer.

Acked-by: Mark Brown <broonie@kernel.org>

--ytqlM95q5yypPr0Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUpQ9wACgkQJNaLcl1U
h9DNngf+M3/aOmhL3QysiOuRsmxBgDZuzkyGRwIBeMdlNnRJ7VM13CfbjkJ0D8Ju
ku9ojR2jE52TiXcKQIoyv4iD+gMIndsFMEOEEI8x984ZsUVkd0HR/L6YtiL5g2qI
y523Dzyvy5kggmINayFGOBActp7aD7hzGUgJ2EqknrmhztzFMoDM/wpvunBAC/+z
2rSabJ8Ss7YcNAyXd619KZFpf2bNoGEXOvMWZLm3lUidNJfMsSzzbVfivTrBByyR
wDY98oN/ssmkuUAMKKGJtyimFc86LHl4VFzOHk88+srmpiE7P8o6iLRu4ioJ8IYW
5VMlKcs7NwJyryTiAvEKLcp6harRFQ==
=oQdR
-----END PGP SIGNATURE-----

--ytqlM95q5yypPr0Y--
