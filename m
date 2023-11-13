Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C99A7E9DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjKMNvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMNvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:51:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC11D4D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:51:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4F0C433C7;
        Mon, 13 Nov 2023 13:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699883492;
        bh=iFqPahuoh83wumWgleLiz2RLpBmfYMkmR7DyuX8vPYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/qKU1sCTST4XCiq2rnBXveYW9qQv+zyGbLqewoNKnkNUTQYTCrnxvw3cnfVsdRYu
         HoIJ+1lHWFyd5GfHuUunvKpCg35IgwF6E3DgwOsCGClSFyqsXHlfq0j97ZOqqP7VnI
         7OZy/0oBD0457n7ZPn/jdueNcgZSCMaaosxZmPebs3pQP0ju0HPRAREaoW3dH653ge
         ZatDRycD+NBm2MOub1wOjm4/Oj613dGYgWa9Lpg0FjqQQsCh740xWYSKJwCVNaHXvH
         N3N0Pey5zr9hO5pm+8og1XzRR6qOq6V6CCqyQFoQG44LPHnWxOsZ7I5y6qifnTUZ6W
         AWKD0ZCrMZkBQ==
Date:   Mon, 13 Nov 2023 13:51:30 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: gpu: samsung: constrain clocks in
 top-level properties
Message-ID: <20231113-sultry-cold-d63dd9f015d9@squawk>
References: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
 <20231112184403.3449-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LALutWf/IvU4IogO"
Content-Disposition: inline
In-Reply-To: <20231112184403.3449-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LALutWf/IvU4IogO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 07:44:01PM +0100, Krzysztof Kozlowski wrote:
> When number of clock varies between variants, the Devicetree bindings
> coding convention expects to have widest constraints in top-level
> definition of the properties and narrow them in allOf:if:then block.
>=20
> This is more readable and sometimes allows to spot some errors in the
> bindings.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


=C5cked-by: Conor Dooley <conor.dooley@microchip.com>

--LALutWf/IvU4IogO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVIp3gAKCRB4tDGHoIJi
0v+fAQD7A3JOI53hTzh+WUXEKjg8LoR6kIE2f8e+LkynWk0urAD/YTToVxHZBwiP
mGKW+HpWeaaFQ+b4lscNPK2HRgp58gc=
=gltR
-----END PGP SIGNATURE-----

--LALutWf/IvU4IogO--
