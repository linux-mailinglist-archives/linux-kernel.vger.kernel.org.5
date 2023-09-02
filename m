Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E08679077A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 12:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352026AbjIBKyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 06:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbjIBKyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 06:54:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11A2CC;
        Sat,  2 Sep 2023 03:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DA18CCE2542;
        Sat,  2 Sep 2023 10:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9A3C433C8;
        Sat,  2 Sep 2023 10:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693652034;
        bh=5mUneaMYsihzWac40KTej7cQHjUWMP3FfxWNxAgPEkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dL4rU5o8pCsKc2PY7aL5CGYUYhElJpKvmfz3MDOOSpTbA2vmzJMGSoWJIuGe71k81
         OB1xk5+hCq/07LiGqbDBfgEjEicbqlOyv5dbiw848ZF18qhE6XzjXrXWj2mn83YD1G
         /ZM3trcDbUEl0eMbnOilM1Kl7gvfut9Y1xXAESaT6ErtkAewxHVemsYktL+ukXA9iO
         ieS1CJcZ0NtABhPMCJuCvSv4y9ZfQLG3UA3kUo6xutH58roKzvaI+8Tw/mCqGHOe6c
         P427fH++cyWfiQA0MfSGcBzNRd7clZHmFOeW+Mp2ooV472Eq3UzHZulxjU8naFuHSR
         Z+l23hbl8RUFQ==
Date:   Sat, 2 Sep 2023 11:53:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: media: add bindings for stm32 dcmipp
Message-ID: <20230902-undone-mobster-234b589d3714@spud>
References: <20230901155732.252436-1-alain.volmat@foss.st.com>
 <20230901155732.252436-2-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y2l6E071THuAoQbt"
Content-Disposition: inline
In-Reply-To: <20230901155732.252436-2-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y2l6E071THuAoQbt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 05:57:20PM +0200, Alain Volmat wrote:
> Add the yaml binding for the ST Microelectronics STM32 DCMIPP
> (Digital Camera Memory Interface Pixel Processor)
>=20
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--y2l6E071THuAoQbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPMUPAAKCRB4tDGHoIJi
0mJUAP9nsxwmCpy9C0wAB98r+NuyBpnBXvMJkEM7Sxp8M7zyYgD8C/cME37tRoxC
X9j9prRoXAsDDO1R9EO1/JcMhzGh6QE=
=dnj9
-----END PGP SIGNATURE-----

--y2l6E071THuAoQbt--
