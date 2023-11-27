Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1E77FA656
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjK0Q1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjK0Q1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:27:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9C199
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:27:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38834C433C8;
        Mon, 27 Nov 2023 16:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701102437;
        bh=xEgRq5Xvh2zD3GoLKWpaIWoCkKj2HoP9Qjy3LlUgoSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+lm4BmGCWHO5Rlyq5Man5wzNSILo3afnLpcRHq/8GpiJUszLuE+gz5Bsxb7YUg1c
         a7pf5Q0IKsc6xYcNc8+KB7PrWRkober+pZDuoN+NlWEvJhs3JX2qGOkA5XqqduOE0R
         6la3lk9Qxx97LvY59MtAaSpvkINDXwPBFJSSjI0rbbC9Z25wdL9/fppwOkrFsh1IAj
         7UUBbyNCPi7IC0HSnUrGX6pi/dG7Yi6jw1JuIMC/1RMmyM9pwALN7OSZ5jKozP+H/n
         +Ymt9iLVUIkWBdD1EaK2mxisAGF73gFL3lzgjObfy7wWtzAh1FBanvGtL/Hdbtq4Rx
         YLUxHsb2b2PRA==
Date:   Mon, 27 Nov 2023 16:26:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Malcolm Hart <malcolm@5harts.com>
Cc:     Sven Frotscher <sven.frotscher@gmail.com>, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA
Message-ID: <ZWTDPklM4wFzJCsb@finisterre.sirena.org.uk>
References: <b9dd23931ee8709a63d884e4bd012723c9563f39.camel@5harts.com>
 <ZWSckMPyqJl4Ebib@finisterre.sirena.org.uk>
 <87leajgqz1.fsf@5harts.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D7k247d1NH9+CyUL"
Content-Disposition: inline
In-Reply-To: <87leajgqz1.fsf@5harts.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D7k247d1NH9+CyUL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 03:23:08PM +0000, Malcolm Hart wrote:
>=20
> From da1e023a39987c1bc2d5b27ecf659d61d9a4724c Mon Sep 17 00:00:00 2001
> From: foolishhart <62256078+foolishhart@users.noreply.github.com>
> Date: Mon, 27 Nov 2023 11:51:04 +0000
> Subject: [PATCH] Update acp6x-mach.c
>=20
> Added 	ASUSTeK COMPUTER INC  "E1504FA" to quirks file to enable microphon=
e array on ASUS Vivobook GO 15.
> ---
>  sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>  1 file changed, 7 insertions(+)

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--D7k247d1NH9+CyUL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVkwz0ACgkQJNaLcl1U
h9CGxwf+IOavXif1GJ54Jz6u3slzMUOM4s3V9+3Nt4BWPEt6DBlPlRJ2dEqsC3+U
Avr6Z8+qUCFdZkRAsXFonInlcjZvcgzDapuxYowQO6e+X1LorTaq4lEXyS0w5wes
C9p7wHJtSMLJHiyFRTPONV/E8oJGp2Xm2uLDo3iKEv3QKZdm+s8q7Ux69YUwnrMG
5M/TaRjHWVoat1UP5xWDEoId9VfFy2ZCFtUEKZ6uiLK1aU/3STSVmiCsNtCF3kZI
7cqzQKbUd3lFyXP4fb0VRBDCdAulsn2aeBzPWMsHmo3qRdIqva9F4BYX4bxpIk+v
Jzk7Mt9Dr2jBCHHMy3b2GAt6jsyHtA==
=K3vO
-----END PGP SIGNATURE-----

--D7k247d1NH9+CyUL--
