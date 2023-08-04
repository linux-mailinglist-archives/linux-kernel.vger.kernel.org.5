Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496D6770041
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjHDM3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHDM3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:29:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213A5EA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:29:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8511661FC1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FA0C433C7;
        Fri,  4 Aug 2023 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691152170;
        bh=eDhioqNPMNkU0sujYiKJAGwY8iQAZh0cUz+KYdvto8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aquZ50BReMEUNm4dlp3tjrl/SwyydfyEJjENHeBJP5igEOuwpdfVrOyJBEe/78oON
         YIyA2TE9y0bEdng9JFWNkFwBOeU+MXkXAPDphk2jvmtfB6qF/ZyFbu5gasK6DA6lqi
         jzHHN+zE/j6aPHXmutX6kaYUhah6SJlfqVbv1jsPiPshupVGdK9Bql1H4ikrEABYP6
         9ovH/Tx8clZEZdeiSLsenHG2wYL0KIvh+3gJCifw94cL7NMhjRbiUZYx/6/U+0AYMC
         qmt90iRFa1+bhOzM+DrXCU/NQT4lH7Nlo+S5DRajFVsc1iwUMHJqSm3yr1y8cxF6JH
         TvCR5o1nthgcA==
Date:   Fri, 4 Aug 2023 13:29:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] regulator: Make clkin_name and xin_name static
Message-ID: <378e245d-4d85-4e61-8152-350f5aba179a@sirena.org.uk>
References: <20230804084634.30492-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jgaZfPb+kNLsBTbR"
Content-Disposition: inline
In-Reply-To: <20230804084634.30492-1-guozihua@huawei.com>
X-Cookie: To do nothing is to be nothing.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jgaZfPb+kNLsBTbR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 04:46:34PM +0800, GUO Zihua wrote:
> clkin_name and xin_name is not referred elsewhere, so make them static.
>=20
> Signed-off-by: GUO Zihua <guozihua@huawei.com>

This doesn't apply against current code, please check and resend.

--jgaZfPb+kNLsBTbR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTM7yYACgkQJNaLcl1U
h9AQhwf+IBeutNXjtF4mqeKKRbtxK91P3/Fe+AytS9RXnEh4NMYge5u2DBZ4fFSU
a+J+iJC58/j/Rbwdyp3zYMXpY07LkTa6Ij+x8dn+vhcrVdijcG0IWm9WB8Nz1lPz
tzmWqiUwXsFGE887JgZMscMXp7llBmrOn013OO1aWY0NjDwsc55XS1Ryrz/vEdzm
Xk84atxVpzGoOmvYv2lElWyE3Z4ORURhD3sbhIfAUfZ7m9pYDh9lQLesIFky2x91
PWIhsl3C40dmd/4JqLLJyVMyQ0W6YWyO9CE4FO1SHrueaXLfcJIt6qJ5AC4yGib2
2Dlx1jY5G/zMHEQeHQWaD91Ut89i9w==
=q4xA
-----END PGP SIGNATURE-----

--jgaZfPb+kNLsBTbR--
