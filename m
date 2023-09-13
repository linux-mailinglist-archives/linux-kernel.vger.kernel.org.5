Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0179F118
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjIMS06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIMS05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:26:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B04B19BF;
        Wed, 13 Sep 2023 11:26:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA822C433C8;
        Wed, 13 Sep 2023 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694629612;
        bh=UFV7zP5tyJ40jV42UWBAuRyz2SyHbcKwwfIEMcks2k4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JCN4T9sLTQRErWsGDCpzusTPl0ej2CCeg2Yo3JxKlJdSsu5sdTdXb2SvuSMyOzjnV
         lWrIcBrxFLmJavSmmaGqE+zopvnF/WetN9nQa6zu2I/YYN2fJByWFBplcseW0BFZVJ
         k8mAL50We/PtivzY2Ms0xsdBJXtrTGByJs8RRkdTsdNzT+sa25y1eDVcijgfBeFfGr
         GuQvUk3YVuGcR9HGmaG9McBEZV04sbfOaksyIzvO34SxKK8+g7R2+n58kR4lodinPR
         macn9AsVtQYM+71N8CbT9lyR6GOExm0rAll/ZH9n5XPCjdDPIEh5syE9f/D1/URiW6
         Qp9GsRPTm3cjw==
Date:   Wed, 13 Sep 2023 19:26:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fabio Estevam <festevam@denx.de>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3] dt-bindings: media: Add OV5642
Message-ID: <20230913-undocked-geek-757dddbbabd7@spud>
References: <20230802160326.293420-1-festevam@denx.de>
 <ZQHbm4K6tDs6ILo+@valkosipuli.retiisi.eu>
 <19523723a202647d0ab5135581f5090f@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Cz26fDXXOWYM34jN"
Content-Disposition: inline
In-Reply-To: <19523723a202647d0ab5135581f5090f@denx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Cz26fDXXOWYM34jN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 01:04:06PM -0300, Fabio Estevam wrote:
> Hi Sakari,
>=20
> On 13/09/2023 12:56, Sakari Ailus wrote:
>=20
> > One more little thing. Do you have a driver for this device? In upstream
> > there doesn't seem to be any.
>=20
> Correct. There is no driver for OV5642 upstream.
>=20
> The DT folks asked me to document the OV5642 binding even without an
> existing driver.

IIRC, Fabio wanted to delete it from trivial-devices, and Krzysztof and
I both felt it was more suitable to document it properly rather than
delete it.

--Cz26fDXXOWYM34jN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQH+6AAKCRB4tDGHoIJi
0kkYAQC6vj2RlUbCg0OXQd98YYAr7B/57FlK7szBWiyG9QkyDAEAz0ACHpySb+te
ROPdsELitYoYGCmrM0rpjRxwELHsRQw=
=dvWP
-----END PGP SIGNATURE-----

--Cz26fDXXOWYM34jN--
