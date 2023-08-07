Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A5F7717A4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 03:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjHGBDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 21:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHGBD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 21:03:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EDF170A;
        Sun,  6 Aug 2023 18:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5635612C4;
        Mon,  7 Aug 2023 01:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D759C433C8;
        Mon,  7 Aug 2023 01:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691370207;
        bh=qzJzJeF3KDGNJD8Wv/FELN3XntUXnugPKFsLMUTYbvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KhqubeLWh4dfo/Jvl3BM53D6nU8FHHyP8aTgGtd+N9KPXB+bfHIhniQ8rxoTYHiPV
         YqfJLs6p200Fi5ddovCKzytbf4REAGxDmVTfwOqAnRd7dfjwn7n2YvPYOVLr6JsmQK
         ceu4YzBCeimLlfvI7W30FhFzVaYBoHf9b2eKoHQ0Yyr31BRf8L8odcb7sKocKC2J+F
         yJMG34MHPfssejZ1LuOFGGH+8qzsqN7rE0RmeBxcle5Nil9vURNJHJUjHSZ5R53lB8
         luYEdGj3QEHWeEe/iQNARcCOIelW0zgG4tdwY+04rfpgcbxkt4+OJwHByjU0JVyyeQ
         viwqtVpZHKBZA==
Date:   Mon, 7 Aug 2023 09:03:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 0/2] arm64: dts: freescale: verdin-imx8mp: add sound
 card
Message-ID: <20230807010314.GJ151430@dragon>
References: <20230719125430.249644-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719125430.249644-1-francesco@dolcini.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 02:54:28PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add audio support to both Dahlia and Development carrier boards
> 
> Francesco Dolcini (2):
>   arm64: dts: freescale: verdin-imx8mp: dahlia: add sound card
>   arm64: dts: freescale: verdin-imx8mp: dev: add sound card

Applied both, thanks!
