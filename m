Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C196D7613F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjGYLPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjGYLPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:15:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB28E1BF5;
        Tue, 25 Jul 2023 04:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC42561692;
        Tue, 25 Jul 2023 11:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049E1C433C7;
        Tue, 25 Jul 2023 11:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690283654;
        bh=kZj42ScISmz4li2JKwWSsvJeodC1GyqO823+DqOgMQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5pB4XYyX/A8pr8IKx/l1JTHeGyCZ2SsK+MNAA9OCo/+yt8nQFOIhMhkTmboBCRIa
         Xp3ihxmefa6W674THia7xXWtAM4Yu9bl2wwIPl/yRUdSuPeS2PaiCf2/9Akd1BvwnO
         cBstWGkYYCUsI/kBZzFxICr5JZiR7a1ULiUjF506GGI3bbeMGQheJcr1ksxZQ1bkDF
         7Z1QGX91AdC1rjoDmqEqPlRMxXWYaMMeKB0JO7l7zw9fPVenA03NcMAyeaZgYCv3d/
         qicSz1l6Hjc9RPBvMhCH/EEIJn7dl2AEvM6ZwemBYHzAES6yfKS5ai4M4KeehoFAD9
         edIEpusA7+FWA==
Date:   Tue, 25 Jul 2023 12:14:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Robin Gong <yibin.gong@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Pascal Paillet <p.paillet@foss.st.com>,
        - <patches@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 1/2] regulator: dt-bindings: add missing
 unevaluatedProperties for each regulator
Message-ID: <246eea6e-dd34-426f-9fc7-427d808fe8f0@sirena.org.uk>
References: <20230725105421.99160-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pU6qgD5QqpPaeXtO"
Content-Disposition: inline
In-Reply-To: <20230725105421.99160-1-krzysztof.kozlowski@linaro.org>
X-Cookie: BARBARA STANWYCK makes me nervous!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pU6qgD5QqpPaeXtO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2023 at 12:54:20PM +0200, Krzysztof Kozlowski wrote:
> Each regulator node, which references common regulator.yaml schema,
> should disallow additional or unevaluated properties.  Otherwise
> mistakes in properties will go unnoticed.

This doesn't apply against current code, please check and resend.

>  Documentation/devicetree/bindings/regulator/ti,tps65090.yaml  | 1 +

This doesn't seem to be upstream.

--pU6qgD5QqpPaeXtO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS/rn4ACgkQJNaLcl1U
h9Aqggf/aDeIQ1IKzvUqzKpJJNCra6EytL7wUkPxFef7t8RGjNvn50RLK+/3lwv6
iQvyVaumklG1HDAgEHWjfQd6nOOzvoRxmX057o9Tq7cTt57Btvvo6/Oqd8qmMKgK
j0+UTFnUtRp2K2IJ7BB5Apv8aOSvp0yRjqXuZ+U4Eb75NrjHKzpNB2Izroh/Jipt
M8DeS5IYFX/hDBqWt/DJ7IbwoP7HWkTqcR/7uNjnamhgK13y3Snq2TN1R2GuG+YO
CxwwBz4b+xImipL+7fNZRKWE0vz1L5VtyVwwcSfCYwDBNDnObJVmeL2nDM0ndPXD
r1+ge6uWiU507QcyrTs0YVStltnPEQ==
=jUXK
-----END PGP SIGNATURE-----

--pU6qgD5QqpPaeXtO--
