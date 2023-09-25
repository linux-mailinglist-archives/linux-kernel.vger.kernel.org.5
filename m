Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1707ACD21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjIYAgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIYAgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:36:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A57ABA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:36:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E55C433C8;
        Mon, 25 Sep 2023 00:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695602192;
        bh=4xkAHW62S8Jkq2mIRkEfwuSwQTNMa0OWS+USdel1b5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBgnLHgTK27vPl03/VdifTM25/q0DgZT7EznTt8KM1NjOMxty3vDItaHCa2+P6akj
         XmX+/b4Q83VVI7CXYypr7uQaaRZnAYeRoPQ3uHVDQ/S/XBx8AAqo37aZVbS1fQg0md
         7LdUcj+Cp9p2f01Iz5mFDT/6HF2ewLW3Z/a4oG5E8eTdS+BtwU4weC5kSMREf2lgoV
         SNOFcBE72MKASSAobM4Yzziwn+taqsVtp6sSU44wjKFng/sGmNp0xJylQd0dsYFufP
         bafBTKAUcDMPpZIwlraC77KooEezspuFTn6akxEXWi2pgiG+mA889Fu4CcXDON37K2
         AIz+HUvKs6T9g==
Date:   Mon, 25 Sep 2023 08:36:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     festevam@gmail.com, clin@suse.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, eagle.zhou@nxp.com,
        imx@lists.linux.dev, joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shenwei.wang@nxp.com,
        sherry.sun@nxp.com
Subject: Re: [PATCH v3 0/3] arm: dts: imx93: add edmav3 support
Message-ID: <20230925003619.GW7231@dragon>
References: <20230824165753.2953431-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824165753.2953431-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 12:57:50PM -0400, Frank Li wrote:
> edmav3 patch already accepted.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next
> 
> Add dts part for imx93
> 
> Change from v2 to v3
> - fixed Krzysztof's comments
> - drop unused fsl,edma-axi
> 
> Change from v1 to v2
> - Enable UART1 also, lpuart driver will disable dma when it is console
> 
> Frank Li (3):
>   arm64: dts: imx93: add edma1 and edma2
>   arm64: dts: imx93: add dma support for lpuart[1..8]
>   arm64: dts: imx93-evk: add uart5

Applied all, thanks!
