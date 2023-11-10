Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E23F7E8458
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346522AbjKJUlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346581AbjKJUlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:41:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749D5B70B7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:09:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E96C433CC;
        Fri, 10 Nov 2023 18:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699639673;
        bh=PwI1HMfc9Px11Tdj+NXcNTpHBZq5il3Ma/LVyONVjRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=osp9DsibB3jQ/+hYBLD4x+ZLmbK8DShmrosXu7V3XLTAGt+CCQppRvCqC0RUuKl76
         w+CtqyYCmBaJlUgB84RCCk8Wx6moRO/0qZAqlIHhRi/8FL9v7rgECe/KF9P+Hq9V6N
         L63Pdb+dHcgunih2OyOLPMMpqStmliLveJTVKL36gLi8ekdXeZj6q/oJiEQJGfWqYy
         mk/oLWpJiPnGAHL1/0xDn9xsP9YSnuCwEGpy37HAur5gk0zsVoUbhkkrcHaehDFwfp
         78HdhQk/WLs2vdMbT30r4AxXWnro9q5opjz+Try3Uen9Y785IjeRibT+QpcXkfS2GZ
         eNwKVTfKdx82Q==
Date:   Fri, 10 Nov 2023 18:07:43 +0000
From:   Conor Dooley <conor@kernel.org>
To:     zhangqing <zhangqing@rock-chips.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        andy.yan@rock-chips.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v5 3/4] dt-bindings: clock: rk3588: export PCLK_VO1GRF
 clk id
Message-ID: <20231110-dreamt-revival-5b360472febd@roley>
References: <20231108061822.4871-1-zhangqing@rock-chips.com>
 <20231108061822.4871-4-zhangqing@rock-chips.com>
 <20231108-donation-uncertain-c4d0f560c420@spud>
 <2e520a06-0ff1-76ef-2a72-ab6663738b45@rock-chips.com>
 <20231109-send-pushchair-45b37551102a@wendy>
 <a11c847c-4f95-ea7b-3497-6ada0586c486@rock-chips.com>
 <dee8031f-d739-442c-988c-3df61d92c0d3@linaro.org>
 <f013df81-670e-37c4-c1a7-e1302352ca20@rock-chips.com>
 <f58c8f3f-7b34-47e7-a33a-bddb6106fec7@linaro.org>
 <53059eca-5c55-6dde-6246-40ed9f2dca91@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OExvhfaQ444Ef20I"
Content-Disposition: inline
In-Reply-To: <53059eca-5c55-6dde-6246-40ed9f2dca91@rock-chips.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_50,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OExvhfaQ444Ef20I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Ok , I'll drop this change in PATCH V6.

> =E5=BC=A0=E6=99=B4
> =E7=91=9E=E8=8A=AF=E5=BE=AE=E7=94=B5=E5=AD=90=E8=82=A1=E4=BB=BD=E6=9C=89=
=E9=99=90=E5=85=AC=E5=8F=B8
> Rockchip Electronics Co.,Ltd
> =E5=9C=B0=E5=9D=80=EF=BC=9A=E7=A6=8F=E5=BB=BA=E7=9C=81=E7=A6=8F=E5=B7=9E=
=E5=B8=82=E9=93=9C=E7=9B=98=E8=B7=AF=E8=BD=AF=E4=BB=B6=E5=A4=A7=E9=81=9389=
=E5=8F=B7=E8=BD=AF=E4=BB=B6=E5=9B=ADA=E5=8C=BA21=E5=8F=B7=E6=A5=BC
> Add:No.21 Building, A District, No.89 Software Boulevard Fuzhou, Fujian 3=
50003, P.R.China
> Tel:+86-0591-83991906-8601
> =E9=82=AE=E7=BC=96=EF=BC=9A350003
> E-mail:elaine.zhang@rock-chips.com
> *************************************************************************=
***
> =E4=BF=9D=E5=AF=86=E6=8F=90=E7=A4=BA=EF=BC=9A=E6=9C=AC=E9=82=AE=E4=BB=B6=
=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=E6=9C=89=E6=9C=BA=E5=AF=86=E4=
=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E5=8F=91=E9=80=81=E7=BB=99=E6=9C=AC=E9=82=
=AE=E4=BB=B6=E6=89=80=E6=8C=87=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=
=E3=80=82=E8=8B=A5=E9=9D=9E=E8=AF=A5=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=
=BA=BA=EF=BC=8C=E8=AF=B7=E5=8B=BF=E5=A4=8D=E5=88=B6=E3=80=81=E4=BD=BF=E7=94=
=A8=E6=88=96=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9A=84=E4=BB=BB=
=E4=BD=95=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=
=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E4=BB=8E=E7=B3=BB=E7=BB=9F=E4=B8=AD=E6=B0=
=B8=E4=B9=85=E6=80=A7=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=
=E6=89=80=E6=9C=89=E9=99=84=E4=BB=B6=EF=BC=8C=E5=B9=B6=E4=BB=A5=E5=9B=9E=E5=
=A4=8D=E9=82=AE=E4=BB=B6=E6=88=96=E5=85=B6=E4=BB=96=E6=96=B9=E5=BC=8F=E5=8D=
=B3=E5=88=BB=E5=91=8A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=82=E7=A6=8F=
=E5=B7=9E=E7=91=9E=E8=8A=AF=E5=BE=AE=E7=94=B5=E5=AD=90=E6=9C=89=E9=99=90=E5=
=85=AC=E5=8F=B8=E6=8B=A5=E6=9C=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=BF=A1=E6=81=
=AF=E7=9A=84=E8=91=97=E4=BD=9C=E6=9D=83=E5=8F=8A=E8=A7=A3=E9=87=8A=E6=9D=83=
=EF=BC=8C=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E6=9C=AA=E7=BB=8F=E6=8E=88=E6=
=9D=83=E8=AE=B8=E5=8F=AF=E7=9A=84=E4=BE=B5=E6=9D=83=E8=A1=8C=E4=B8=BA=E3=80=
=82
>=20
> IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd=
 .The contents of this email and any attachments may contain information th=
at is privileged, confidential and/or exempt from disclosure under applicab=
le law and relevant NDA. If you are not the intended recipient, you are her=
eby notified that any disclosure, copying, distribution, or use of the info=
rmation is STRICTLY PROHIBITED. Please immediately contact the sender as so=
on as possible and destroy the material in its entirety in any format. Than=
k you.
>=20
> *************************************************************************=
***
>=20

Please also drop this legal footers.

Thanks,
Conor.

--OExvhfaQ444Ef20I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZU5xagAKCRB4tDGHoIJi
0mRqAP4yZmW1RPmA4GZetYj3jVRckaKN7UW79TtmSrKLKPJ7xwD9FbIVjxmE/4yT
Wbc/0ZnYDI9ffUVgJa9bqOCLpHMNGwk=
=z8Ye
-----END PGP SIGNATURE-----

--OExvhfaQ444Ef20I--
