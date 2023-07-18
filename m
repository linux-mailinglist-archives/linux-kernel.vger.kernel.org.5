Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A44E757F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjGROUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjGROUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486F619F;
        Tue, 18 Jul 2023 07:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2157615D9;
        Tue, 18 Jul 2023 14:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6F7C433C8;
        Tue, 18 Jul 2023 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689690020;
        bh=69f9Ow7G9SsiOy4AHNxB2+xh70U/bWAt+jbQXiCN9EE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZb1tcBRDBygRjVyPhSRssQyYE2oHpTYsXiTT1l9pKF1STlu13Iixoi8hJImAoXpO
         94EpbPYgEi6As3I8DrJtm1WZA0zP8nwvrD7bI+n7IothYlhMAzp55oWNr7XfVBvzFu
         gG93yC7kuqBdBylkdd+sLY1HzySR82keSAG5daB7knFz9yVH8K8tvDM28FyGjUrQNf
         AjY82wvZz7CcR96qMnGeM3gn3iYw5eedZfGFyTIAiZSydfHh0A8l+++FgTacwGUbeo
         TKRn7r3gyn/sn3ENLQKLOq92cw78vQTdmPC027pIcAx4x46BE2Lv0xalXTHo2YIidC
         R2IcV6i2TNu0g==
Date:   Tue, 18 Jul 2023 15:20:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] MAINTAINERS: Add Hal as a maintainer of SFCTEMP
 HWMON DRIVER
Message-ID: <20230718-progeny-edge-70b1a395f2aa@spud>
References: <20230718034937.92999-1-hal.feng@starfivetech.com>
 <20230718034937.92999-4-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+SYy1csup/eV3m/s"
Content-Disposition: inline
In-Reply-To: <20230718034937.92999-4-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+SYy1csup/eV3m/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 11:49:37AM +0800, Hal Feng wrote:
> As he is the submitter of this driver, add his mail so he can
> maintain the driver and easily reply in the mailing list.
>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aee340630eca..5056079ade77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19256,6 +19256,7 @@ F:	drivers/net/ethernet/sfc/
> =20
>  SFCTEMP HWMON DRIVER
>  M:	Emil Renner Berthing <kernel@esmil.dk>
> +M:	Hal Feng <hal.feng@starfivetech.com>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml

Whatever about the other patches in this series, this one certainly
needs an Ack from Emil.

Thanks,
Conor.

--+SYy1csup/eV3m/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLafjQAKCRB4tDGHoIJi
0ieXAPoDb+w2V0FDl4JxOKH09CNgAq/8yBxnBA358gfjau/P9QD/Rw3p/VAyVXD5
S6E/DUnzFkGfMmqp4BxxVrghLiJKjgk=
=T5XJ
-----END PGP SIGNATURE-----

--+SYy1csup/eV3m/s--
