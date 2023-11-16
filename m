Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CF57EE651
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjKPSBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKPSBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:01:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FCEAD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:01:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3FFC433C8;
        Thu, 16 Nov 2023 18:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700157695;
        bh=HjxV6+x2Lj6Px1fg9ULk4x8A75m8iN6mtVZGabMGXQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJ9bfFshTtRtYme9oQsx7SO3RvvPwsphorKqsvKtzOsroWpl4VVly10DpNWJhi3Bq
         vtTRncCwvlyXjlFRb+3aM+AJ6zvuGWeagn+e0G6oeeaDJwfobPKDIvTqJb9ZVg6+kg
         Ra+k8NC2PpnHDEL03KLMgJNNrauuSvLKSnA+XJ3ygoxIM5vpAs1MEHbeOrfMUeWsi1
         5LsO2d2Mjxp4wFP8HQEMt4oN/Zhao1/M+JD2IzRdcMfzyu6KSVL4/9xbvtMj+9vp8i
         macnoWsd+kWEdbpQtOHa5aqL+FzcZM9xiQyw9zPsnpSnnUJCeZ2RLfS27mGKDLL5fv
         5MfFDp8rF8T/Q==
Date:   Thu, 16 Nov 2023 18:01:31 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com,
        michael.riesch@wolfvision.net
Subject: Re: [PATCH v11 1/3] media: dt-bindings: media: add bindings for
 Rockchip CIF
Message-ID: <20231116-viewable-celery-c85c856f8919@squawk>
References: <cover.1700132457.git.mehdi.djait@bootlin.com>
 <a0af1d30e79fb1f2567297c951781996836d6db6.1700132457.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7MtYtqQvBHPj+PRR"
Content-Disposition: inline
In-Reply-To: <a0af1d30e79fb1f2567297c951781996836d6db6.1700132457.git.mehdi.djait@bootlin.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7MtYtqQvBHPj+PRR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 12:04:38PM +0100, Mehdi Djait wrote:
> Add a documentation for the Rockchip Camera Interface binding.
>=20
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>

Provided the undocumented compatible in the example is resolved either
by sequencing, or by swapping out for another device:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--7MtYtqQvBHPj+PRR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVZY+AAKCRB4tDGHoIJi
0nB1AQDrj7ZUQKv1gaJp9ugfqMfxNY7gPb9IvFpcJRAv1EsRIQD/aG49xJLrw6Hu
r91zOYmRs4xFowU/j88DH2aJiDweBgU=
=U6QM
-----END PGP SIGNATURE-----

--7MtYtqQvBHPj+PRR--
