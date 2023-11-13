Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F687E9D67
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjKMNlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjKMNld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:41:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC38799
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:41:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD88C433C8;
        Mon, 13 Nov 2023 13:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699882890;
        bh=imLL6/JRDLObZt2bzkUsGUWoL8XyvG0qghRtgDvjR5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8gmxtlsMGBbAMpANUoXzVGxYTH4QhlWK1vKrzcg+G3BhfltwSQHUOITxgkdJwMww
         AmT0TgCTjCgzz7R76KE9Py8aNI0dQPTMDjlrIoimulE+dvXww02LbgwQfH248lSWC9
         xu5Z8NOUOehgf87pE1yaNhrxiQkqS1lzPd9aml0X5XMHRQIpQ4SqM5T9aRLl1bIZw/
         HuoTeB5/MMar5/ew9JXFa3mPqRBJtQXcfgAC1yIyJZDEjLjIHKSSs2wLXverAtDbxY
         rfgQ41vpatoY3vwKsD+qV2L1JECmg0fxM5AlmBNAOefFX5wREQOwbG41tMfPZks+vu
         7J2kbTCa8pp9Q==
Date:   Mon, 13 Nov 2023 13:41:27 +0000
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
Message-ID: <20231113-left-patchwork-09a1f88b0fa2@squawk>
References: <20231113102535.51074-1-anamaria.cuscoo@gmail.com>
 <20231113102535.51074-3-anamaria.cuscoo@gmail.com>
 <20231113-discourse-sushi-e8fea2450a44@squawk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8+VS1xS0nEywSzDR"
Content-Disposition: inline
In-Reply-To: <20231113-discourse-sushi-e8fea2450a44@squawk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8+VS1xS0nEywSzDR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 01:40:40PM +0000, Conor Dooley wrote:
> On Mon, Nov 13, 2023 at 12:25:35PM +0200, Ana-Maria Cusco wrote:
> > From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> >=20
> > The ADRF5740 is a silicon, 4-bit digital attenuator with 22 dB
> > attenuation control range in 2 dB steps.
> >=20
> > Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

One thing though, the bindings patch should come before the driver patch
in your series.

Thanks,
conor.

--8+VS1xS0nEywSzDR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVInhAAKCRB4tDGHoIJi
0vF8AQDT2fFMriDRdvgwr5oeud6DLkelqFt/Wd4NvVbI/S/hHQEAiaffvbhzd8SU
kQsIvfzMAG/8jXl/nKH6AF9mVx2vvgE=
=bgqF
-----END PGP SIGNATURE-----

--8+VS1xS0nEywSzDR--
