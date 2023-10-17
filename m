Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354217CBC73
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjJQHjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQHjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:39:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83FA83;
        Tue, 17 Oct 2023 00:39:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008E3C433C8;
        Tue, 17 Oct 2023 07:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697528345;
        bh=E3VbYqSMvyiuHUGdccKqMdLJPOjqHC/bdo4qEHIAeUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLRvHJ6pDXK67WrNVe+iczMpc4sdd59wHvXDtmiVyYSS4kgiT4gY4ESbvC+D/aBeC
         mC0Qwe0Pf6qNjvoTklFkR/LNPL3woOPLeqBg9eL4uh9auBBuwaZjYKeg2ZoweXnk5s
         r1ZgKXgGv5MyEmvpKOOykYGYFeLWK5YUMO5a2usoVBDmZD1vvap2blDYtu1s1X8MuI
         e05vOHVl0RODMOxM2NLuBkSrYob321SgQ9iJd9QfwK6xrc556uESKDQmgS3cSIJjLV
         +vZmqqC6kxurd2YmCYbMZpVHDWbvyHmDr3JR/IQ/dXHXlwtS7+SzjYvHrUd1eYZZsJ
         k8ZUKAQCsxN3w==
Date:   Tue, 17 Oct 2023 08:38:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: re-order entries to match coding
 convention
Message-ID: <20231017-grandma-unsuited-e922a2fd24de@spud>
References: <20231016181909.368429-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1+71Q60Wioam/cGb"
Content-Disposition: inline
In-Reply-To: <20231016181909.368429-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1+71Q60Wioam/cGb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 08:19:09PM +0200, Krzysztof Kozlowski wrote:
> The DT schema coding convention expressed in
> Documentation/devicetree/bindings/example-schema.yaml expects entries in
> following order:
>  - properties, patternProperties
>  - required
>  - if blocks, allOf with if-blocks
>  - additionalProperties/unevaluatedProperties
>=20
> Re-order few schemas to match the convention to avoid repeating review
> comments for new patches using existing code as template.  No functional
> changes.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--1+71Q60Wioam/cGb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS46EwAKCRB4tDGHoIJi
0iYrAP97qYyTlCLaxrpzHug1qLPaMkDNoEDl6vLYwErKorOmjAEA+o9HNVu2/Vnk
aEwghWPY16NO2j39CEu9MQuwz4GAawM=
=mnUY
-----END PGP SIGNATURE-----

--1+71Q60Wioam/cGb--
