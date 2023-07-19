Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D4758F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjGSHvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGSHvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:51:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ECBE60;
        Wed, 19 Jul 2023 00:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73619612FC;
        Wed, 19 Jul 2023 07:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD643C433C7;
        Wed, 19 Jul 2023 07:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689753067;
        bh=BAJRmdE6Oj35G6+Tr7t7WtcZpYWzN2VkcZH7AbETOxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJ27AMcm/JwBFNGJRHx/EBRal0oREEfdH1WOGydIfWAO4NuRKKAV/aSJ6NZ5NJnAR
         HiqqFOnnFadcdEOWOffkx23Hin5k7IFJEa49dhq6rzqsz8pI3TKxmAavKBIBh2aHs6
         knW97C6iLB2GrgZL+/lAVNqYvUAi3199Bd5cnBfUenwQuKRF6Iud0DlsiBBiBAkktI
         lLq64KXcFhcV9/vfwJWLJJsylL0kVXFJIQsVKoV+6O3RJfAU8a3/vMCBJq38RETCgm
         Yh9z8l1fm8DRD7OYs4HEn4Vqg3pLzfENtb3/NjMs/mSgMWjhFXNhpZZP2b2SaKS79C
         FjlGaqjqqBBnQ==
Date:   Wed, 19 Jul 2023 15:50:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH v3 3/3] arm64: defconfig: Enable i.MX93 devices
Message-ID: <20230719075055.GO151430@dragon>
References: <20230718085722.1198862-1-alexander.stein@ew.tq-group.com>
 <20230718085722.1198862-4-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718085722.1198862-4-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:57:22AM +0200, Alexander Stein wrote:
> These drivers are used on i.MX93 based devices.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

It doesn't apply to my imx/defconfig branch.

Shawn
