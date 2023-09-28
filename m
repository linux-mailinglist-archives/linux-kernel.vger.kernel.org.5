Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C767B167C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjI1IyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjI1IyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:54:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441B8195
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:54:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FE2C433C7;
        Thu, 28 Sep 2023 08:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695891244;
        bh=/Y/YLIi4rLlaX9qo7IT6ffy1/nl+3oL3sxDtAxfHEfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OVeH9GsQ2YHlWLStVAxAB54acZ+8Po4YcSanosrsAxxCnjITyEN9ACkQ8zuVI/C77
         2V9P830OYSczHLweQIGfs82CgepJ5xDwX+np49sVdu/nXrBaTpsuJaysivFb+DxEGv
         HNjl+aW1+YSIkLJCRWedIReKecqUnUnG4lOX+RMbocA0l60SXOb/rs6oggTJJ3J4Ed
         0KQ6jpzt8zpc+y6BzB1bX9tY02I4Irz0bZ39kYGxBrQmaEpM/zdbDDfYe5xdYRbknd
         FVKe9uoZXjHcX5944AWTIOjO9prwFw0+FU5mMUq+o85VwANmSGDNkJKtT89Bvpq7xq
         dOxIQGBQ69jlQ==
Date:   Thu, 28 Sep 2023 10:54:02 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Document that the NXP i.MX 8MQ DCSS driver
 goes thru drm-misc
Message-ID: <nbb7m32cjtxxqnonouh6wl3qswfcuhkmycnkgvn4njxvjd76et@udnxb3lenbyi>
References: <20230925154929.1.I3287e895ce8e68d41b458494a49a1b5ec5c71013@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kayxkznrfb6sydgg"
Content-Disposition: inline
In-Reply-To: <20230925154929.1.I3287e895ce8e68d41b458494a49a1b5ec5c71013@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kayxkznrfb6sydgg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 25, 2023 at 03:49:29PM -0700, Douglas Anderson wrote:
> As per the discussion on the lists [1], changes to this driver
> generally flow through drm-misc. Add a tag in MAINTAINERS to document
> this
>=20
> [1] https://lore.kernel.org/r/20230925054710.r3guqn5jzdl4giwd@fsr-ub1664-=
121.ea.freescale.net
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>


Applied to drm-misc-next, thanks!

This was somewhat conflicting with
https://lore.kernel.org/all/20230921105743.2611263-1-mripard@kernel.org/

So I removed the imx exclusion from that patch too.

Maxime

--kayxkznrfb6sydgg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZRU/KgAKCRDj7w1vZxhR
xWaNAPsHpEEbK5oADf0lboe90NZgx4zw6MmYBN7miPnJCZU1FgEAkt/61t0jhq5R
9Tsudpyj4W8o3p2r9sifIQX1piXShg0=
=mzDY
-----END PGP SIGNATURE-----

--kayxkznrfb6sydgg--
