Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AC079075E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 12:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351989AbjIBKln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 06:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjIBKlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 06:41:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B099F3;
        Sat,  2 Sep 2023 03:41:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9BCC60AE2;
        Sat,  2 Sep 2023 10:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FD5C433C8;
        Sat,  2 Sep 2023 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693651299;
        bh=gRq6R3jUpO3Io5Z6IXbWwg+pnvCCLZXm9uKnO2EYqC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nRgCgBpo83Ue3QaHVai+O8iHSWZotP8u3rY6LZM5UBibbFiJU9KpbOG2q26TD6TU7
         r96wytMiMAg7uDCyIuzl0izRnQOTFZHkOeS05s3nFDirQ1pc1ro4kjDMuav6aKRLIF
         OHp5uIImXFAGpCoKIAQC+X5AIfwZCG97NVq7akeyJfs9RRQNVfBfmg1gzxCs2pI1HG
         Z9nP02QAwGHynWuMo45HtnXtnm+yDdBP/LonnuplMk4Kdf9Q3HWkTpIYsS5i/J+Q8Z
         DrhvACL4jtTtCfGErDcE8YagbWTp8kiM7Ja4s8asuk/yQ/p+4YnzVLwDwHSDtMdUa2
         Sh1Gp44o97Uug==
Date:   Sat, 2 Sep 2023 11:41:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ8174
 family
Message-ID: <20230902-e4a05a649a5f17b1e724cd21@fedora>
References: <20230901181041.1538999-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qkghVqtuu6RtUx4"
Content-Disposition: inline
In-Reply-To: <20230901181041.1538999-1-robimarko@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7qkghVqtuu6RtUx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 08:10:04PM +0200, Robert Marko wrote:
> IPQ8174 (Oak) family is part of the IPQ8074 family, but the ID-s for it
> are missing so lets add them.
>=20
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  include/dt-bindings/arm/qcom,ids.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm=
/qcom,ids.h
> index be12e1dd1f38..d2b84a308fde 100644
> --- a/include/dt-bindings/arm/qcom,ids.h
> +++ b/include/dt-bindings/arm/qcom,ids.h
> @@ -203,6 +203,9 @@
>  #define QCOM_ID_SM6125			394
>  #define QCOM_ID_IPQ8070A		395
>  #define QCOM_ID_IPQ8071A		396
> +#define QCOM_ID_IPQ8172			397
> +#define QCOM_ID_IPQ8173			398
> +#define QCOM_ID_IPQ8174			399
>  #define QCOM_ID_IPQ6018			402
>  #define QCOM_ID_IPQ6028			403
>  #define QCOM_ID_SDM429W			416
> --=20
> 2.41.0
>=20

--7qkghVqtuu6RtUx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPMRWQAKCRB4tDGHoIJi
0sS1AP943KUQuRoF4dTadpf4ZyyKp3fwVKeuD11TJLT/SopA/AD/WSCwrPLkOdvM
hgMlhumClOW21VL9Jb3j9HY747jRTgg=
=ug5+
-----END PGP SIGNATURE-----

--7qkghVqtuu6RtUx4--
