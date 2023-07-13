Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55DB7527CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjGMP4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjGMP4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:56:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B4D26B2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F403661881
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0B8C433C8;
        Thu, 13 Jul 2023 15:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689263790;
        bh=Slsgen3/ErcFO5k71NxOCLG/uLcyaEewBHlP+kEAtZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dUT4Rfp0a8eqdiGeesidGN/muXh61Al5Ufxb0iclgLV3dHNjhkjnD94zL93Ykhmns
         4HHoNznFLFX8lHPaypELAP6BvTKWZn68kEIFrF0+rTdBCPxlWZ+MqmLYgHLtqvormB
         rK8JtHjROFJGr1XWYQzOducFl/14IKI2MtZr0RKzR8eEvgq7MbeS8jrvSl0MlrxeM2
         JdoQmG29eiKosiXq9dVCfItnMRY6bZezXrXt1RC8ZvCPLjEL0ZT5fGpFD6btuvmZLK
         05zTd2Cb1cuouE1DXZdqYYgxSSQowc4fQQG+LY8x/2LnoxD01RZR0Gr690g2STDPz9
         fOXcQOpv4CmQA==
Date:   Thu, 13 Jul 2023 16:56:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: wcd934x: Update to use maple tree register cache
Message-ID: <451e01a2-117f-43d5-9115-05c56deef30c@sirena.org.uk>
References: <20230712-mfd-wcd934x-maple-v1-1-0d7aba4b0077@kernel.org>
 <20230713154346.GG968624@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w0KlgKdOOe6i5GDO"
Content-Disposition: inline
In-Reply-To: <20230713154346.GG968624@google.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w0KlgKdOOe6i5GDO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 04:43:46PM +0100, Lee Jones wrote:
> On Wed, 12 Jul 2023, Mark Brown wrote:

> > ---
> >=20
> >=20
> > Signed-off-by: Mark

> Something going on with your helpers?

That's a b4 thing.

--w0KlgKdOOe6i5GDO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSwHqkACgkQJNaLcl1U
h9AX5Af/cZURl8iUDg3fmPjpNCqNWxl56JUSUpk1T1UnJ9CYBpFC8L8aW6EgTl2J
bmsvoyEP0bhpSvXwOz+8EnMszFSliAW/QrJbWxjK9eR10gikJEFCI+KXHwJO7QF3
ZDx847Nm3mnJ0xlC/bT5NQI7GFTEPSwUcc37wL6etLyKT8JoGSuwP7ic/iS0YLEx
lfiWJUv3JWwHUMLZoXxoad3VwXHIG9neq7fij+moZtljRQ2gHac7IZ3vxm9KHxVF
VBJghzKhsuch5Fqit+vak4qTM9kjP1NKCll11hQJo0nzVMkZJN+LzyqdG8INZida
y5q3oFDBNV5Z97AJXb+V9Xk8soDxsA==
=lFi4
-----END PGP SIGNATURE-----

--w0KlgKdOOe6i5GDO--
