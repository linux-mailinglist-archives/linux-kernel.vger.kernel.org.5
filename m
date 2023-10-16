Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAD77CA932
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjJPNRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjJPNRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:17:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D54AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:17:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DF8C433C8;
        Mon, 16 Oct 2023 13:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697462235;
        bh=TSb9GxD5oEeI6PePIO1j8fweqhj9PYyACbhpg9yRRMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7fgNdSxwKQ4ttsJo+HVlMcDisGXhNgNP/FcfBU30+LmCVjzYMc6peeGkKk7Zhchs
         4kBpr71VXyksh3CTaRrfZY0B/7L08C6DOZDfMaYpZnix96I9vSm2q2M8nAipp6yJPe
         kJGcFWjhC7QAnSuIKc6pkcEm6k0KdPhFouF6xc/8QAXvFfRupyCCPkNkbkHhlGyqgw
         C4g7L3xPSsT0Wh3H03UYY+XlMY1KKaVvficA3P/yoFjkIHIoSUCPMxW6KyYYWvctPo
         YDvBP9eKVA8zUgm7CzV7fCFUprNdfcoMBQEkoBL+Zryl1+0mYxy/KOHNLsKu3vLxKE
         RaQ4ZdCPd7Kfg==
Date:   Mon, 16 Oct 2023 14:17:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Re: [PATCH v3 1/2] ASoC: dt-bindings: sound-card-common: List
 DAPM endpoints ignoring system suspend
Message-ID: <09061842-ce15-4f24-8098-56ecbb4fb6a2@sirena.org.uk>
References: <20231011114759.1073757-1-chancel.liu@nxp.com>
 <f639c88d-371a-4c72-a906-47d643b24ca8@sirena.org.uk>
 <20231012204739.GA1706264-robh@kernel.org>
 <DB9PR04MB94987AD33756548323D8D101E3D7A@DB9PR04MB9498.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CxOpNCJuLtIFp8ru"
Content-Disposition: inline
In-Reply-To: <DB9PR04MB94987AD33756548323D8D101E3D7A@DB9PR04MB9498.eurprd04.prod.outlook.com>
X-Cookie: If you're happy, you're successful.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CxOpNCJuLtIFp8ru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 16, 2023 at 12:08:56PM +0000, Chancel Liu wrote:

> Thanks Mark and Rob for your advice. In fact, it's common use case. We can see
> many drivers set widgets ignoring suspend. I will remove the linux specifics
> and focus on the key concept. How about the modification on the property name
> and description as following:
>   ignore-suspend-widgets:
>     description: |
>       A list of audio sound widgets which are marked ignoring system suspend.
> 	  Paths between these endpoints are still active over suspend of the main
> 	  application processor that the current operating system is running.

That's probably fine from my point of view.  There's likely a better way
of saying system suspend but I'm not immediately seeing it and it could
always be improved later.

--CxOpNCJuLtIFp8ru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUtN9MACgkQJNaLcl1U
h9AMyAf/RUOysUsrGEWQC4UlZkLrJEHxMIM6hDxLpZweAie5qQ6rOFMl5ft3BFZC
M9J42RBQwCyAqpmArKhQR1Dr5TMgf0VdaoOmFWLc0xQpMc25W88cIEafU8y+mUua
e6K/k0aIyYZdjwkP4Es88cLi8iA9nl66TBMbNNhVCPFu4ANu/cxaDwEYfisTIfAR
JYHPBdK8nZkSRUGu15z5IswGwSChMEvpWGPfbaz030xacAabehc3JcPSUv+2ogKN
xiEDDICnrN7oi4QKyUgw+Hsd1AnWhJmU3mJ6cNrh8DStFdq1XfWFD0jzbeQLCRC2
vM+z/sNri+7PeKmxVzfVXTZTJUZkrQ==
=HWHj
-----END PGP SIGNATURE-----

--CxOpNCJuLtIFp8ru--
