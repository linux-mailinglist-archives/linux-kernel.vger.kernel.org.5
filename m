Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927E27F9788
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjK0CdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjK0CdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:33:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C081511F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:33:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E069C433C8;
        Mon, 27 Nov 2023 02:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701052404;
        bh=TC8bErlTXY8SMV34kwRk2apyEXaXxVE1iXS1SQVMkzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M8zq0IJIMr4irkYsiRwS0YT6Ed/dTUSuXZI+SKmUtBitPCyDUkW+sqmjJClOmi5J5
         KTXibohwgc6olsL+QkYHSKG2SWYvN29FLrxs5GkLjaAXYFrQP9HKerL9GXcam7Dczl
         t/VgAWqPLVoJxRm6zpdTmkcntL8ItzWRpO2RjCMLOO6nFbZPU6Zjf4ulfwZ4uIsbDL
         1/jwFSj+8zzSxBFFb1xY4jnQ/DqNEIk1eQdYTLrn3rec/9ebzMY3yjHM0OSGqF4ON/
         iDoYLHtbo/0/eyiEReDQpxcEvKlAtI0+7y6iHMcyrH57H2CaaPW3xajLGgEKcPfi7m
         J34NJDUTn64rg==
Date:   Mon, 27 Nov 2023 10:33:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        abelvesa@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 2/2] arm64: dts: imx93: update analog node
Message-ID: <20231127023317.GL87953@dragon>
References: <20231025072242.1134090-1-peng.fan@oss.nxp.com>
 <20231025072242.1134090-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025072242.1134090-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 03:22:42PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The analog module produces PLL and OSC for Clock Controller Module. Since
> the binding doc has been updated to clock-controller for this module,
> Let's also update the device tree node.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

s/analog/anatop

Fixed it up and applied.

Shawn
