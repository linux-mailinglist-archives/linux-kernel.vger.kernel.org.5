Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB0D7558BB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjGQAGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGQAGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:06:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FCAD3;
        Sun, 16 Jul 2023 17:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3D1C60EE2;
        Mon, 17 Jul 2023 00:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10A7C433C7;
        Mon, 17 Jul 2023 00:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689552409;
        bh=z5adB7qfGu6+f3IW5FVK6CsOLFfUrOYTr9YhLv+I454=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGFPuJt9aAKHj+6dQfLc+iPUAVtKb6DJRAmn1dT85Nkg3WSJN+pGPXtcSKc+zNzL7
         g46LtxUfTZDF5SRf5j4uXi3u7aZOXJHqLFo0e8We/MDU6rNITFM73JX4RemkkNkh7L
         H3Q/JnDcqy69U4Q6zsqverYvplELeSNkuqbQVqoIRs3IBR9gF90JufJgDfLTHCH+UY
         FYMX+WRZPDVn1JoVhXQV0iP+ZOGKCHXWKoikG2hyPR7OzNDm+ZULg0D1UcwfnN1oo9
         MOf6WfaPiBOoxh/MPrpyv58IlI3NDpmjwLDCEenfj4eKB/J3M7mgBVsNdr33eqJaUQ
         qFeSg7ud8lYCA==
Date:   Mon, 17 Jul 2023 08:06:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw7901: add cpu-supply node
 for cpufreq
Message-ID: <20230717000638.GB9559@dragon>
References: <20230606153238.1448463-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606153238.1448463-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:32:38AM -0700, Tim Harvey wrote:
> Add regulator config for cpu-supply in order to support cpufreq.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
