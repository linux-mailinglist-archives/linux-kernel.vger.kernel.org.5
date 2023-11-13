Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3AE7E9D61
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjKMNks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjKMNkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:40:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B265A95
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:40:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5484EC433C8;
        Mon, 13 Nov 2023 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699882843;
        bh=Jc38+YeAEJg/asevRi2+sruL/UscKvwPMpD7f7Y2NPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ypq/OJ2NgmtyGNGPhQLsGiJHa2GF8jnANtEewrfvSK/DTNkk4XMK4C2l/hJAlyxHO
         4wvXgyhm895rsQ0ltmdGiF6FcILsvIVo5hJComrSRSucnIDc/Kot9ghz55JPqMrzj7
         c1/jHVKiykPbRh3ItIKupqReuDJXLQgL4NibF4cfuuLmnefEIemcNZU2HBmplGFfj0
         Z9Owpel3Y8BpMpS9ptozFxVX2Ww7hkSUExIkCNR3k+A8oDvVswMv6xu9PQsdO+mLGn
         i9GXhDNda5wSaxfPDCofBQ0ZBxy7zSicfxJaeMk2K48BHZQ4r14DtENhqj0+XaQkgR
         FmH9foV80TSHw==
Date:   Mon, 13 Nov 2023 13:40:40 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ana-Maria Cusco <anamaria.cuscoo@gmail.com>
Cc:     Ana-Maria Cusco <ana-maria.cusco@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: hmc425a: add entry for ADRF5740
 Attenuator
Message-ID: <20231113-discourse-sushi-e8fea2450a44@squawk>
References: <20231113102535.51074-1-anamaria.cuscoo@gmail.com>
 <20231113102535.51074-3-anamaria.cuscoo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7/ooBsM+4RJ+q0OO"
Content-Disposition: inline
In-Reply-To: <20231113102535.51074-3-anamaria.cuscoo@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7/ooBsM+4RJ+q0OO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 12:25:35PM +0200, Ana-Maria Cusco wrote:
> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
>=20
> The ADRF5740 is a silicon, 4-bit digital attenuator with 22 dB
> attenuation control range in 2 dB steps.
>=20
> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--7/ooBsM+4RJ+q0OO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVInVQAKCRB4tDGHoIJi
0nwpAP905npL8Vsvxaa97hvoa2Bw6dbXfLWPhe18s2HXMDZcRQD/WFZEinwMbNON
d/9kuV/v5AgBc19b92HaXWGg2PNxPw8=
=CUl8
-----END PGP SIGNATURE-----

--7/ooBsM+4RJ+q0OO--
