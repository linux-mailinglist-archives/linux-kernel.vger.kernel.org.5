Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD90076F2FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjHCSt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjHCSsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F032D4E;
        Thu,  3 Aug 2023 11:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 820BB61E8C;
        Thu,  3 Aug 2023 18:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353FBC433C7;
        Thu,  3 Aug 2023 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691088416;
        bh=GFEg2m6DB2KbdjEpaONHepp4fVsAqm7MaT+ukZJmCgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcnbVzceeIb3dwHAqgGzYuX+MZd+B/nCCk8GUiuEVcnKb2FvRSCAc9Nm7aeEBDkJe
         W//AMrZcAmPdtHktj9kbO4ebjRuK3f+enyUUxf+ccrkl8T/GU4DBnniMXHAWBBvN25
         s870lEbIQepWS/I+JQsfPIgRIGm98uMXbo+VKnr2tdC1XFFZC5LCKNAimQ5jJENHgh
         mVV1eOCP8z/2bbzczxsqgNJaNClyHTs2OxTx94vGOcU7SzozFGIAtOdH4dJ5QzUCsr
         gS2Vj6SuwVwoLcmkMmjy+huOQgGzAYoh573AaTY1c9pydxxkfL/hxOh5xJMNZ1swcw
         RiPHIdIbjRsyA==
Date:   Thu, 3 Aug 2023 19:46:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andrea Collamati <andrea.collamati@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: dac: add mcp4728.yaml
Message-ID: <20230803-muzzle-shorten-5e59c2985a3c@spud>
References: <cover.1691066050.git.andrea.collamati@gmail.com>
 <d93dd116cfa7f958c038c0c62993071ea48451d2.1691066050.git.andrea.collamati@gmail.com>
 <20230803-art-marbles-c57091465420@spud>
 <8077daef-bbcc-4162-a9c8-18bae3372878@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wapNLu/LBcZ2UjUH"
Content-Disposition: inline
In-Reply-To: <8077daef-bbcc-4162-a9c8-18bae3372878@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wapNLu/LBcZ2UjUH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 08:39:30PM +0200, Andrea Collamati wrote:
> On 8/3/23 17:21, Conor Dooley wrote:
> > On Thu, Aug 03, 2023 at 02:56:34PM +0200, Andrea Collamati wrote:
> >> Add documentation for MCP4728
> >>
> >> Signed-off-by: Andrea Collamati <andrea.collamati@gmail.com>
> > I gave you a reviewed-by on v3, is there a reason that you dropped it?

> Sorry it's the first time I try to submit a driver.

No worries. It's just hard to know if people do things intentionally or
not!

> So after your positive review I should add...
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> I will do in v5.

But don't post a v5 for that alone, if this version is fine then it can
be picked up on application.

--wapNLu/LBcZ2UjUH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMv2GwAKCRB4tDGHoIJi
0uzoAPoDksbA688aJm4Cr6zqDm0rcUNAucXQEpRVHd1bAEO60wD/VWEuPceGWKat
ui7rltRkgUyDhB+LEmSe+vwnPWzNRg0=
=vYmp
-----END PGP SIGNATURE-----

--wapNLu/LBcZ2UjUH--
