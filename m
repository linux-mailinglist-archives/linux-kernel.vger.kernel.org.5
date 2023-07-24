Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDD375FC9D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjGXQxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGXQxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:53:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945B9B7;
        Mon, 24 Jul 2023 09:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29E1061200;
        Mon, 24 Jul 2023 16:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5062CC433C8;
        Mon, 24 Jul 2023 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690217620;
        bh=sUI8nbGXKfbkOnf1U1FtAdvYS7EyxHJ5SPBJTNroeHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Psv3uMHMWvxOpR3UU4ip2U6TANdOk2/J0GpN0LcFP50qR6S/dFC2Zhv3S5B9rAPg1
         pJavVWWKR0CBZDbmr7YUxeBIa1v2fBlyFHuv0q+CSsZzXCWc4oS+q29o8nXZPm/u+/
         WoVQz6OQWO5SafaSaIBoZIpjcKjuxKp7+PdJmEIqXcN8XLNFJM6BnMU3gz7EO/3v+o
         5hUMKdg0bk0gLDKGkdZ9jC1NK5CsRrz53gNW30M3+RwWccrNv9r7LiOEB3R739+qDR
         QNqscRs99O5oExMJYGoFFnEwnnF3rWWcOPoKmjaAn4NM2DMxR35v/zepasZSnRJM6I
         ODWnCReoEamLw==
Date:   Mon, 24 Jul 2023 17:53:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support
Message-ID: <20230724-shabby-schnapps-e7254584400c@spud>
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="I4+m2N+K+88fCNVr"
Content-Disposition: inline
In-Reply-To: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I4+m2N+K+88fCNVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 02:08:47PM +0530, Komal Bajaj wrote:
> Changes in v5 -
>  - Separating this from original series [1].
>  - Added description of driver to secure qfprom binding.
>  - Replaced pm_runtime_enable() withh devm_pm_runtime_enable().
>  - Changed module license to GPL instead of GPL v2.
>=20
> This series introduces a new driver for reading secure fuse region and ad=
ding
> dt-bindings for same.
>=20
> [1] https://lore.kernel.org/linux-arm-msm/20230623141806.13388-1-quic_kba=
jaj@quicinc.com/

Why does this series have two v5s?

--I4+m2N+K+88fCNVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL6sjwAKCRB4tDGHoIJi
0jqEAP4g7a0pWuE3lDAPIZ0w1FRzful5aKlxFoPAH2OcZL5MiAEA97ZBhN+pxIKA
axYIrie6pB9WYNkGj+5jHYazau9VXAY=
=fc/V
-----END PGP SIGNATURE-----

--I4+m2N+K+88fCNVr--
