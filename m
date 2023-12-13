Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01246810C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378773AbjLMIMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378748AbjLMIMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:12:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309E6B2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:12:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E430C433C7;
        Wed, 13 Dec 2023 08:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702455150;
        bh=6cLOPwMjvibdut8r74sh4DxCF/rsyHgNZEROG+kEFS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJdSEwliaWDOQ8h2zpaMPCQFomNMzh/55V7/+H/gp/dXljDPmlxrGtx6XFFm1tQE/
         8gmLtvdsVItk/iYq7mWa9d2KFH9OBN571ISMYXNHcczop0WG8zwYPAqYoJgvBboISu
         BzcTBdad+gI+5/jhTQaz+w6MIlSyvQhvB0ogrkAnSAjr0FHtJQqw+cXWc/8T++FJfT
         DGGCcTHZbhKBXykiJ0AZcaoB81ELuuCBErPaeL0KYEgZD0r1K2T9+TMwNYDVKG9fCV
         b3gsDzzmj2JhUaPnwEW7VySWloSD1GzirhhRK1uCQf23Fz1h8RMjfu1NRnONhXUM0j
         s072YauCltlFw==
Date:   Wed, 13 Dec 2023 16:12:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     miquel.raynal@bootlin.com, alexander.stein@ew.tq-group.com,
        alexandre.belloni@bootlin.com, conor+dt@kernel.org,
        conor.culhane@silvaco.com, conor@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, haibo.chen@nxp.com,
        imx@lists.linux.dev, joe@perches.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-i3c@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, ping.bai@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, sherry.sun@nxp.com,
        xiaoning.wang@nxp.com
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: imx93: add i3c1 and i3c2
Message-ID: <20231213081223.GH270430@dragon>
References: <20231017194657.3199749-1-Frank.Li@nxp.com>
 <20231017194657.3199749-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017194657.3199749-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 03:46:57PM -0400, Frank Li wrote:
> Add I3C1 and I3C2.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!
