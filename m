Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F08758DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGSGem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGSGel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:34:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A2A1FC0;
        Tue, 18 Jul 2023 23:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7D93611FC;
        Wed, 19 Jul 2023 06:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8C1C433CA;
        Wed, 19 Jul 2023 06:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689748479;
        bh=DC++SzU0ArlXkyCLBy3GqoRal30WHgBs6Gr4teUpvQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GOave3yKZ/oNcWg1QFZNWsCTTNRjXlkVdqycAOo7sWfK4ZnwlxBLXyIgLo+ZPhJII
         oPCLH1KPFqTkqOFyzAm2WFVh8/IFza1J4TnPbvP0HCQiOZJYnW40VwJFdUOCaN3emc
         yzujYaXnso6Pu0c5um9QpUNb3Ot0nCcDdqw1kPMpxl1NEE06FzNxcIZzyPDQaYUrn0
         vd9RoivHOUinEAxB+wH7Xf1zBJf0E06xKA2blm8oksurfOrmAdPvei4Q/8+Sm5uz9T
         vlvyD23nkVcARGxOYkAiYwSnMdFotTrZJk/I9XY1YIgI6qDAaLZYOt+JZS9Y+dZ+QR
         +VHLeRWElJBew==
Date:   Wed, 19 Jul 2023 14:34:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Chester Lin <clin@suse.com>,
        Li Yang <leoyang.li@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/3] arm64: dts: imx8qm: add cpu frequency table
Message-ID: <20230719063425.GE151430@dragon>
References: <20230713204932.1591255-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713204932.1591255-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:49:29PM -0400, Frank Li wrote:
> Add A53 and A72 opp_table.
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied all, thanks!
