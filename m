Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794EC79F115
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjIMSVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjIMSVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:21:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089DB1BCC;
        Wed, 13 Sep 2023 11:21:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCF6C433C8;
        Wed, 13 Sep 2023 18:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694629299;
        bh=Y9sRmgbSfagN2Ww1D/gZdoYIHedZZ2b1Lbwq3hkHOP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqE5tEgJtrAmH0AZbGSiDiPdqjwk424i2ucWVrW7FCRolz9hk+5Fl+kwxJ8D76LhP
         ONrb+juC0NDZVPT/ajpK4EB4RO3Lsy7uSEwWxAg3tNzxiqCM16k76xsDgb0SRR58lQ
         zsWF9t38eq9ueqsGe2nXGH7nn0EWnPLHT1SYd9rLEm5xHkkWsKGH1v0ocoEQIlGA0O
         Q/B3FrSqh8jROQNqIxcKz+vtMcxPVk0l+1kfsSaqx7xwYs9g8Te8As96E85FIE2t1H
         xPUYYRtK5l5w8f3ea/Ez5b2EA0bRZPnRXOXSM7lUj8ud3dNwyBFCQPQLXbxMe3cPlL
         pmff4jXsOdgWQ==
Date:   Wed, 13 Sep 2023 19:21:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Danila Tikhonov <danila@jiaxyga.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add Soc ID for SM7150P
Message-ID: <20230913-glorified-boring-9f28192f0ea4@spud>
References: <20230913181722.13917-1-danila@jiaxyga.com>
 <20230913181722.13917-2-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+qcWPfvyWIr+xE6R"
Content-Disposition: inline
In-Reply-To: <20230913181722.13917-2-danila@jiaxyga.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+qcWPfvyWIr+xE6R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 09:17:21PM +0300, Danila Tikhonov wrote:
> Add the ID for the Qualcomm SM7150P SoC.
>=20
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  include/dt-bindings/arm/qcom,ids.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm=
/qcom,ids.h
> index be12e1dd1f38..036124336d17 100644
> --- a/include/dt-bindings/arm/qcom,ids.h
> +++ b/include/dt-bindings/arm/qcom,ids.h
> @@ -193,6 +193,7 @@
>  #define QCOM_ID_SDA439			363
>  #define QCOM_ID_SDA429			364
>  #define QCOM_ID_SM7150			365
> +#define QCOM_ID_SM7150P			366
>  #define QCOM_ID_IPQ8070			375
>  #define QCOM_ID_IPQ8071			376
>  #define QCOM_ID_QM215			386
> --=20
> 2.41.0
>=20

--+qcWPfvyWIr+xE6R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQH9rwAKCRB4tDGHoIJi
0ke8AQCaiBZUJf4c14M7gUAY80NVbnOPpiyQy3GfUBCh77X5DgEAgLBUCJ6waJbC
QtNnENfAj4431ZKMIKJY8j/ySDaJzg0=
=87k4
-----END PGP SIGNATURE-----

--+qcWPfvyWIr+xE6R--
