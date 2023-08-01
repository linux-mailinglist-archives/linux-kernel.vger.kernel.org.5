Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFCC76BEDC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjHAUzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjHAUzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:55:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AB91BFD;
        Tue,  1 Aug 2023 13:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDF5461708;
        Tue,  1 Aug 2023 20:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E4DC433C7;
        Tue,  1 Aug 2023 20:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690923332;
        bh=mm3PCHxbwsPxpNKZvF47Eq/nkX3Fl3n17TT37Rm9fuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYJpB5TgdglczH9pMWcLYolh/Bqraj/YkJIzZJ6u9wmVzHEAljC4hSb3/OOtTBEeQ
         EsZX7mJyjmZxjeTjWjaln+MUKFSZ80TGplGDRT6Sz511UieJb2dEQsB5MKBcH668p3
         M5INEcXObtUmfMbhpNhSbqV8+vZRliTza71Q2BgeIIJKNIJKSHClQTrKKD1tLaTLix
         pW3eaZgd6gdfB7+bilYeAhhEnOWeFrKL9hyjFgg4oiTwoe4P2qm7rBgLSDiXA9HV9S
         bpoOHzAjZtxMyEZtynw7xr1VA+fiTW2T7ling1zFYpU8eXfSzQ9pFlJG2/mtsvcWa0
         /tLfgYwkOrNvQ==
Date:   Tue, 1 Aug 2023 21:55:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     niravkumar.l.rabara@intel.com
Cc:     adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        netdev@vger.kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        wen.ping.teh@intel.com
Subject: Re: [PATCH v2 2/5] dt-bindings: reset: add reset IDs for Agilex5
Message-ID: <20230801-roast-frigidly-4ea82386bb3d@spud>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-3-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7JizuF9tmWfj3Hnb"
Content-Disposition: inline
In-Reply-To: <20230801010234.792557-3-niravkumar.l.rabara@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JizuF9tmWfj3Hnb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 09:02:31AM +0800, niravkumar.l.rabara@intel.com wro=
te:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>=20
> Add reset ID definitions required for Intel Agilex5 SoCFPGA, re-use
> altr,rst-mgr-s10.h as common header file similar S10 & Agilex.
>=20
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  include/dt-bindings/reset/altr,rst-mgr-s10.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/dt-bindings/reset/altr,rst-mgr-s10.h b/include/dt-bi=
ndings/reset/altr,rst-mgr-s10.h
> index 70ea3a09dbe1..04c4d0c6fd34 100644
> --- a/include/dt-bindings/reset/altr,rst-mgr-s10.h
> +++ b/include/dt-bindings/reset/altr,rst-mgr-s10.h
> @@ -63,12 +63,15 @@
>  #define I2C2_RESET		74
>  #define I2C3_RESET		75
>  #define I2C4_RESET		76
> -/* 77-79 is empty */
> +#define I3C0_RESET		77
> +#define I3C1_RESET		78
> +/* 79 is empty */
>  #define UART0_RESET		80
>  #define UART1_RESET		81
>  /* 82-87 is empty */
>  #define GPIO0_RESET		88
>  #define GPIO1_RESET		89
> +#define WATCHDOG4_RESET		90
> =20
>  /* BRGMODRST */
>  #define SOC2FPGA_RESET		96
> --=20
> 2.25.1
>=20

--7JizuF9tmWfj3Hnb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMlxPgAKCRB4tDGHoIJi
0j/yAQCN8amnEfhB4tqnW7rRuRVU+vga9lWTHsdxnAi7KxIfGQD/RzRlxKV2gbZF
zkFsLzoFDmLwFyZ0m+gs10g7xmc8zww=
=DGyl
-----END PGP SIGNATURE-----

--7JizuF9tmWfj3Hnb--
