Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28BD7BF040
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379328AbjJJB2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379318AbjJJB2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:28:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB80DAF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 18:28:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C236C433C8;
        Tue, 10 Oct 2023 01:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696901283;
        bh=qLa+1p3hFEH4C5ncA+dpVsciI1PmFmGO7c6LI3RdMhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RIF8CTBU8X8dT/MdlyzXG7kM2jD4t7+yrpDuU11h7m0HBY6kuvPFDDQ9GDywWiPCe
         cW2pEz/wbBCa17Z+H97q3wDJqn7/MfI/yHJX6vZdoz1WCR0LrBZY2r7g081Awp71JG
         tBLKO1TxdkHnQ5vp+gm6zmMDY+yqlSJ2E+03rEd997bz2EGnr8dT4OPW0zvPwIbQf+
         X/m0wmWESQqle15i/hzMqs145sJ6hzD8zgNOG9Qm+uxQJg5WjVfbrwL5fZqSyzbUM/
         O0zoiWhSjs2U2v5siGh013zIn8abFoIxEbzkhbVMIQw72kAIMClPG4GLXvtmt+5kwG
         wVK5vSNimXTpA==
Date:   Tue, 10 Oct 2023 09:27:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mm-venice-gw73xx: add TPM device
Message-ID: <20231010012753.GQ733979@dragon>
References: <20230928201328.1945960-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928201328.1945960-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 01:13:28PM -0700, Tim Harvey wrote:
> Add the TPM device found on the GW73xx revision F PCB.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
