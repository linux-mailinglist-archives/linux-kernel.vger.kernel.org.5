Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6271C7CBCA9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjJQHpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjJQHpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:45:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841518F;
        Tue, 17 Oct 2023 00:45:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E81C433C8;
        Tue, 17 Oct 2023 07:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697528735;
        bh=WArevt6GXcxE3WhRBrAB6YfSmlJb0fKxC2Cf185aRsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3EZhgt0Dk1F9+pzg8IHqH36i74VGXQx6rQQr9WhOH6qkqa9fRB3mAIJHRtUNZoHM
         R3W17qyI+PrUOC7EmS2UPqP98ejMWDtrYAlGtWy3mDw2229lvMGOXr8QmNGWDiJOCj
         IZuwNaxYNElv1qDtK7tMlG7H2nJ0geWg/tW6I/2pPHMUlAksqPsk13VYZm+xMkOS6d
         MApx2e9Sf1CUoXabMD/FUos0T477mDdyPfJarX39DpCVUejBY+X4KrdP/RVdO1lWpC
         SrfzbHEL3G6FYtb3k4xjhpcVm2zgpCHWVHJVT6Wz2Gkm/16lsibV+TS14AYFRecmui
         swktSfrImYtVw==
Date:   Tue, 17 Oct 2023 08:45:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com
Subject: Re: [PATCH v7 2/3] media: dt-bindings: media: i2c: Add bindings for
 TW9900
Message-ID: <20231017-primp-outlet-98aadd3c4493@spud>
References: <cover.1697463708.git.mehdi.djait@bootlin.com>
 <d5b2b2584fd471a037e574086bfd193b22fb9587.1697463708.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JONb17A5fbx7YTK+"
Content-Disposition: inline
In-Reply-To: <d5b2b2584fd471a037e574086bfd193b22fb9587.1697463708.git.mehdi.djait@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JONb17A5fbx7YTK+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 03:58:32PM +0200, Mehdi Djait wrote:
> The Techwell TW9900 is a video decoder supporting multiple input
> standards, such as PAL and NTSC, and outputs a BT.656 video
> signal.
>=20
> It's designed to be low-power, posesses some features such as a
> programmable comb-filter, and automatic input standard detection
>=20
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--JONb17A5fbx7YTK+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS47mgAKCRB4tDGHoIJi
0oohAQCQibSmBabT3FmwXEXZUbZIPD5UX0IdIXL8ksNq8BqXjgEAndxurscX6zs1
W9m67aWnBopJUBNJ6YyQlE3zD+AzSg0=
=yiSR
-----END PGP SIGNATURE-----

--JONb17A5fbx7YTK+--
