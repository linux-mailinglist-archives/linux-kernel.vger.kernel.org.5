Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B47ACD4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjIYAvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjIYAvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:51:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E60CC4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:51:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF22FC433C8;
        Mon, 25 Sep 2023 00:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695603063;
        bh=8cRkjTMTmv4RdoWAOU4dPn2va1FbWd9ZOBD/CgXDuuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G8AT8ab7T0QoXxp1aE70TgDk8Ozh0Ex4JVN0f+UsPyolDWDBkbGxyFpDIi95cr+Z/
         xDmz2JapBlNBseMTQY76eaisLIi9Pp99r7n17LShuXD2+FqXzBN6jqBH2sDF13gs3n
         bO91EFTmdGVK+0Lzqv1FpP2ul/w+VDBqAToVfXDU5yRcuQgoz3y0P+c5P3q3G/lFwO
         fxx8EP0lo4LF8LWxeZRth02MooM9MYi8RUQQcPxzLYePiYXGoneBtBwqJuTGguJMSd
         AXBjbhXR8PiKQbc8uwv0Fu7aLlATcCkKAMeReCJN+gQg9iQrlXQgY5TtaLUVs7w6Gx
         cv0Uy/9WYetIQ==
Date:   Mon, 25 Sep 2023 08:50:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v2] ARM: dts: imx6qdl-gw5904: add internal mdio nodes
Message-ID: <20230925005052.GY7231@dragon>
References: <20230828192615.1202078-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828192615.1202078-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:26:15PM -0700, Tim Harvey wrote:
> Complete the switch definition by adding the internal mdio nodes.
> 
> This does not change behavior on Linux but is required if the dt is used
> for U-Boot which requires the internal PHY ports to be defined for
> DSA.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Applied, thanks!
