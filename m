Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0087A1EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjIOMjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbjIOMjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:39:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0852D3;
        Fri, 15 Sep 2023 05:38:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FDCC433C7;
        Fri, 15 Sep 2023 12:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694781538;
        bh=mRQTHLiQNiezev/fSOVUsH4pXbjz2KXmTCJMT2uy6iU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5VRQBuISF5o0cX4pNz1TeB/qx+iYlw56EvN73M7Keg6VmooMrWleYnOjVJJmDOtu
         z7736AaRdgx4focfn0I03OmiR+HxrUrXlh7W82mFYgjfgGi3yW6M9gV0GTETYHQ7b6
         R3XCgBJ2HArMNRhuShb0qpV24WE+Qyr7Zb1ZTpWO2CM4qUo/Js+LqE/ra2gqiHCTVH
         H2IiFlSvfH0GQ/U7l8DSLqZFaJD6Cg57NbOcPo+YhzHNdhG3WgczJiW2H93s+yts7P
         yIPxAWz4Bja74i+i+SaNG+CNbVKvJLmwiKbwX9EFMgClvrIRHZcCJdwUjKqfPmcKiT
         1gzIseVt5sDAA==
Date:   Fri, 15 Sep 2023 13:38:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     nikita.shubin@maquefel.me
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v4 20/42] spi: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <1c7d3ca5-d252-4396-8209-a8b2560d2130@sirena.org.uk>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-20-a1d779dcec10@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i7I/TpJIjLVV3Jql"
Content-Disposition: inline
In-Reply-To: <20230915-ep93xx-v4-20-a1d779dcec10@maquefel.me>
X-Cookie: Gravity brings me down.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i7I/TpJIjLVV3Jql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 11:11:02AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> - add OF ID match table
>=20
> Instead of platform use_dma flag - check if DT dmas property is present to
> decide to use dma ot not.

Reviewed-by: Mark Brown <broonie@kernel.org>

--i7I/TpJIjLVV3Jql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUEUFsACgkQJNaLcl1U
h9BSwgf+KanICmRYsi086ZOx5WT6SHGv73D96RwtgpLL2/Ef+M4SGlSEotTKA32a
nxh7DgyjXwLCZaRCMQO0GPZp2S13DTxseRqkzeDAR3gUGvfir3UKyH553IOjOZPX
6GY5hoVmjmXhQzzYPDqowgLGIH71gIRLX7KsXG86YwhaNs/XloBx+p2pAFyYm/Gc
k34BM+e0CY6sJ4JJ7NNlTyZS7g7XkoTLgOplojGPksnToDz+X39SzsEhk3dA+BeQ
Il/K/JKM/EoSuvcSK2YNd4l6ddgQD5mxrnCL3i4EWv1/vAWW7OVkEQ/Px33gq57f
Rn02UNn4Nl0fSGYVkKOTJ0+gH0kaYg==
=chJq
-----END PGP SIGNATURE-----

--i7I/TpJIjLVV3Jql--
