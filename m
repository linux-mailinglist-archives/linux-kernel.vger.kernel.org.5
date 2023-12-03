Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EBB8022FE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjLCL3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjLCL2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:28:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD47198
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:28:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0224DC433C9;
        Sun,  3 Dec 2023 11:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701602933;
        bh=orzCajD4xuOoJi/lwUf5LvDxHuelVRXrKmQIRJJW9n4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lK/wm6V9CYMuSx6gNCSml1sbdv5sGBTnpAilZVadi0NQM0WeLfZMGJxAn3g0d8daY
         08ljHjvMsug85SSfmqaNLpuQcqDGwFsoCGb7khsGxJN+/RK3EchFOgG3XywbWtUS6P
         OMgiWUzqVWr9SVpEbLJlvP73pzgKpUVEZNer+9REsCecd2VmwXbokSYZs6XVikyGit
         9kS/Mf020nFM7lXTLO173TOdA4IcpBw31ZiHCvTj+/4fOlTcV0lTBaH24YIpw/JAV1
         Olk4tssNWhbelrXqo+GNJ8nqVRm4jqsZZzspHeatzYDAnoMILxCLXYVpR8+Vpp26+N
         SQt3spHrJmnig==
Date:   Sun, 3 Dec 2023 11:28:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dt-bindings: mfd: pm8008: clean up example node
 names
Message-ID: <20231203-snowflake-ungodly-6eeb2e7a86f1@spud>
References: <20231201164546.12606-1-johan+linaro@kernel.org>
 <20231201164546.12606-5-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+WinrxxUeO6yqKOQ"
Content-Disposition: inline
In-Reply-To: <20231201164546.12606-5-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+WinrxxUeO6yqKOQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 05:45:46PM +0100, Johan Hovold wrote:
> Devicetree node names should be generic; fix up the pm8008 binding
> example accordingly.
>=20
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Doc=
umentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> index 24c6158f73ae..32ea898e3ca9 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> @@ -88,10 +88,11 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/gpio/gpio.h>
> -    qupv3_se13_i2c {
> +    i2c {
>        #address-cells =3D <1>;
>        #size-cells =3D <0>;
> -      pm8008i@8 {
> +
> +      pmic@8 {
>          compatible =3D "qcom,pm8008";
>          reg =3D <0x8>;
> =20
> --=20
> 2.41.0
>=20

--+WinrxxUeO6yqKOQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWxmcAAKCRB4tDGHoIJi
0qSaAP9fWNhsSS3QXH+t58JYKDWfKnUQ7UEbwp5xIH3taFSCxgEAo4bGx9D5sIy3
MxUUBhXQRLNmYOZo7PO8Cm5sIGwDqA8=
=Hd/I
-----END PGP SIGNATURE-----

--+WinrxxUeO6yqKOQ--
