Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D718E78186E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjHSIeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjHSIeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:34:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A242C643E0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 01:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FA9A629B7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 08:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523FAC433C8;
        Sat, 19 Aug 2023 08:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692434044;
        bh=wwCUl5QsaEWni/8tnEmEdBoz7BjqWG0HmqExN1a8h1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7+TMYRPbZAzGFrIWbKYSgnQ5+xBCZ2FZ2YN5xm5+JyA9ws59xdWLzt2BH57AfSn2
         B6PUp7HXiHkFfVeqt7c3yjZUZ2vY0QU79hHHo73zpG8aqQO3ujJGDoeY+vIK7b0762
         zoOPNEkbvmd3fjjRKVURyNJEo/3uuClQaIgDudvyKlBhObYATq4iVDypgwhwrq3JsX
         THO1czWR4RpMVJZbRBdjPZ0pVC8trRszEp+vthL1f8Y3WmWtGjXmd7KJy2np7Kn+3t
         WJWxqzNnRFlaJbDvkut6lCANS4yTpeq2Gr8iUHNLfvkPaKhr9ojvfJH+9AGZqryKQn
         rJ1bc4S05w5EA==
Date:   Sat, 19 Aug 2023 09:33:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yanxin Huang <yanxin.huang@unisoc.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org,
        huang yanxin <yanxin.huang07@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: Re: [PATCH 2/7] dt-bindings: nvmem: Add compatible for sharkl3,
 ums512, qogirl6, qogirn6pro, qogirn6lite
Message-ID: <20230819-glitch-spender-d1c54bea17c2@spud>
References: <20230819055141.29455-1-yanxin.huang@unisoc.com>
 <20230819055141.29455-2-yanxin.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="phbC7XWvO07X1uEQ"
Content-Disposition: inline
In-Reply-To: <20230819055141.29455-2-yanxin.huang@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--phbC7XWvO07X1uEQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 01:51:36PM +0800, Yanxin Huang wrote:

> ________________________________
>  This email (including its attachments) is intended only for the person o=
r entity to which it is addressed and may contain information that is privi=
leged, confidential or otherwise protected from disclosure. Unauthorized us=
e, dissemination, distribution or copying of this email or the information =
herein or taking any action in reliance on the contents of this email or th=
e information herein, by anyone other than the intended recipient, or an em=
ployee or agent responsible for delivering the message to the intended reci=
pient, is strictly prohibited. If you are not the intended recipient, pleas=
e do not read, copy, use or disclose any part of this e-mail to others. Ple=
ase notify the sender immediately and permanently delete this e-mail and an=
y attachments if you received it in error. Internet communications cannot b=
e guaranteed to be timely, secure, error-free or virus-free. The sender doe=
s not accept liability for any errors or omissions.
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=85=B7=
=E6=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=8F=97=E6=B3=95=E5=
=BE=8B=E4=BF=9D=E6=8A=A4=E4=B8=8D=E5=BE=97=E6=B3=84=E9=9C=B2=EF=BC=8C=E4=BB=
=85=E5=8F=91=E9=80=81=E7=BB=99=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=89=80=E6=8C=87=
=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E3=80=82=E4=B8=A5=E7=A6=81=E9=
=9D=9E=E7=BB=8F=E6=8E=88=E6=9D=83=E4=BD=BF=E7=94=A8=E3=80=81=E5=AE=A3=E4=BC=
=A0=E3=80=81=E5=8F=91=E5=B8=83=E6=88=96=E5=A4=8D=E5=88=B6=E6=9C=AC=E9=82=AE=
=E4=BB=B6=E6=88=96=E5=85=B6=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E9=9D=9E=E8=
=AF=A5=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E8=AF=B7=E5=8B=
=BF=E9=98=85=E8=AF=BB=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81 =E4=BD=BF=E7=94=
=A8=E6=88=96=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9A=84=E4=BB=BB=
=E4=BD=95=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=
=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E4=BB=8E=E7=B3=BB=E7=BB=9F=E4=B8=AD=E6=B0=
=B8=E4=B9=85=E6=80=A7=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=
=E6=89=80=E6=9C=89=E9=99=84=E4=BB=B6=EF=BC=8C=E5=B9=B6=E4=BB=A5=E5=9B=9E=E5=
=A4=8D=E9=82=AE=E4=BB=B6=E7=9A=84=E6=96=B9=E5=BC=8F=E5=8D=B3=E5=88=BB=E5=91=
=8A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=82=E6=97=A0=E6=B3=95=E4=BF=9D=
=E8=AF=81=E4=BA=92=E8=81=94=E7=BD=91=E9=80=9A=E4=BF=A1=E5=8F=8A=E6=97=B6=E3=
=80=81=E5=AE=89=E5=85=A8=E3=80=81=E6=97=A0=E8=AF=AF=E6=88=96=E9=98=B2=E6=AF=
=92=E3=80=82=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E9=94=99=
=E6=BC=8F=E5=9D=87=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E3=80=82


Please fix your mail system, this is not compatible with kernel
development.

--phbC7XWvO07X1uEQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOB+dwAKCRB4tDGHoIJi
0obSAP9AiaYlF1H4tF2SyG+VyK4BEUeibWZdU3N7CKDNBxtRAgD/XBl5ELGCKAYB
hM8cn5SLlrzx2fzjtybRxvNhGm6rlAY=
=KwYO
-----END PGP SIGNATURE-----

--phbC7XWvO07X1uEQ--
