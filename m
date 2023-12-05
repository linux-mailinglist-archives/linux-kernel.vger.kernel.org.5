Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4BB805C1A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjLEQpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLEQpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:45:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4459FB2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:45:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9873C433C7;
        Tue,  5 Dec 2023 16:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701794739;
        bh=o1M+nlk6jJzeO/YoD5xUafyJrbr1p46JNbX6xuBw5WM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSWy04BK6TZaQJD1mkD9eoczv7Yt4KpFXcZOcjecr/Ko2e9jZrj/oc/mMzQGlJH6R
         c1l9VLHaQzsijpN3ooCe+fG2pjpTzrrnXacegXRu6TBF7rBD46pGIJjrykXdzgavdp
         gkjhWPOo0sHbECwSSnSyUCO4EPIcEHKHDEPQVqn85OzcBVxW/tatuLYLGpZYEEIAZ/
         zPf4JZPabz4394EKhANz9yBTGFDA9cXBE001j4L49CAC5ZtCvGh/d9o2AG6VXbjvWD
         kLWzECGu72uBgJF/ieHUU5Fe7cncNbQiNN/3xzfboN0ZCGz+xSYImlBiKXKBe/+AzD
         1yuqAqH3VeOmw==
Date:   Tue, 5 Dec 2023 16:45:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Cosmo Chou <chou.cosmo@gmail.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, heiko@sntech.de, jernej.skrabec@gmail.com,
        macromorgan@hotmail.com, linus.walleij@linaro.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        cosmo.chou@quantatw.com
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: add asteralabs
Message-ID: <20231205-doubling-spoof-5d84651f50b3@spud>
References: <20231205074723.3546295-1-chou.cosmo@gmail.com>
 <20231205074723.3546295-2-chou.cosmo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rAm/4yGST2AjEB8T"
Content-Disposition: inline
In-Reply-To: <20231205074723.3546295-2-chou.cosmo@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rAm/4yGST2AjEB8T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 03:47:21PM +0800, Cosmo Chou wrote:
> Add vendor prefix for Astera Labs, Inc.
> https://www.asteralabs.com
>=20
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--rAm/4yGST2AjEB8T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZW9TrgAKCRB4tDGHoIJi
0hL+AP9ORce7yVwxb71IHEd5gRbFwkGEY0JQUJoR8mu7kkNXaAEAnJtzl3zl0EVk
+RpRjJAWC/gzeP8VESalMJMQbb5SHQs=
=2mh3
-----END PGP SIGNATURE-----

--rAm/4yGST2AjEB8T--
