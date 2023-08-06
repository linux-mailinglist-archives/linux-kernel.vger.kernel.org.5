Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F3577157D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjHFN6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHFN6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:58:32 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA33103;
        Sun,  6 Aug 2023 06:58:29 -0700 (PDT)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 04F351F8DB;
        Sun,  6 Aug 2023 15:58:28 +0200 (CEST)
Received: from livingston (unknown [192.168.42.11])
        by gaggiata.pivistrello.it (Postfix) with ESMTP id 9FBC87FAF1;
        Sun,  6 Aug 2023 15:58:27 +0200 (CEST)
Received: from pivi by livingston with local (Exim 4.96)
        (envelope-from <francesco@dolcini.it>)
        id 1qSeH5-0000uS-1d;
        Sun, 06 Aug 2023 15:58:27 +0200
Date:   Sun, 6 Aug 2023 15:58:27 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
Message-ID: <ZM+nA1oY/qqyw3/s@livingston.pivistrello.it>
References: <20230719125430.249644-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719125430.249644-1-francesco@dolcini.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn

On Wed, Jul 19, 2023 at 02:54:28PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add audio support to both Dahlia and Development carrier boards
> 
> Francesco Dolcini (2):
>   arm64: dts: freescale: verdin-imx8mp: dahlia: add sound card
>   arm64: dts: freescale: verdin-imx8mp: dev: add sound card
> 
>  .../dts/freescale/imx8mp-verdin-dahlia.dtsi   | 56 ++++++++++++++++++-
>  .../boot/dts/freescale/imx8mp-verdin-dev.dtsi | 55 ++++++++++++++++--
>  2 files changed, 104 insertions(+), 7 deletions(-)

Any concern on this series?

Francesco

