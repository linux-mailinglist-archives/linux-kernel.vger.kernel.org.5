Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2147F9728
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 02:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjK0B2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 20:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjK0B2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 20:28:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D72E3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 17:28:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0362DC433C8;
        Mon, 27 Nov 2023 01:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701048498;
        bh=pMn0ALzR57zJy6WWUl9/MYezMl/SFwEMMySu1BA/Gfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4nAgSuQLTaMv2Iln2/7AiGra7MQK3QQBm4kqJ/R0X01Xh+DDrZqLz7m+CpZmfU6Y
         6715YG45kizVIM94jaJSbJXf+hh9NL1OzJOja3lYsqL4dlQhdHBokV1AR+B4qA1agY
         L7gEDz64U3bG+nTAQ7yitUpPi+sawZ8vKhdnuqgReEi6g2Gg6SWz0kpnKqG0jiGaQ9
         6luRLfhyEj+EoPmU5Fx2gEnqV5LJkmCJWfgmpH6qls2Y/2pldPmdFnJrN7Q7ri7bbm
         wPtfbIUTTROdZZ6TLl3xj2KzraOKUOPpty4j4lL/b/sroSA+hCoGx+2HPFsWHXNbQ2
         9/DyZFjzTZGtg==
Date:   Mon, 27 Nov 2023 09:28:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 1/3] arm64: dts: imx93: Add audio device nodes
Message-ID: <20231127012811.GB87953@dragon>
References: <20231122101959.30264-1-chancel.liu@nxp.com>
 <20231122101959.30264-2-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122101959.30264-2-chancel.liu@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 06:19:57PM +0800, Chancel Liu wrote:
> Add audio devices nodes including SAI, MICFIL, XCVR and MQS.
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

Applied, thanks!
