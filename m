Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0B375AF60
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjGTNMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjGTNMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:12:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B62D63;
        Thu, 20 Jul 2023 06:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2472361A18;
        Thu, 20 Jul 2023 13:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01427C433C8;
        Thu, 20 Jul 2023 13:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689858708;
        bh=RsluApDGubYlcvQuPdZCu3YiHOjOrpAe8QrgoHY9dTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxq3hlTC1YiTHiuYLnBqAS+MXD3438tMvekNFmqHbBFJEXqjqyoiPYhg7gl1pIMYz
         0Eqc+rSev1dMgHAL2iu/WocHz6H1cNAty12j/0IM+KFl7HnuXn/5Ri7jPueaRnmLeH
         b95Nybfptkje7JTFhR9FdkPmWr1xTTLnadhyZTBltlhEvCKTj8gM1UYDZShIVPgfT+
         V0Vr/Fpi1XKBCtbHELTJIyhBz5CvqrkaIsESPNr2XkyIG2uaWTAmdCCw8+Ta6Xv9kk
         MqEmktFZmv0n2ddJQWCINh36V7A1+Ds/oHmw+Qaoc70vgOTpnx3Ll+W91Jv0C+bFic
         VNndpBS9eeR/Q==
Date:   Thu, 20 Jul 2023 14:11:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Praveen Talari <quic_ptalari@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_vnivarth@quicinc.com,
        quic_arandive@quicinc.com
Subject: Re: [PATCH v7 1/2] soc: qcom: geni-se: Add SPI Device mode support
 for GENI based QuPv3
Message-ID: <76c4363a-e9fc-40c7-9c41-6a7a039aeb36@sirena.org.uk>
References: <20230714042203.14251-1-quic_ptalari@quicinc.com>
 <20230714042203.14251-2-quic_ptalari@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EjtGYV4TjlLFuWIo"
Content-Disposition: inline
In-Reply-To: <20230714042203.14251-2-quic_ptalari@quicinc.com>
X-Cookie: Ginger snap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EjtGYV4TjlLFuWIo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 14, 2023 at 09:52:02AM +0530, Praveen Talari wrote:
> Add device mode supported registers and masks.

Does it make sense for me to take this one via spi given how trivial it
is?

--EjtGYV4TjlLFuWIo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS5Mo4ACgkQJNaLcl1U
h9DPwQf/U6ggFChbK02Lvh/xJjg4AS95CrQz4kWRfgKVOFyaznN9fBSZfuHbeaMV
of7YzqKOGw6pvLIIa8YXGF7r94Tr96XzRykRHErENEducxNV4lf3b+2RxtTcTNxh
NUVH3cJ/imMDTMFSzIIb6nANYcCH94sEfgGFkNkONWklz8oH4e4v6id3BwmCseJw
tKyBLzprBs8RbomnuhXP21+OfDjC3bFJ7/+i5OthOcxK+tEedC8NiGoxTATl9GVf
LimFck9/yUpThsjPeLWojlQC2ESWN40z3vBuF347qtdP4KHEnMLfhtc+mDf+5P6T
9PdPwe0xZMFeyplE4xnX23s4MgB7rQ==
=J7Jx
-----END PGP SIGNATURE-----

--EjtGYV4TjlLFuWIo--
