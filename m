Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B480F3F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjLLREH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjLLREF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:04:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3E999
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:04:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2301C433C8;
        Tue, 12 Dec 2023 17:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702400651;
        bh=LQm7aH6ghqJpKj4J3ydBFhDASy4cgy+cbPAS250XPtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pDkbbvh6zFfcu0aSNxDfaQE5KQw7UsETjU5RzG5nVJq9awVEs9kbHQHpgqu7ZIGSM
         cNkXNEc72HjlP1RnJJStsxB6JRu1IgvAKEn7yN5Cohf7rTBGp7rGmkfcOJPjdBoy8S
         lCOMUPvXyZ514uFaeZIgYL+8jJpaRjCUKE+6vHfXAT884sal8mW14g1xMG/ENLBKJJ
         yOy9PIGtxbLB/WXZu6bTFTiLGKs/pu/LtSjfHlAM0r8QvRRjcieBshhHSxMniYu8Ig
         iNxG8x4KNT7fWbkEhfqJnWGKMp9n7J3h6rUSzeTSqk6AGm5o5mXkeNJwBWtrpey5XC
         IdStfDYWsM62g==
Date:   Tue, 12 Dec 2023 17:04:07 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Heidelberg <david@ixit.cz>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: arm: hwmon: gpio-fan: Convert txt
 bindings to yaml
Message-ID: <20231212-scarf-stage-0f3c6947c1bb@spud>
References: <20231209171653.85468-1-david@ixit.cz>
 <08ecf10d-03c4-4025-8809-475fb5ee76a9@roeck-us.net>
 <9b67ad11-c55c-4695-9439-2a9c5d6c1e45@ixit.cz>
 <b327d7e4-35fb-4b1e-bde2-267bba918df6@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="otppeu91Q+M1BT0I"
Content-Disposition: inline
In-Reply-To: <b327d7e4-35fb-4b1e-bde2-267bba918df6@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--otppeu91Q+M1BT0I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 11:42:09AM -0800, Guenter Roeck wrote:
> On 12/11/23 11:28, David Heidelberg wrote:
> > Nothing, as I was working on others ARM-related bindings, it just sneak=
ed in. Good catch.
> >=20
> > Should I resend with adjusted name or can this by done by quick adjust =
before the merge?
> >=20
>=20
> No need to resend. I'll fix that up, assuming you get a Reviewed-by: tag =
=66rom a dt
> maintainer.

I think it is okay.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--otppeu91Q+M1BT0I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiShwAKCRB4tDGHoIJi
0mNDAQCLZ2OKvdxwgStqi9QNZmPO4wuo+ujqqalvfCgkOw7JPgEA5rPXIyolvj5K
0BZcN+wtandQRfYBdIJUD7vmRXc7DAA=
=sk9Z
-----END PGP SIGNATURE-----

--otppeu91Q+M1BT0I--
