Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AECF81301C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573043AbjLNM3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573010AbjLNM3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:29:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40D3113
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:29:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0759DC433CA;
        Thu, 14 Dec 2023 12:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702556959;
        bh=ZrgiopH5ZvwjxmVIyJYm/63eTL6WoWUQTuAoEP2dkAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYWUTK+m5vvrarorTLsDgr31MVemoxcyrk/O6p2BcN1rFb0rTqR31KicpgKkIqdVN
         6yOaBRUGHBCJyhAqJa9Fw+yAWIWp8N89Na0UixNs5DaaSCE7/iXIMj5iwzZ9gixzX4
         2wB3wRWDxtZ5xcYbRbsXb/C9IEQJCGLUS/hx/gdrH75gxrTFtbdOUjjwmcAna61zbf
         EDBEJBomOWfY+AzdxlE21tc8YRoK0xtnyhnW098AoX3IucKZMgO3EQmo1/cw9/C5Fb
         H98pkYtWZwu8H3tE7E7JhbFS63y9CaqNIpGLVrfW3nReIUp1DoJ1AYjkTaovEFZXfS
         voe7xkxDO+XVQ==
Date:   Thu, 14 Dec 2023 13:29:16 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Donald Robson <donald.robson@imgtec.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        frank.binns@imgtec.com, matt.coster@imgtec.com, airlied@gmail.com
Subject: Re: [PATCH] MAINTAINERS: Remove Donald Robson from powervr driver
 maintainers
Message-ID: <b76jxgqgfuipd7fhwlyrecay4j6fi6ptcoiypf52tpg2iwz7tn@6it54w5c75rk>
References: <20231214103353.122257-1-donald.robson@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7hc5enx5fvafxeg5"
Content-Disposition: inline
In-Reply-To: <20231214103353.122257-1-donald.robson@imgtec.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7hc5enx5fvafxeg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 14, 2023 at 10:33:53AM +0000, Donald Robson wrote:
> I will be leaving Imagination Technologies on 2023-12-15 and will no
> longer be working on this driver.
>=20
> Signed-off-by: Donald Robson <donald.robson@imgtec.com>

Applied, thanks

Good luck on your next adventure :)

Maxime

--7hc5enx5fvafxeg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXr1HAAKCRDj7w1vZxhR
xcPUAP9/IAB0sooZA/RTZEE9Id/2UyjW7dkuNR6Z5UFyUmmL1gEA1hj19mBq3nuC
oxSWmnS8rVyhkS5tXtWZiZrHKBy/vgs=
=ELuv
-----END PGP SIGNATURE-----

--7hc5enx5fvafxeg5--
