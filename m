Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040E4812580
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442999AbjLNCuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjLNCuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:50:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7FFBD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:50:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E458C433C7;
        Thu, 14 Dec 2023 02:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702522215;
        bh=Nd9u1k7UI6o8ADnIXkQDc+MUCqxbS3DKHxdC2rMfDYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bi3XAIDEmU1Zaq7JpEPUscbyhBCJ7zjw7Wb1/ujl+qRQKfLRS9gbIJ3XNvqJCKTgc
         Wtg2c0Sn6MrPn7MlAzcfeOsyy0S3Y+f1PZ2Id3Wjr1ODgEY3me/wX8rqs8M1hmHx/j
         o+/mVai3wKOXk1NExrgO8IMeron1BNdKxmYlZhkzOE8q6vaqPQbWwOVXheb8kgHB98
         mklO03Iu2vDskCfwNEEMsfoxf1CJRr+N5+NSnidGjGS1Mzzkov+csk521eNSSkDCth
         +fzH3SFvxiQ1khXlnnJeGbtGogdSmA6H9++cESwPEWLeP8HsH/UeJTepRWgN+THvqd
         8b/3YhRa23K5g==
Date:   Thu, 14 Dec 2023 10:50:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, leoyang.li@nxp.com,
        robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2 0/3] board: imx8mn-dimonoff-gateway-evk: add support
 for Dimonoff gateway EVK board
Message-ID: <20231214025009.GB270430@dragon>
References: <20231207150519.1264808-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207150519.1264808-1-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 10:05:16AM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Hello,
> this patch series add support for the Dimonoff gateway EVK board.
> 
> Based on shawnguo/for-next branch.
> 
> Thank you.
> 
> Link: [v1] https://lore.kernel.org/all/20231206160303.33185-1-hugo@hugovil.com/
> 
> Changes for V2:
> - Add Krzysztof Acked-by tag
> - Wrap lines at 80 columns in dts
> - Remove company name from compatible property
> 
> Hugo Villeneuve (3):
>   dt-bindings: vendor-prefixes: add dimonoff
>   dt-bindings: arm: fsl: add Dimonoff gateway EVK board
>   arm64: dts: freescale: introduce dimonoff-gateway-evk board

Applied all, thanks!
