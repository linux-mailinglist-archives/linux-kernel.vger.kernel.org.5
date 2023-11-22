Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C35A7F4E76
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjKVRdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjKVRds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:33:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29F583
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:33:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC76C433C9;
        Wed, 22 Nov 2023 17:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700674420;
        bh=t66ChE1TfPFQ4leVbU+HiiqPsGsYgR/Kpz5G6QVAqco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZte+0tOIJynbrL9ToAI+8wmmd0HyfH5uVghzad/1UqRiaF4C6s9064mdcKt/mClN
         pgwq24bRwtf8ygMWpt4p5hZMrb7ZwXUCZ0ndaCob88viNN8YpRWvHx8ga3I4FWetn7
         WDd2zAPtSC8bmwjqDJQPKlto12h2JK8G0CUQI20jugpDG2gMC/chG23MNx42J6kPKw
         tVYqyvxjIfpVu7WprGoMZWlSoDxHCX8Xdp9PWwI7MHcJtxfAg3KNzTtOFMosg6x9eN
         zGvUNVERXK/xaYUz65ceAMTFf839TioCMlE4VcHoE53yl39au7SiZq+f/vvwakpP8D
         fIHAUxbRfM6zQ==
Date:   Wed, 22 Nov 2023 17:33:35 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Santhosh Kumar K <s-k6@ti.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        miquel.raynal@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,am3359-adc: Allow dmas
 property to be optional
Message-ID: <20231122-synthetic-street-06ed7e0de34d@spud>
References: <20231122083608.136071-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YOGj+5fj3MMWFFjm"
Content-Disposition: inline
In-Reply-To: <20231122083608.136071-1-s-k6@ti.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YOGj+5fj3MMWFFjm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 02:06:08PM +0530, Santhosh Kumar K wrote:
> ADC module can function without DMA, so there may not be dma channel
> always associated with device. Hence, remove "dmas", "dma-names" from list
> of required properties.
>=20
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--YOGj+5fj3MMWFFjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV47bwAKCRB4tDGHoIJi
0ofcAP9PcKnGIruXx/UykDcjvdPLy0KeLgGYzfeWM18mvz4b9QD8DIL1nDA/4qHh
6OeRMcFYhq+fl3z3JCXfCTd3NqnlkgY=
=BeZ9
-----END PGP SIGNATURE-----

--YOGj+5fj3MMWFFjm--
