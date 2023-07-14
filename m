Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60DA753471
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbjGNH7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbjGNH7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:59:16 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E458C49D1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:57:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8CB5D80A8;
        Fri, 14 Jul 2023 07:56:18 +0000 (UTC)
Date:   Fri, 14 Jul 2023 10:56:17 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andrew Davis <afd@ti.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: multi_v7_defconfig: Enable OMAP audio/display
 support
Message-ID: <20230714075617.GF5194@atomide.com>
References: <20230713190114.28816-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713190114.28816-1-afd@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Davis <afd@ti.com> [230713 19:02]:
> We would like to support some additional OMAP class devices using the
> common multi_v7_defconfig. To start, enable some audio/display related
> modules:
> 
> DRM_OMAP/OMAP5_DSS_HDMI: For base DRM display support.
> DRM_TI_TFP410: Used as a display bridge for several EVM's panels.
> DRM_TI_TPD12S015: HDMI encoder on several OMAP/Sitara EVMs.
> SND_SOC_TLV320AIC3X_I2C: For I2C attached TLV320AIC3x codecs.

Reviewed-by: Tony Lindgren <tony@atomide.com>
