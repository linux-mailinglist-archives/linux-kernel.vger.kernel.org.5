Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A9F7F97AA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjK0CyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjK0CyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:54:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D73122
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:54:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1789C433C7;
        Mon, 27 Nov 2023 02:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701053650;
        bh=eZ3WpAPBx6kvrkV6Ye4GMDnOn030v7zZFgp5k5HgBEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4TGevd0kkEOI035uYyw3q3IgIckpUqAy8rJBi1G2rMl5sqdvnAfvLt5Nj6TMOgLM
         h01qmMX77RTmTpo6B+4mkX6r9AfiKJcTvyilhjvScvyfAa2eW4QqqM2sdLminpTQ50
         5KF3DdFy7drO71sSUxvsYiGNsve9hG5Fs4zXvp8JgIGTPS7cqDvPCgXge833muet3S
         Z13a2TLeaNCbqnZrVT18AEkijgMqEeoWJR6uo5ecQKoFflQ7hitZtCGv7wCW9fX8xr
         KLfkLzZUU9vZCqRi/2gsEOp97gohA8Cav0qR9BAYiNRgNHLm7PaquxltQXb3sfoZjR
         ye7t/h2yTVBvA==
Date:   Mon, 27 Nov 2023 10:54:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: freescale: debix-som: Add heartbeat LED
Message-ID: <20231127025402.GS87953@dragon>
References: <20231101104307.2207938-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101104307.2207938-1-kieran.bingham@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 10:43:04AM +0000, Kieran Bingham wrote:
> Map the 'RUN' LED present on the Debix-SOM as a heartbeat.
> 
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

Applied, thanks!
